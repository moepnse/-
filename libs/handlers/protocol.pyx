# -*- coding: utf-8 -*-

# standard library imports
import os
import re
import time
import hashlib
#import subprocess

# third party imports


# application/library imports
import libs.win.commandline


# standard library cimports
from cpython.ref cimport PyObject
from libc.stdio  cimport fflush, stdout
from libc.stdlib cimport malloc, free

# application/library cimports
from c_windows_data_types cimport DWORD, BOOL, ULONG, LPCWSTR, LPWSTR, LPCTSTR, wchar_t, size_t, LPVOID, HANDLE
from c_windows cimport CopyFileW, STARTF_USESTDHANDLES, STARTF_USESHOWWINDOW, SW_HIDE, CREATE_NEW_CONSOLE, CreateProcessW, CloseHandle, INFINITE, WaitForSingleObject, GetExitCodeProcess, GetLastError, PROCESS_INFORMATION, STARTUPINFOW, NETRESOURCE, INFINITE, wcscpy, wcslen, wcscpy_s, SecureZeroMemory, CREATE_UNICODE_ENVIRONMENT, CreateEnvironmentBlock, GetUserProfileDirectoryW, CreateProcessAsUserW, PWTS_SESSION_INFOW, WTSQueryUserToken, DuplicateTokenEx,LPSECURITY_ATTRIBUTES, WTSActive, WTS_CURRENT_SERVER_HANDLE,  TOKEN_ASSIGN_PRIMARY, TOKEN_ALL_ACCESS, SecurityImpersonation, TokenPrimary, WTSEnumerateSessionsW, WTS_SESSION_INFOW, LOBYTE, HIBYTE, LOWORD, GetVersion 
from libs.handlers.config cimport STATUS_SOURCE, ss__cmd, ss__connection_handler, ss__protocol, STATUS_TYPES, st__info, st__success, st__warn, st__error


url_prefix = "url_prefix://"

URL_PREFIX_REGEX = re.compile('([a-zA-Z0-9]+)://')



cdef unicode ireplace(unicode text, unicode old, unicode new):
    """
    case insensitive replace
    """
    cdef:
        Py_ssize_t idx = 0
        Py_ssize_t index_l
    while idx < len(text):
        index_l = text.lower().find(old.lower(), idx)
        if index_l == -1:
            return text
        text = text[:index_l] + new + text[index_l + len(old):]
        idx = index_l + len(old)
    return text


class FileNotFound(Exception):
    pass


class ConnectionError(Exception):
    pass


class AuthenticationError(Exception):
    pass


cdef class BaseHandler:

    def __cinit__(self):
        self._url_prefix = url_prefix

    def __init__(self, object log, object status_handler, object url, object username=None, object password=None, bint log_info=True, bint log_warn=True, bint log_err=True, bint log_debug=False, **kargs):
        self._log = log
        self._status_handler = status_handler
        self._url = url
        self._username = username
        self._password = password
        self.__log_info = log_info
        self.__log_warn = log_warn
        self.__log_err = log_err
        self.__log_debug = log_debug
        self._plugin_name = self._url_prefix[:-3]

    def _log_info(self, unicode msg):
        #if self.__log_info and 'log_info' in self._log:
        if self.__log_info:
            self._log.log_info(msg)

    def _log_warn(self, unicode msg):
        #if self.__log_warn and 'log_warn' in self._log:
        if self.__log_warn:
            self._log.log_warn(msg)

    def _log_err(self, unicode msg):
        #if self.__log_err and 'log_err' in self._log:
        if self.__log_err:
            self._log.log_err(msg)

    def _log_debug(self, unicode msg):
        #if self.__log_debug and 'log_debug' in self._log:
        if self.__log_debug:
            self._log.log_debug(msg)

    def _strip_url_prefix(self, unicode url):
        return url[len(self._url_prefix):]

    def is_responsible(self, url):
        #args = libs.win.commandline.parse(url)
        #exe = args[0]
        #is_responsible = exe.startswith(self._url) or exe[len(self._url_prefix):].startswith(self._url)
        is_responsible = url.startswith(self._url) or url[len(self._url_prefix):].startswith(self._url)
        self._log_debug(u"[base_handler (%s)] [%d] is responsible: %s" % (self._plugin_name, libs.common.get_current_line_nr(), is_responsible))
        if is_responsible:
            if not self._status_handler is None:
                status_id = self._status_handler.set_status(ss__connection_handler, st__info, self._plugin_name.decode("utf-8"), 1, u"Plugin \"%s\" is responsible for URL \"%s\"." % (self._plugin_name, url))
        return is_responsible

    def connect(self):
        pass

    def disconnect(self):
        pass

    def is_connected(self):
        return True

    def get_path(self, unicode path):
        self.connect()
        if path.startswith(self._url_prefix):
           path = path[len(self._url_prefix):]
        return path

    def open(self, path, mode='r'):
        self.connect()
        return open(path, mode)

    def check_md5(self, path, md5sum):
        md5 = hashlib.md5()
        f = self.open(path, 'rb')
        while True:
            data = f.read(128)
            if not data:
                break
            md5.update(data)
        return md5sum == md5.hexdigest()

    cdef HANDLE _get_current_user_token(self):
        IF UNAME_SYSNAME == "Windows":
            cdef:
                HANDLE current_token = NULL
                HANDLE primary_token = NULL
                ULONG dw_session_id = 0
                #LPWSTR win_station_name = ""
                HANDLE h_user_token = NULL
                HANDLE h_token_dup = NULL
                PWTS_SESSION_INFOW p_session_info = NULL
                DWORD dw_count = 0
                DWORD i = 0
                WTS_SESSION_INFOW si
                BOOL b_ret = False

            # Get the list of all terminal sessions
            WTSEnumerateSessionsW(WTS_CURRENT_SERVER_HANDLE, 0, 1, &p_session_info, &dw_count)
            # look over obtained list in search of the active session
            for i in range(0, dw_count):
                si = p_session_info[i]
                if WTSActive == si.State:
                    # If the current session is active – store its ID
                    dw_session_id = si.SessionId
                    #win_station_name = si.pWinStationName
                    break
            self._log.log_debug(u"[protocol/%s] Session ID: %d" % (self._plugin_name, dw_session_id))
            #self._log.log_debug(u"[protocol/%s] WinStation: %s" % win_station_name)

            # Get token of the logged in user by the active session ID
            b_ret = WTSQueryUserToken(dw_session_id, &current_token)
            if b_ret == False:
                self._log.log_err(u"[protocol/%s] WTSQueryUserToken: %d" % (self._plugin_name, GetLastError()))
                return <HANDLE>0
            b_ret = DuplicateTokenEx(current_token, TOKEN_ASSIGN_PRIMARY | TOKEN_ALL_ACCESS, <LPSECURITY_ATTRIBUTES>0, SecurityImpersonation, TokenPrimary, &primary_token)
            if b_ret == False:
                self._log.log_err(u"[protocol/%s] Cannot duplicate Token!" % (self._plugin_name))
                self._log.log_err(u"[protocol/%s] DuplicateTokenEx: %d" % (self._plugin_name, GetLastError()))
                return <HANDLE>0
            return primary_token
        ELSE:
            return NULL

    cdef long long _execute_as_user(self, unicode cmd):
        IF UNAME_SYSNAME == "Windows":
            cdef:
                STARTUPINFOW si
                PROCESS_INFORMATION pi
                bint ret_val = False
                DWORD ret_code = -1
                DWORD create_flags = 0
                Py_ssize_t length = len(cmd)
                wchar_t* w_cmd = <wchar_t*>malloc(32768)
                str key = ""
                HANDLE h_token = NULL
                LPVOID lp_environment = NULL
                #wchar_t sz_user_profile_dir[MAX_PATH]
                wchar_t sz_user_profile_dir[32768]
                #DWORD cch_user_profile_dir = ARRAYSIZE(sz_user_profile_dir)
                DWORD cch_user_profile_dir = <DWORD>(32768 / sizeof(wchar_t))

            h_token = self._get_current_user_token()
            if h_token == <HANDLE>0:
                self._log.log_err(u"[protocol/%s] Invalid Token!" % (self._plugin_name))
                return -1
            CreateEnvironmentBlock(&lp_environment, h_token, True)
            for key in os.environ:
                #cmd = cmd.replace(u"%%%s%%" % key.decode("utf-8"), os.environ[key].decode("utf-8"))
                cmd = ireplace(cmd, u"%%%s%%" % key.decode("utf-8"), os.environ[key].decode("utf-8"))
            self._log.log_debug("u[protocol/%s] environment variables: %s" % (self._plugin_name, os.environ))
            self._log.log_debug("u[protocol/%s] _execute_as_user: %s" % (self._plugin_name, cmd))
            wcscpy_s(w_cmd, length * sizeof(wchar_t), <wchar_t*>cmd)
            SecureZeroMemory(&pi, sizeof(pi))
            SecureZeroMemory(&si, sizeof(si))
            #si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW
            si.lpDesktop = <bytes>u"winsta0\\default"
            si.cb = sizeof(si)
            create_flags = CREATE_NEW_CONSOLE | CREATE_UNICODE_ENVIRONMENT
            # Retrieve the path to the root directory of the user's profile.
            if not GetUserProfileDirectoryW(h_token, sz_user_profile_dir, &cch_user_profile_dir):
                self._log.log_err(u"[protocol/%s] GetUserProfileDirectoryW: %d." % (self._plugin_name, GetLastError()))
                return -1
            self._log.log_debug(u"[pi_serivce] User Profile Directory: %s" % (self._plugin_name, sz_user_profile_dir))
            self._log.log_debug(u"[protocol/%s] CreateProcessAsUserW: %s" % (self._plugin_name, cmd))
            ret_val = CreateProcessAsUserW(
                h_token,
                NULL,                   # No module name (use command line)
                w_cmd,                  # Command line
                NULL,                   # Process handle not inheritable
                NULL,                   # Thread handle not inheritable
                False,                  # Set handle inheritance to FALSE
                create_flags,           # creation flags
                lp_environment,         # environment block
                sz_user_profile_dir,    # starting directory 
                &si,                    # Pointer to STARTUPINFOW structure
                &pi)                    # Pointer to PROCESS_INFORMATION structure
            if ret_val == False:
                self._log.log_err(u"[protocol/%s] CreateProcessAsUserW failed (%d)." % (self._plugin_name, GetLastError()))
                return -1
            # Wait until child process exits.
            WaitForSingleObject(pi.hProcess, INFINITE)

            if not GetExitCodeProcess(pi.hProcess, &ret_code):
                self._log.log_err(u"[protocol/%s] GetExitCodeProcess failed with error %d" % GetLastError())
            # Close process and thread handles. 
            CloseHandle(pi.hProcess)
            CloseHandle(pi.hThread)
            free(w_cmd)
            return ret_code
        ELSE:
            return -1

    cdef long long _execute(self, unicode cmd, DWORD* last_error_code):
        IF UNAME_SYSNAME == "Windows":

            cdef:
                STARTUPINFOW si
                PROCESS_INFORMATION pi
                bint ret_val = False
                DWORD create_flags = 0
                # ExitCode
                long long ret_code = -1
                DWORD _ret_code
                Py_ssize_t length = len(cmd)
                #wchar_t* w_cmd = <wchar_t*>malloc((length+1) * sizeof(wchar_t)) 32768
                wchar_t* w_cmd = <wchar_t*>malloc(32768)
                #wchar_t* w_cmd = <wchar_t*>cmd
                str key = ""
                DWORD error_code = 0
            for key in os.environ:
                #cmd = cmd.replace(u"%%%s%%" % key.decode("utf-8"), os.environ[key].decode("utf-8"))
                cmd = ireplace(cmd, u"%%%s%%" % key.decode("utf-8"), os.environ[key].decode("utf-8"))
            self._log_debug(u"[protocol/%s] environment variables: %s" % (self._plugin_name, os.environ))
            self._log_debug(u"[protocol/%s] _execute: %s" % (self._plugin_name, cmd))
            wcscpy_s(w_cmd, length * sizeof(wchar_t), <wchar_t*>cmd)
            SecureZeroMemory(&pi, sizeof(pi))
            SecureZeroMemory(&si, sizeof(si))
            si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW
            si.wShowWindow = SW_HIDE
            si.cb = sizeof(si)
            create_flags = CREATE_NEW_CONSOLE | CREATE_UNICODE_ENVIRONMENT
            ret_val = CreateProcessW(
                NULL,           # No module name (use command line)
                w_cmd,          # Command line
                NULL,           # Process handle not inheritable
                NULL,           # Thread handle not inheritable
                False,          # Set handle inheritance to FALSE
                create_flags,   # creation flags
                NULL,           # Use parent's environment block
                NULL,           # Use parent's starting directory 
                &si,            # Pointer to STARTUPINFOW structure
                &pi)            # Pointer to PROCESS_INFORMATION structure
            if ret_val == False:
                error_code = GetLastError()
                self._log_err(u"[protocol/%s] CreateProcess failed (%d)." % (self._plugin_name, error_code))
            else:
                # Wait until child process exits.
                WaitForSingleObject(pi.hProcess, INFINITE)
                if not GetExitCodeProcess(pi.hProcess, &_ret_code):
                    error_code = GetLastError()
                    self._log_err(u"[protocol/%s] GetExitCodeProcess failed with error code %d" % error_code)
                else:
                    ret_code = _ret_code
            # Close process and thread handles. 
            CloseHandle(pi.hProcess)
            CloseHandle(pi.hThread)
            free(w_cmd)
            last_error_code[0] = error_code
            return ret_code
        ELSE:
            return -1

    def execute(self, unicode cmd):
        IF UNAME_SYSNAME == "Windows":
            cdef:
                long long ret_value = -1
                DWORD dw_version = 0; 
                DWORD dw_major_version = 0
                DWORD dw_minor_version = 0
                #DWORD dw_build = 0
                DWORD last_error_code = 0

            self._log_debug(u"[protocol/%s] execute: %s" % (self._plugin_name, cmd))
            self.connect()
            args = libs.win.commandline.parse(cmd)
            if args[0].startswith(self._url_prefix):
                args[0] = args[0][len(self._url_prefix):]
            cmd = u" ".join(args)
            dw_version = GetVersion()
            dw_major_version = <DWORD>(LOBYTE(LOWORD(dw_version)))
            dw_minor_version = <DWORD>(HIBYTE(LOWORD(dw_version)))
            if dw_major_version >= 6 and dw_minor_version >= 0:
                ret_value = self._execute_as_user(cmd)
            else:
                ret_value = self._execute(cmd, &last_error_code)
            return ret_value
            #ret_code = subprocess.call(args)
            #return ret_code
        ELSE:
            return -1

    def copy(self, source, target):
        self.connect()

        IF UNAME_SYSNAME == "Windows":
            if not CopyFileW(source, target, 0):
                self._log_err(u"[protocol/%s] CopyFile failed with Error: %d" % (self._plugin_name, GetLastError()))

    def __exit__(self, type, value, traceback):
        self.disconnect()


def register_handler(plugins):
    plugins[url_prefix] = BaseHandler
    return (url_prefix, BaseHandler)