# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import tempfile

# third party imports


# application/library imports
import libs.handlers.protocol
import libs.common

# standard library cimports
from cpython.ref cimport PyObject

# application/library cimports

from libs.handlers.protocol cimport BaseHandler
from c_windows_data_types cimport DWORD, LPWSTR
from c_windows cimport WNetAddConnection2W, RESOURCETYPE_DISK, CONNECT_TEMPORARY, WNetCancelConnection2W, STARTF_USESTDHANDLES, STARTF_USESHOWWINDOW, SW_HIDE, CREATE_NEW_CONSOLE, CreateProcess, CloseHandle, INFINITE, WaitForSingleObject, GetExitCodeProcess, GetLastError, PROCESS_INFORMATION, STARTUPINFO, NETRESOURCEW
from libs.handlers.config cimport STATUS_SOURCE, ss__cmd, ss__connection_handler, ss__protocol, STATUS_TYPES, st__info, st__success, st__warn, st__error


url_prefix = "smb://"


#cdef class SMBHandler(libs.handlers.protocol.BaseHandler):
cdef class SMBHandler(BaseHandler):

    cdef:
        public object _drive
        public bint _connected
        bint _buffer_data

    def __cinit__(self):
        self._url_prefix = url_prefix
        self._drive = None

    def __init__(self, log, status_handler, unicode url, username=None, password=None, log_info=True, log_warn=True, log_err=True, log_debug=False, **kwargs):
        #libs.handlers.protocol.BaseHandler.__init__(self, log, url, username=username, password=password, log_info=log_info, log_warn=log_warn, log_err=log_err, log_debug=log_debug)
        self._url_prefix = url_prefix
        BaseHandler.__init__(self, log, status_handler, url, username=username, password=password, log_info=log_info, log_warn=log_warn, log_err=log_err, log_debug=log_debug)

        self._connected = False
        self._buffer_data = kwargs.get("buffer_data", False)

    def is_connected(self):
        return self._connected

    def connect(self):
        cdef:
            NETRESOURCEW nr        
            DWORD ret_val
            object url
        url = self._strip_url_prefix(self._url)
        nr.dwType = RESOURCETYPE_DISK
        if self._drive is None:
            nr.lpLocalName = NULL
        else:
            nr.lpLocalName = self._drive
        #print url
        nr.lpRemoteName = <LPWSTR>url
        nr.lpProvider = NULL 

        self._log_debug("[smb] [%d] connecting to: %s" % (libs.common.get_current_line_nr(), self._url))
        if self._status_handler is not None:
            status_id = self._status_handler.set_status(ss__connection_handler, st__info, u"smb", 1, u"Connecting to %s..." % self._url)

        #win32wnet.WNetAddConnection2(win32netcon.RESOURCETYPE_DISK, self._drive, self._strip_url_prefix(self._url), None, self._username, self._password)

        ret_val = WNetAddConnection2W(&nr, self._password, self._username, CONNECT_TEMPORARY)
        if ret_val == 0:
            self._connected = True
        elif ret_val == 1219:
            self._connected = True
            self._log_err("[smb] [%d] %s already connected" % (libs.common.get_current_line_nr(), self._url))
            if self._status_handler is not None:
                status_id = self._status_handler.set_status(ss__protocol, st__info, u"smb", ret_val, u"%s already connected!" % self._url)
        elif ret_val == 53:
            # https://technet.microsoft.com/en-us/library/cc940100.aspx
            err_text = "NetBIOS name resolution failed or NetBIOS session could not be established. To distinguish between these two cases follow this instructions: https://technet.microsoft.com/en-us/library/cc940100.aspx or meet a (hot) wisewoman."
            self._log_err("[smb] [%d] %s %s" % (libs.common.get_current_line_nr(), self._url, err_text))
            if self._status_handler is not None:
                status_id = self._status_handler.set_status(ss__protocol, st__error, u"smb", ret_val, u"%s" % err_text)
            raise libs.handlers.protocol.ConnectionError(err_text)
        else:
            self._log_err("[smb] [%d] %s Unknown Error: %s" % (libs.common.get_current_line_nr(), self._url, ret_val))

    def disconnect(self):
        cdef DWORD ret_val
        #self._status_handler.set_status(unsigned int source_id, unsigned char status_type, unsigned int status_id, unicode description)
        self._log_debug("[smb] [%d] disconnecting from: %s" % (libs.common.get_current_line_nr(), self._url))
        ret_val = WNetCancelConnection2W(
            self._strip_url_prefix(self._url),
            0,
            True
        )
        self._connected = False

    cdef unicode _download_file(self, unicode url):
        cdef:
            object local_file
            object file_name
            object file_extension
            object data
            object path
        file_name, file_extension = os.path.splitext(url)
        local_file = tempfile.NamedTemporaryFile(delete=False, suffix=file_extension)
        path = local_file.name
        f = open(url, "r")
        data = f.read()
        local_file.write(data)
        local_file.close()
        return path

    def get_file(self, path):
        self.connect()
        path = self._strip_url_prefix(path)
        if self._buffer_data:
            return self._download_file(path)
        else:
            return path

    def execute(self, unicode cmd):
        cdef:
            object args
            int ret_value = 0
            DWORD last_error_code = 0
        self.connect()
        args = libs.win.commandline.parse(cmd, True)
        if args[0].startswith(self._url_prefix):
            args[0] = self._strip_url_prefix(args[0])
        cmd = (u'"%s" %s' if " " in args[0] else u'%s %s') % (args[0], libs.win.commandline.merge(args[1:]))
        if self._status_handler is not None:
            status_id = self._status_handler.set_status(ss__connection_handler, st__info, u"smb", 1, u"Executng file: %s." % cmd)
        self._log_debug("[smb] [%d] executing: %s" % (libs.common.get_current_line_nr(), cmd))
        #ret_code = win32api.WinExec(cmd)
        ret_value = self._execute(cmd, &last_error_code)
        #print "last error", last_error_code
        return ret_value


def register_handler(plugins):
    plugins[url_prefix[:-3]] = SMBHandler
    return (url_prefix, SMBHandler)