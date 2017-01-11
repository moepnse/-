# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import time
import struct
import threading

# third party imports

# application/library imports
from libs.handlers.status import INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_WARN, SEND_INFO_ERROR, SEND_DONE
from c_windows_data_types cimport LPVOID, DWORD, HANDLE
from c_windows cimport ReadFile, CreateFileW, CloseHandle, OPEN_EXISTING, GENERIC_READ, WaitForSingleObject, WAIT_OBJECT_0, WAIT_TIMEOUT, INVALID_HANDLE_VALUE, GetLastError

cdef class Log:

    def _log_info(self, msg):
        if self._log is not None:
            self._log.log_info(msg)

    def _log_warn(self, msg):
        if self._log is not None:
            self._log.log_warn(msg)

    def _log_err(self, msg):
        if self._log is not None:
            self._log.log_err(msg)

    def _log_debug(self, msg):
        if self._log is not None:
            self._log.log_deb(msg)


cdef class NamedPipeHandler(Log):

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

    def __init__(self, log=None):
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
            self._log_err(u"ReadFile failed with Error: %d" % GetLastError())
        self._log_debug(u"bytes to read: %d bytes read: %d" % (bytes_to_read, dw_bytes_read))
        if bytes_to_read != dw_bytes_read:
            self._log_err(u"Error: %d (bytes_to_read) > %d (bytes_read)" % (bytes_to_read, dw_bytes_read))
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

    def _handle_send_status(self, package_id, package_name, action):
        pass

    def _handle_send_info(self, info_type, info_text):
        pass

    def _handle_send_done(self):
        self._log_info(u"done!")

    def __handle_data(self):
        cdef:
            unsigned char action = 0
            unsigned char package_id_length = 0
            unsigned char package_name_length = 0
            bytes data
            DWORD dw_bytes_read = 0
            unsigned char info_type = 0
            unsigned int info_text_length = 0
        self._log_debug(u"got data!")
        data = self.read(1)
        # get response type
        response_type = struct.unpack('!B', data)[0]
        self._log_debug(u"response type: %d" % response_type)
        if response_type == SEND_STATUS:
            # get action and package id length
            data = self.read(2)
            self._log_debug(u"data length: %d" % len(data))
            action, package_id_length = struct.unpack('!BB', data)
            self._log_debug(u"action: %d" % action)
            # get package id
            data = self.read(package_id_length)
            self._log_debug(u"package_id_length: %s" % len(data))
            package_id = struct.unpack('!%ds' % package_id_length, data)[0]
            self._log_debug(package_id)
            # get package name length
            data = self.read(1)
            package_name_length = struct.unpack('!B', data)[0]
            # get package name
            data = self.read(<DWORD>package_name_length)
            self._log_debug(u"%d %d" % (package_name_length, len(data)))
            package_name = struct.unpack('!%ds' % package_name_length, data)[0]
            self._log_debug(u"package_name: %s" % package_name)
            self._handle_send_status(package_id, package_name, action)
        elif response_type == SEND_INFO:
            data = self.read(5)
            info_type, info_text_length = struct.unpack('!BI', data)
            self._log_debug(u"info_text_length: %d" % <DWORD>info_text_length)
            data = self.read(<DWORD>info_text_length)
            info_text = struct.unpack('!%ds' % info_text_length, data)[0]
            self._handle_send_info(info_type, info_text)
        elif response_type == SEND_DONE:
            self._handle_send_done()
            self.close()
            return False
        else:
            self._log_err(u"response type %d unknown" % response_type)
        return True

    def _start_status_loop(self):

        try:
            while 1:
                self._log_debug(u"waiting for data...")
                rc = self.wfso(15)
                if rc == WAIT_OBJECT_0:
                    if not self.__handle_data():
                        break
                elif rc == WAIT_TIMEOUT:
                    pass
        except Exception as e:
            self._log_err(u"Error: %s" % str(e))
        self.close()

    def run(self):
        self.open()
        self._version = self.get_version()
        if self._version == 1:
            self._start_status_loop()
        else:
            self._log_err(u"Wrong Protocol Version!")


class NamedPipeThread(NamedPipeHandler, threading.Thread):

    def __init__(self, log):
        threading.Thread.__init__(self)
        NamedPipeHandler(log).__init__(self)
