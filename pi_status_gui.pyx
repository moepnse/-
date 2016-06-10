# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import time
import struct
import threading
import StringIO

# third party imports
import wx

# application/library imports
from package_installer import get_application_path, INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_WARN, SEND_INFO_ERROR, SEND_DONE
from c_windows_data_types cimport LPVOID, DWORD, HANDLE
from c_windows cimport ReadFile, CreateFile, CloseHandle, OPEN_EXISTING, GENERIC_READ, WaitForSingleObject, WAIT_OBJECT_0, WAIT_TIMEOUT, INVALID_HANDLE_VALUE, GetLastError
from cpython.ref cimport PyObject


cdef class Log:

    cdef:
        bint _debug
        bint _err
        bint _info

    def __cinit__(self, info, err, debug):
        self._info = info
        self._err = err
        self._debug = debug

    def log_debug(self, msg):
        if self._debug:
            print msg

    def log_err(self, msg):
        if self._err:
            print msg

    def log_info(self, msg):
        if self._info:
            print msg


class StdInThread(threading.Thread):

    def __init__(self, stdin, pi_status_gui):
        threading.Thread.__init__(self)
        self._stdin = stdin
        self._pi_status_gui = pi_status_gui;

    def run(self):
        self._pi_status_gui._lb_packages.Append(("thread test",))
        data = self._stdin.readline()
        self._pi_status_gui._lb_packages.Append(("thread test",))
        if data != "":
            action, package_id_length = struct.unpack('!BB', data[:2])
            package_id = struct.unpack('!%ds' % package_id_length, data[2:])[0]
            #result, data = win32file.ReadFile(self._ph, 1)
            package_name_length = struct.unpack('!B', data)
            #result, data = win32file.ReadFile(self._ph, package_name_length)
            package_name = struct.unpack('!%ds' % package_name_length, data)[0]
            if action == INSTALLING:
                self._pi_status_gui._lb_packages.Append((package_id,))
            self._pi_status_gui._lb_packages.SetItemColumnImage(self._pi_status_gui._lb_packages.GetItemCount() - 1, 0, self._pi_status_gui._status_img_mapping[action])


class EOF(Exception):

    def __init__(self, path):
        self._path = path

    def __str__(self):
        return repr(self._path)


class AnimatedImgFrame(object):

    def __init__(self, duration, img_type, img):
        self._duration = duration
        self._img_type = img_type
        self._img = img

    @property
    def duration(self):
        return self._duration

    @property
    def img_type(self):
        return self._img_type

    @property
    def img(self):
        return self._img


class AnimatedImg(object):

    def __init__(self, path, log):
        self._path = path
        self._fh = open(path, 'rb')
        self._frames = []
        self._index = 0
        self._log = log
        try:
            while 1:
                self._frames.append(self._get_next_frame())
        except EOF as err:
            pass
        self._frame_count = len(self._frames)

    def _get_frame_information(self):
        data = self._fh.read(12)
        if not data:
            raise EOF(self._path)
        # NEED FIX!
        #self._log.log_debug(u"img_data: %s" % data)
        return struct.unpack('IBI', data)

    def _get_image(self, img_size):
        data = self._fh.read(img_size)
        return struct.unpack('%ds' % img_size, data)[0]

    def _get_next_frame(self):
        duration, img_type, img_size = self._get_frame_information()
        img = self._get_image(img_size)
        return AnimatedImgFrame(duration, img_type, img)

    def get_next_frame(self):
        if self._index == self._frame_count:
            self._index = 0
        frame = self._frames[self._index]
        self._index += 1
        return frame

    def next(self):
        return self._frames.next()

    def __iter__(self):
        return self._frames.__iter__()

    def __len__(self):
        return self._frames.__len__()

    def __getitem__(self, key):
        return self._frames[key]


class wxAnimatedImg(AnimatedImg):

    def __init__(self, path, log):
        AnimatedImg.__init__(self, path, log)

    def _get_next_frame(self):
        duration, img_type, img_size = self._get_frame_information()
        img = self._get_image(img_size)
        return AnimatedImgFrame(duration, img_type, wx.BitmapFromImage(wx.ImageFromStream(StringIO.StringIO(img))))


cdef class NamedPipeHandler:

    cdef:
        HANDLE _ph
        str _pipe_name
        int _pipe_wait_timeout
        unsigned char _steps
        unsigned char _version
        object _fh_named_pipe_log
        object _log

    def __cinit__(self):
        self._pipe_name = r'\\.\pipe\pi_status_gui'
        self._pipe_wait_timeout = 2000
        #self._open()

    def __init__(self, log):
        self._log = log

    cpdef open(self):
        self._ph = CreateFile(self._pipe_name,
            GENERIC_READ,
            0, 
            NULL, # No special security requirements
            OPEN_EXISTING,
            0, # Not creating, so attributes dont matter.
            NULL)
        self._fh_named_pipe_log = open('np_client.log', 'w')
        if self._ph == INVALID_HANDLE_VALUE:
            print "Could not open pipe: %s. Error Nr.: %d" % (self._pipe_name, GetLastError())

    cpdef close(self):
        CloseHandle(self._ph)
        self._fh_named_pipe_log.close()

    cdef DWORD c_wfso(self, int timeout):
        cdef:
            HANDLE ph = self._ph
            DWORD ret_val = 0
        with nogil:
            ret_val = WaitForSingleObject(ph, 100)
        return ret_val

    cpdef DWORD wfso(self, int timeout):
        with nogil:
            return WaitForSingleObject(self._ph, 100)

    cdef bint c_read(self, LPVOID data, DWORD bytes_to_read):
        cdef:
            DWORD dw_bytes_read = 0
            bint ret_val = 0
        with nogil:
            ret_val = ReadFile(self._ph, data, bytes_to_read, &dw_bytes_read, NULL)
        print "ret_val: %d" % ret_val
        print "bytes to read: %d bytes read: %d" % (bytes_to_read, dw_bytes_read)
        #self._fh_named_pipe_log.write(data)
        #self._fh_named_pipe_log.flush()
        return ret_val

    def read(self, DWORD bytes_to_read):
        cdef:
            char* data = ""
            DWORD dw_bytes_read = 0
            bint ret_val = 0
            object ret_data
        with nogil:
            ret_val = ReadFile(self._ph, data, bytes_to_read, &dw_bytes_read, NULL)
        #ret_val = ReadFile(self._ph, data, bytes_to_read, NULL, NULL)
        if ret_val != 1:
            self._log.log_err(u"ReadFile failed with Error: %d" % GetLastError())
        self._log.log_debug(u"bytes to read: %d bytes read: %d" % (bytes_to_read, dw_bytes_read))
        if bytes_to_read != dw_bytes_read:
            self._log.log_err(u"Error: %d (bytes_to_read) > %d (bytes_read)" % (bytes_to_read, dw_bytes_read))
        #self._fh_named_pipe_log.write(<bytes>data)
        #self._fh_named_pipe_log.flush()
        ret_data = <object>data[:bytes_to_read]
        return ret_data

    cpdef unsigned char get_steps(self):
        cdef char* data = ""
        self.c_read(data,  1)
        self._steps = struct.unpack('!B', data[:1])[0]
        return self._steps

    #cpdef int get_version(self):
    cpdef unsigned char get_version(self):
        cdef char* data = ""
        self.c_read(data,  1)
        self._version = struct.unpack('!B', data[:1])[0]
        return self._version


class NamedPipeThread(threading.Thread):

    def __init__(self, pi_status_gui, log, close_when_done = False):
        threading.Thread.__init__(self)
        self._nph = NamedPipeHandler(log)
        self._pi_status_gui = pi_status_gui
        self._close_when_done = close_when_done
        self._log = log

    def _start_status_loop(self):
        cdef:
            unsigned char action = 0
            unsigned char package_id_length = 0
            unsigned char package_name_length = 0
            bytes data
            DWORD dw_bytes_read = 0
            unsigned char info_type = 0
            unsigned int info_text_length = 0
        try:
            while 1:
                self._log.log_debug(u"waiting for data...")
                rc = self._nph.wfso(15)
                self._log.log_debug(u"got data!")
                if rc == WAIT_OBJECT_0:
                    data = self._nph.read(1)
                    # get response type
                    response_type = struct.unpack('!B', data)[0]
                    self._log.log_debug(u"response type: %d" % response_type)
                    if response_type == SEND_STATUS:
                        # get action and package id length
                        data = self._nph.read(2)
                        self._log.log_debug(u"data length: %d" % len(data))
                        action, package_id_length = struct.unpack('!BB', data)
                        self._log.log_debug(u"action: %d" % action)
                        # get package id
                        data = self._nph.read(package_id_length)
                        self._log.log_debug(u"package_id_length: %s" % len(data))
                        package_id = struct.unpack('!%ds' % package_id_length, data)[0]
                        self._log.log_debug(package_id)
                        # get package name length
                        data = self._nph.read(1)
                        package_name_length = struct.unpack('!B', data)[0]
                        # get package name
                        data = self._nph.read(<DWORD>package_name_length)
                        self._log.log_debug(u"%d %d" % (package_name_length, len(data)))
                        package_name = struct.unpack('!%ds' % package_name_length, data)[0]
                        self._log.log_debug(u"package_name: %s" % package_name)
                        if action == INSTALLING:
                            self._pi_status_gui._lb_packages.Append(("Installing %s (%s)..." % (package_name, package_id),))
                        elif action == REMOVING:
                            self._pi_status_gui._lb_packages.Append(("Removing %s (%s)..." % (package_name, package_id),))
                        elif action == UPGRADING:
                            self._pi_status_gui._lb_packages.Append(("Upgrading %s (%s)..." % (package_name, package_id),))
                        else:
                            self._log.log_err(u"Action %d unknown!" % action)
                        self._pi_status_gui._lb_packages.SetItemColumnImage(self._pi_status_gui._lb_packages.GetItemCount() - 1, 0, self._pi_status_gui._status_img_mapping[action])
                        self._pi_status_gui._pb_status.progress += 1
                    elif response_type == SEND_INFO:
                        data = self._nph.read(5)
                        info_type, info_text_length = struct.unpack('!BI', data)
                        self._log.log_debug(u"info_text_length: %d" % <DWORD>info_text_length)
                        data = self._nph.read(<DWORD>info_text_length)
                        info_text = struct.unpack('!%ds' % info_text_length, data)[0]
                        self._pi_status_gui._lb_packages.Append((info_text,))  
                        if info_type == <unsigned char>SEND_INFO_ERROR:
                            icon = self._pi_status_gui._ix_img_index
                        elif info_type == <unsigned char>SEND_INFO_SUCCESS:
                            icon = self._pi_status_gui._ih_img_index
                        self._pi_status_gui._lb_packages.SetItemColumnImage(self._pi_status_gui._lb_packages.GetItemCount() - 1, 0, icon)
                    elif response_type == SEND_DONE:
                        self._log.log_info(u"pi_service is done!")
                        self._nph.close()
                        break
                    else:
                        self._log.log_err(u"response type %d unknown" % response_type)
                    if self._pi_status_gui._lb_packages.GetItemCount() > 0:
                        self._pi_status_gui._lb_packages.EnsureVisible(self._pi_status_gui._lb_packages.GetItemCount()-1)
                elif rc == WAIT_TIMEOUT:
                    pass    
        except Exception as e:
            self._log.log_err(u"Error: %s" % str(e))
        self._nph.close()
        # Does not work!
        #  PyAssertionError: C++ assertion "wxThread::IsMain()" failed at ..\..\src\common\timercmn.cpp(66) in wxTimerBase::Start(): timer can only be started from the main thread
        #self._pi_status_gui._timer_done.Start(10000, wx.TIMER_ONE_SHOT)
        if self._close_when_done:
            self._log.log_info(u"Waiting 10 seconds before close...")
            time.sleep(10)
            self._log.log_info(u"Good bye! :-)")
            self._pi_status_gui.Close()
            sys.exit(0)

    def run(self):
        self._pi_status_gui._lb_packages.Append(("Starting NP Thread...",))
        self._pi_status_gui._lb_packages.SetItemColumnImage(self._pi_status_gui._lb_packages.GetItemCount() - 1, 0, self._pi_status_gui._i_img_index)

        self._pi_status_gui._lb_packages.Append(("Waiting for NP...",))
        self._pi_status_gui._lb_packages.SetItemColumnImage(self._pi_status_gui._lb_packages.GetItemCount() - 1, 0, self._pi_status_gui._i_img_index)
        self._nph.open()
        # Waits until either a time-out interval elapses or an instance of the specified named pipe is available to be connected to
        #win32pipe.WaitNamedPipe(self._pipe_name, self._pipe_wait_timeout)
        self._version = self._nph.get_version()
        if self._version == 1:
            self._pi_status_gui._lb_packages.Append(("Protocol Version: %d" % self._version,))
            self._pi_status_gui._lb_packages.SetItemColumnImage(self._pi_status_gui._lb_packages.GetItemCount() - 1, 0, self._pi_status_gui._i_img_index)
            self._steps = self._nph.get_steps()
            self._log.log_debug(u"steps: %d" % self._steps)
            self._pi_status_gui._pb_status.max = self._steps
            self._pi_status_gui._pb_status.progress = 0
            self._start_status_loop()
        else:
            self._pi_status_gui._lb_packages.Append(("Wrong Protocol Version!",))
            self._pi_status_gui._lb_packages.SetItemColumnImage(self._pi_status_gui._lb_packages.GetItemCount() - 1, 0, self._pi_status_gui._x_img_index)



class SimpleProgressBar(wx.Panel):

    def __init__(self, parent, id=-1, pos=(0,0), size=(100,20), progress=19, bg_color=wx.WHITE, progressbar_color=wx.GREEN, max=100, **kwargs):
        wx.Panel.__init__(self, parent, id, pos, size, **kwargs)
        self.max = max
        self._progress_panel = wx.Panel(self, -1, (0, 0), (1, self.GetSize()[1]))
        self.bg_color  = bg_color
        self.progressbar_color = progressbar_color
        self.progress = progress

    @property
    def progress(self):
        return self._progress

    @progress.setter
    def progress(self, value):
        self._progress = value
        if(value < 0 ):
            value = 0
        elif(value > self.max):
            value = self.max
        self._progress = value
        if self.max == 0:
            width = self.GetSize()[0]
        else:
            width = self.GetSize()[0] * value / self.max
        if(width < 1):
            width = 1
        self._progress_panel.SetSize((width, self.GetSize()[1]))

    @property
    def bg_color(self):
        return self._bg_color

    @bg_color.setter
    def bg_color(self, value):
        self._bg_color = value
        self.SetBackgroundColour(value)

    @property
    def progressbar_color(self):
        return self._bg_color

    @progressbar_color.setter
    def progressbar_color(self, value):
        self._progressbar_color = value
        self._progress_panel.SetBackgroundColour(value)


class PIStatusGUI(wx.Frame):
    def __init__(self, log):
        wx.Frame.__init__(self, None, -1, "Package Installer", style = wx.FRAME_SHAPED | wx.SIMPLE_BORDER)
        self._log = log
        #self._nph = NamedPipeHandler()
        #self._ph = win32file.CreateFile(r'\\.\pipe\pi_status_gui',
        #      win32file.GENERIC_READ,
        #      0, 
        #      None, # No special security requirements
        #      win32file.OPEN_EXISTING,
        #      0, # Not creating, so attributes dont matter.
        #      None)
        #self._nph.open()
        self._icon_width = 16
        self._icon_height = 16
        self._done = None
        self._app_path = get_application_path()
        self._config_path = os.path.join(self._app_path, 'pi_status_gui.conf')

        self._parse_config()
        # Load the image
        image = wx.Image(self._bg, wx.BITMAP_TYPE_PNG)
        image.SetMaskColour(*self._mask)
        image.SetMask(True)
        self._bmp = wx.BitmapFromImage(image)

        self.Center()
        self.SetClientSize((self._bmp.GetWidth(), self._bmp.GetHeight()))
        dc = wx.ClientDC(self)
        dc.DrawBitmap(self._bmp, 0, 0, True)
        self.SetWindowShape()

        self._lb_packages = wx.ListCtrl(self, pos=self._lb_pos, size=self._lb_size, style=wx.LC_REPORT | wx.BORDER_NONE)

        self._load_image_list_bmps()
        self._create_image_list()

        self._status_img_mapping = {INSTALLING: self._w_img_index, 
                                    INSTALLED: self._h_img_index,
                                    UPGRADING: self._w_img_index, 
                                    UPGRADED: self._h_img_index,
                                    REMOVING: self._w_img_index, 
                                    REMOVED: self._h_img_index,
                                    FAILED: self._x_img_index,
                                    UNKNOWN: self._u_img_index}

        self._lb_packages.SetImageList(self._image_list, wx.IMAGE_LIST_SMALL)

        self._lb_packages.InsertColumn(0, "Packages")
        self._lb_packages.SetColumnWidth(0, 200)
        #self._lb_packages.InsertColumn(1, "Status")

        self._pb_status = SimpleProgressBar(self, pos=self._pb_pos, size=self._pb_size, progressbar_color=self._pb_bar_color, bg_color=self._pb_bg_color, style=wx.NO_BORDER)

        self._timer = wx.Timer(self)
        #self._timer_done = wx.Timer(self)

        self.Bind(wx.EVT_LEFT_DOWN, self.OnLeftDown)
        self.Bind(wx.EVT_LEFT_UP, self.OnLeftUp)
        self.Bind(wx.EVT_MOTION, self.OnMouseMove)
        self.Bind(wx.EVT_RIGHT_UP, self.OnExit)
        self.Bind(wx.EVT_PAINT, self.OnPaint)
        self.Bind(wx.EVT_WINDOW_CREATE, self.SetWindowShape)

        self.Bind(wx.EVT_TIMER, self._update, self._timer)
        #self.Bind(wx.EVT_TIMER, self.OnExit, self._timer_done)
        #self._timer.Start(self._frame.duration, wx.TIMER_ONE_SHOT)

    def _load_image_list_bmps(self):

        # load animated image
        self._aimg = wxAnimatedImg(self._wait_icon_path, self._log)

        # load static images and convert them to bitmaps
        self._i_bmp = wx.BitmapFromImage(wx.Image(self._info_icon_path, wx.BITMAP_TYPE_PNG))
        self._h_bmp = wx.BitmapFromImage(wx.Image(self._status_success_icon_path, wx.BITMAP_TYPE_PNG))
        self._x_bmp = wx.BitmapFromImage(wx.Image(self._status_failed_icon_path, wx.BITMAP_TYPE_PNG))
        self._u_bmp = wx.BitmapFromImage(wx.Image(self._status_unknown_icon_path, wx.BITMAP_TYPE_PNG))
        self._ix_bmp = wx.BitmapFromImage(wx.Image(self._info_error_icon_path, wx.BITMAP_TYPE_PNG))
        self._ih_bmp = wx.BitmapFromImage(wx.Image(self._info_success_icon_path, wx.BITMAP_TYPE_PNG))

    def _create_image_list(self):

        # create image list
        self._image_list = wx.ImageList(self._icon_width, self._icon_height)

        # fill image list with bitmaps
        self._i_img_index = self._image_list.Add(self._i_bmp)
        self._h_img_index = self._image_list.Add(self._h_bmp)
        self._x_img_index = self._image_list.Add(self._x_bmp)
        self._u_img_index = self._image_list.Add(self._u_bmp)
        self._ih_img_index = self._image_list.Add(self._ih_bmp)
        self._ix_img_index = self._image_list.Add(self._ix_bmp)

        # get next frame
        self._frame = self._aimg.get_next_frame()
        # add frame image to image list
        self._w_img_index = self._image_list.Add(self._frame.img)

    def _update(self, evt):
        # get next frame from antimated image
        self._frame = self._aimg.get_next_frame()
        # replace old frame in the image list with the new one
        self._image_list.Replace(self._w_img_index, self._frame.img)
        # force a refresh of the last entry
        self._lb_packages.RefreshItem(self._lb_packages.GetItemCount() - 1)
        # start the timer again
        self._timer.Start(self._frame.duration, wx.TIMER_ONE_SHOT)

    def _config_handle_color(self, color_str):
        red, green, blue = color_str.split(',')
        return (int(red), int(green), int(blue))

    def _config_handle_geometry(self, value):
        g1, g2 = value.split(',')
        return (int(g1), int(g2))

    def _parse_config(self):

        # open config file
        fh_config = open(self._config_path, 'r')

        # default values
        # Window
        self._mask = (76, 76, 76)
        self._bg = r'imgs\adp_bg.png'
        # Listbox
        self._lb_pos = (310, 76)
        self._lb_size = (247, 206)
        # Progressbar
        self._pb_pos = (242, 278)
        self._pb_size = (247, 18)
        self._pb_bg_color = (255, 255, 255)
        self._pb_bar_color = (0, 75, 116)
        # icons
        self._status_success_icon_path = r'imgs\icons\16x16\h.png'
        self._status_failed_icon_path = r'imgs\icons\16x16\x.png'
        self._status_unknown_icon_path = r'imgs\icons\16x16\u.png'
        self._info_icon_path = r'imgs\icons\16x16\i.png'
        self._wait_icon_path = r'imgs\icons\16x16\w.aimg'
        self._info_success_icon_path = r'imgs\icons\16x16\ih.png'
        self._info_error_icon_path = r'imgs\icons\16x16\ix.png'

        # handle each config line
        for line in fh_config:
            key, value = line.split('=')
            key = key.strip()
            value = value.strip()
            if key == 'bg':
                self._bg = value
            elif key == 'mask':
                self._mask = self._config_handle_color(value)
            elif key == 'lb_pos':
                x, y = value.split(',')
                self._lb_pos = self._config_handle_geometry(value)
            elif key == 'lb_size':
                width, height = value.split(',')
                self._lb_size = self._config_handle_geometry(value)
            elif key == 'pb_pos':
                x, y = value.split(',')
                self._pb_pos = self._config_handle_geometry(value)
            elif key == 'pb_size':
                self._pb_size = self._config_handle_geometry(value)
            elif key == 'pb_bg_color':
                self._pb_bg_color = self._config_handle_color(value)
            elif key == 'pb_bar_color':
                self._pb_bar_color = self._config_handle_color(value)
            elif key == 'status_success_icon':
                self._status_success_icon_path = value
            elif key == 'status_failed_icon':
                self._status_failed_icon_path = value
            elif key == 'status_unknown_icon':
                self._status_unknown_icon_path = value
            elif key == 'info_icon':
                self._info_icon_path = value
            elif key == 'wait_icon':
                self._wait_icon_path = value
            #elif key == 'border':
                #if value == 'border_none':
                #    self._lb_border = 

        # get absolute path
        self._bg = os.path.join(self._app_path, self._bg)
        self._status_success_icon_path = os.path.join(self._app_path, self._status_success_icon_path)
        self._status_failed_icon_path = os.path.join(self._app_path, self._status_failed_icon_path)
        self._status_unknown_icon_path = os.path.join(self._app_path, self._status_unknown_icon_path)
        self._info_icon_path = os.path.join(self._app_path, self._info_icon_path)
        self._wait_icon_path = os.path.join(self._app_path, self._wait_icon_path)
        self._info_success_icon_path = os.path.join(self._app_path, self._info_success_icon_path)
        self._info_error_icon_path = os.path.join(self._app_path, self._info_error_icon_path)

    def SetWindowShape(self, evt=None):
        r = wx.RegionFromBitmap(self._bmp)
        self.SetShape(r)

    def OnPaint(self, evt):
        dc = wx.PaintDC(self)
        dc.DrawBitmap(self._bmp, 0, 0, True)

    def OnExit(self, evt):
        self.Close()

    def OnLeftDown(self, evt):
        self.CaptureMouse()
        pos = self.ClientToScreen(evt.GetPosition())
        origin = self.GetPosition()
        self.delta = wx.Point(pos.x - origin.x, pos.y - origin.y)

    def OnMouseMove(self, evt):
        if evt.Dragging() and evt.LeftIsDown():
            pos = self.ClientToScreen(evt.GetPosition())
            newPos = (pos.x - self.delta.x, pos.y - self.delta.y)
            self.Move(newPos)

    def OnLeftUp(self, evt):
        if self.HasCapture():
            self.ReleaseMouse()


"""  
cdef DWORD thread(LPVOID lpParam):
    cdef:
        object pi_status_gui;

    pi_status_gui = <object>lpParam

    return 0

cdef main():
    cdef:
        DWORD dw_thread_id = 0

    ret_val = CreateThread( 
            NULL,                   # default security attributes
            0,                      # use default stack size  
            thread,                 # thread function name
            pDataArray[i],          # argument to thread function 
            0,                      # use default creation flags 
            &dw_thread_id)   # returns the thread identifier 
"""


cdef main():
    cdef:
        bint close_when_done = False
        bint info = True
        bint err = True
        bint debug = False
        object arg
        object pi_status_gui
        object np_thread

    sys.stdout = open("pi_status_gui.log.out", "a")
    sys.stderr = open("pi_status_gui.log.err", "a")

    for arg in sys.argv:
        if arg in ("/close-when-done", "/close_when_done", "/cwd"):
            close_when_done = True
        elif arg == "/debug":
            debug = True
        elif arg == "/silent":
            info = False
            err = False
    log = Log(info, err, debug)
    app = wx.PySimpleApp()
    pi_status_gui = PIStatusGUI(log)
    pi_status_gui.Show()
    #stdin_thread = StdInThread(sys.stdin, pi_status_gui)
    #stdin_thread.start()
    np_thread = NamedPipeThread(pi_status_gui, log, close_when_done)
    np_thread.start()
    app.MainLoop()


if __name__ == '__main__':
    main()