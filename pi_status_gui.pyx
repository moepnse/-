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
from libs.pi_status_gui import PIStatusGUI
from libs.handlers.status import INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_WARN, SEND_INFO_ERROR, SEND_DONE
from c_windows_data_types cimport LPVOID, DWORD, HANDLE
from c_windows cimport ReadFile, CreateFileW, CloseHandle, OPEN_EXISTING, GENERIC_READ, WaitForSingleObject, WAIT_OBJECT_0, WAIT_TIMEOUT, INVALID_HANDLE_VALUE, GetLastError
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


cdef class NamedPipeHandler:

    cdef:
        HANDLE _ph
        unicode _pipe_name
        int _pipe_wait_timeout
        unsigned char _steps
        unsigned char _version
        object _fh_named_pipe_log
        object _log

    def __cinit__(self):
        self._pipe_name = unicode(r'\\.\pipe\pi_status_gui')
        self._pipe_wait_timeout = 2000
        #self._open()

    def __init__(self, log):
        self._log = log

    cpdef open(self):
        self._ph = CreateFileW(self._pipe_name,
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
            unsigned int package_status_index = 0
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
                        if action in (INSTALLING, REMOVING, UPGRADING):
                            package_status_index = self._pi_status_gui._lb_packages.GetItemCount()
                        if action == INSTALLING:
                            self._pi_status_gui._lb_packages.Append(("Installing %s (%s)..." % (package_name, package_id),))
                        elif action == REMOVING:
                            self._pi_status_gui._lb_packages.Append(("Removing %s (%s)..." % (package_name, package_id),))
                        elif action == UPGRADING:
                            self._pi_status_gui._lb_packages.Append(("Upgrading %s (%s)..." % (package_name, package_id),))
                        else:
                            self._log.log_err(u"Action %d unknown!" % action)
                        self._pi_status_gui._lb_packages.SetItemColumnImage(package_status_index, 0, self._pi_status_gui._status_img_mapping[action])
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
                    self._auto_scroll()
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

    def _auto_scroll(self):
        item_count = self._pi_status_gui._lb_packages.GetItemCount()
        if item_count > 0:
            self._pi_status_gui._lb_packages.EnsureVisible(item_count - 1)

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