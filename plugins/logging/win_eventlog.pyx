# -*- coding: utf-8 -*-

# standard library imports

# third party imports

# application/library imports
from libs.handlers.logging cimport BaseHandler
import libs.handlers.logging
import libs.common
from c_windows_data_types cimport WCHAR, DWORD, WORD, HANDLE, LPCWSTR
from c_windows cimport RegisterEventSourceW, ReportEventW, DeregisterEventSource, GetLastError, EVENTLOG_SUCCESS, EVENTLOG_AUDIT_FAILURE, EVENTLOG_AUDIT_SUCCESS, EVENTLOG_ERROR_TYPE, EVENTLOG_INFORMATION_TYPE, EVENTLOG_WARNING_TYPE
from cpython.ref cimport PyObject

log_interface = "win_event_log"

#cdef class WinEventLogHandler(libs.handlers.logging.BaseHandler):
cdef class WinEventLogHandler(BaseHandler):

    cdef public unicode _app_name
    cdef HANDLE _h_event_log
    cdef public object _log_info_target
    cdef public object _log_warn_target
    cdef public object _log_err_target
    cdef public object _log_debug_target

    def __cinit__(self):
        self._app_name = u'PI'
        self._h_event_log = RegisterEventSourceW(NULL, self._app_name)

    def __init__(self, **kwargs):
        #libs.handlers.logging.BaseHandler.__init__(self)
        BaseHandler.__init__(self)

        self._log_info_target = EVENTLOG_INFORMATION_TYPE
        self._log_warn_target = EVENTLOG_WARNING_TYPE
        self._log_err_target = EVENTLOG_ERROR_TYPE
        self._log_debug_target = EVENTLOG_INFORMATION_TYPE

        for key, value in kwargs.iteritems():
            if key == 'log_info':
                self._log_info = libs.common.str2bool(value)
            elif key == 'log_warn':
                self._log_warn = libs.common.str2bool(value)
            elif key == 'log_err':
                self._log_err = libs.common.str2bool(value)
            elif key == 'log_debug':
                self._log_debug = libs.common.str2bool(value)

    cdef bint _log(self, WORD target, unicode msg):
        cdef:
            WORD category_id = 0
            DWORD event_id = 0
            DWORD dw_event_data_size = 0
            LPCWSTR _msg = <LPCWSTR>msg

        #msg = msg.decode('UTF-8')

        if (self._h_event_log == NULL):
            return False

        dw_event_data_size = (<DWORD>len(msg) + 1) * sizeof(WCHAR)
        if not ReportEventW(self._h_event_log, target, category_id, event_id, NULL, 0, dw_event_data_size, &_msg, NULL):
            return False

        #pInsertStrings[0] = msg;
        #if not ReportEvent(self._h_event_log, EVENTLOG_ERROR_TYPE, DATABASE_CATEGORY, MSG_BAD_FILE_CONTENTS, NULL, 1, 0, (LPCWSTR*)pInsertStrings, NULL):
        #    pass
        return True

    def log_err(self, unicode msg):
        if self._log_err:
            self._log(self._log_err_target, msg)

    def log_info(self, unicode msg):
        if self._log_info:
             self._log(self._log_info_target, msg)

    def log_warn(self, unicode msg):
        if self._log_warn:
            self._log(self._log_warn_target, msg)

    def log_debug(self, unicode msg):
        if self._log_debug:
            self._log(self._log_err_debug, msg)

    def __dealloc__(self):
        if self._h_event_log:
            DeregisterEventSource(self._h_event_log)


def register_handler(plugins):
    plugins[log_interface] = WinEventLogHandler
    return (log_interface, WinEventLogHandler)