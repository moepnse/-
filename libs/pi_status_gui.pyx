# -*- coding: utf-8 -*-

# standard library imports
import os
import StringIO

# third party imports
import wx

# application/library imports
from libs.handlers.status import INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_WARN, SEND_INFO_ERROR, SEND_DONE
from libs.handlers.config cimport st__info, st__success, st__warn, st__error
from libs.common import get_application_path
from libs.aimg import AnimatedImg, AnimatedImgFrame


class wxAnimatedImg(AnimatedImg):

    def __init__(self, path, log):
        AnimatedImg.__init__(self, path, log)

    def _get_next_frame(self):
        duration, img_type, img_size = self._get_frame_information()
        img = self._get_image(img_size)
        return AnimatedImgFrame(duration, img_type, wx.BitmapFromImage(wx.ImageFromStream(StringIO.StringIO(img))))


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
    def __init__(self, log=None):
        wx.Frame.__init__(self, None, -1, "Package Installer", style = wx.FRAME_SHAPED | wx.SIMPLE_BORDER)
        self._package_status_mapping = {}
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

    def add_package_status(self, package_id, package_name, status):
        package_status_index = self._lb_packages.GetItemCount()
        self._package_status_mapping[package_id] = package_status_index
        if status == INSTALLING:
            self._lb_packages.Append(("Installing %s (%s)..." % (package_name, package_id),))
        elif status == REMOVING:
            self._lb_packages.Append(("Removing %s (%s)..." % (package_name, package_id),))
        elif status == UPGRADING:
            self._lb_packages.Append(("Upgrading %s (%s)..." % (package_name, package_id),))
        self._lb_packages.SetItemColumnImage(package_status_index, 0, self._status_img_mapping[status])
        self._pb_status.progress += 1
        return package_status_index

    def update_package_status_by_id(self, package_id, status):
        package_status_index = self._package_status_mapping[package_id]
        self.update_package_status_by_index(package_status_index, status)

    def update_package_status_by_index(self, index, status):
        self._lb_packages.SetItemColumnImage(index, 0, self._status_img_mapping[status])
        self._pb_status.progress += 1

    def add_info(self, unsigned char info_type, info_text):
        self._lb_packages.Append((info_text,))
        if info_type == st__info:
            icon = self._i_img_index
        elif info_type == st__error:
            icon = self._ix_img_index
        elif info_type == st__success:
            icon = self._ih_img_index
        elif info_type == st__warn:
            icon = self._ix_img_index
        else:
            icon = self._u_img_index
        self._lb_packages.SetItemColumnImage(self._lb_packages.GetItemCount() - 1, 0, icon)