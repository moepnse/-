# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import httplib
import urlparse
import struct
import threading
import StringIO

# third party imports
import win32api
import win32pipe
import win32file
import win32event
import pywintypes

# application/library imports
from package_installer import get_application_path, INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_ERROR


class EOF(Exception):

    def __init__(self, path):
        self._path = path

    def __str__(self):
        return repr(self._path)


class NamedPipe(object):

    def __init__(self, start_url, pronounce_steps_url, status_url, stop_url):
        self._pipe_name = r'\\.\pipe\pi_status_gui'
        self._pipe_wait_timeout = 2000
        self._pronounce_steps_url = pronounce_steps_url
        self._pronounce_steps_r = urlparse.urlparse(pronounce_steps_url)
        self._status_url = status_url
        self._status_r = urlparse.urlparse(status_url)
        self._start_r = urlparse.urlparse(start_url)
        self._stop_r = urlparse.urlparse(stop_url)

    def _get_version(self):
        result, data = win32file.ReadFile(self._ph, 1)
        self._version = struct.unpack('!B', data)[0]

    def _get_steps(self):
        result, data = win32file.ReadFile(self._ph, 1)
        steps = struct.unpack('!B', data)[0]
        self._conn = httplib.HTTPConnection(self._pronounce_steps_r.hostname)
        url = "/%s?%s" % (self._pronounce_steps_r.path, self._pronounce_steps_r.query % ({'action': 'pronounce_steps', 'steps': steps}))
        print "?", url, "?"
        self._conn.request("GET", url)
        r = self._conn.getresponse()
        print r.status, r.reason

    def _start_status_loop(self):
        try:
            while 1:
                result, data = win32file.ReadFile(self._ph, 1)
                response_type = struct.unpack('!B', data)[0]
                if response_type == SEND_STATUS:
                    result, data = win32file.ReadFile(self._ph, 2)
                    action, package_id_length = struct.unpack('!BB', data)
                    result, data = win32file.ReadFile(self._ph, package_id_length)
                    package_id = struct.unpack('!%ds' % package_id_length, data)[0]
                    result, data = win32file.ReadFile(self._ph, 1)
                    package_name_length = struct.unpack('!B', data)[0]
                    result, data = win32file.ReadFile(self._ph, package_name_length)
                    package_name = struct.unpack('!%ds' % package_name_length, data)[0]
                    self._conn = httplib.HTTPConnection(self._status_r.hostname)
                    url = "/%s?%s" % (self._status_r.path, self._status_r.query % ({'package_id': package_id, 'package_name': package_name, 'action': action}))
                    print "?", url, "?"
                    self._conn.request("GET", url)
                    r = self._conn.getresponse()
                    print r.status, r.reason
        except pywintypes.error:
            pass
        win32api.CloseHandle(self._ph)

    def run(self):
        self._conn = httplib.HTTPConnection(self._start_r.hostname)
        url = "/%s?%s" % (self._start_r.path, self._start_r.query % ({'action': 'start'}))
        print "?", url, "?"
        self._conn.request("GET", url)
        r = self._conn.getresponse()
        print r.status, r.reason
        self._ph = win32file.CreateFile(self._pipe_name,
              win32file.GENERIC_READ,
              0, 
              None, # No special security requirements
              win32file.OPEN_EXISTING,
              0, # Not creating, so attributes dont matter.
              None)
        # Waits until either a time-out interval elapses or an instance of the specified named pipe is available to be connected to
        #win32pipe.WaitNamedPipe(self._pipe_name, self._pipe_wait_timeout)
        self._get_version()
        print self._version
        if self._version == 1:
            self._get_steps()
            self._start_status_loop()
        self._conn = httplib.HTTPConnection(self._stop_r.hostname)
        url = "/%s?%s" % (self._stop_r.path, self._stop_r.query % ({'action': 'stop'}))
        print "?", url, "?"
        self._conn.request("GET", url)
        r = self._conn.getresponse()
        print r.status, r.reason

if __name__ == '__main__':

    #sys.stdout = open(r"C:\http_transmission.log.out", "a")
    #sys.stderr = open(r"C:\http_transmission.log.err", "a")
    start_url = ''
    stop_url = ''
    status_url = ''
    pronounce_steps_url = ''
    fh = open(os.path.join(get_application_path(__file__), 'http_transmission.urls'), 'r')
    for line in fh:
        tmp = line.split('=', 1)
        tmp = [entry.strip() for entry in tmp]
        key = tmp[0]
        value = tmp[1]
        print key, value
        if key == 'status_url':
            status_url = value
        elif key == 'pronounce_steps_url':
            pronounce_steps_url = value
        elif key == 'start_url':
            start_url = value
        elif key == 'stop_url':
            stop_url = value
    np = NamedPipe(start_url, pronounce_steps_url, status_url, stop_url)
    np.run()