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
from libs.np_client import NamedPipeThread


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



class NamedPipeThread(NamedPipeThread):

    def __init__(self, pi_status_gui, log, close_when_done = False):
        NamedPipeThread.__init__(self, log)
        self._pi_status_gui = pi_status_gui
        self._close_when_done = close_when_done

    def _handle_send_status(self, package_id, package_name, action):
        cdef:
            unsigned int package_status_index = 0
        if action in (INSTALLING, REMOVING, UPGRADING):
            package_status_index = self._pi_status_gui.add_package_status(package_id, package_name, action)
        elif action in (INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN):
            self._pi_status_gui.update_package_status_by_id(package_id, action)
        else:
            self._log.log_err(u"Action %d unknown!" % action)

    def _handle_send_info(self, info_type, info_text):
        self._pi_status_gui.add_status(info_type, info_text)

    def _handle_send_done(self):
        self._log.log_info(u"pi_service is done!")

    def _handle_data(self):
        NamedPipeThread.handle_data(self)
        self._auto_scroll()

    def _start_status_loop(self):
        NamedPipeThread._start_status_loop(self)
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