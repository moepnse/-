# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import time
import socket
import httplib
import urlparse

# third party imports


# application/library imports
from libs.common import get_application_path
from libs.handlers.status import INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_ERROR
from libs.np_client import NamedPipeHandler


class EOF(Exception):

    def __init__(self, path):
        self._path = path

    def __str__(self):
        return repr(self._path)


class NamedPipe(NamedPipeHandler):

    def __init__(self, start_url, pronounce_steps_url, status_url, stop_url):
        NamedPipeHandler.__init__(self)
        self._pronounce_steps_url = pronounce_steps_url
        self._pronounce_steps_r = urlparse.urlparse(pronounce_steps_url)
        self._status_url = status_url
        self._status_r = urlparse.urlparse(status_url)
        self._start_r = urlparse.urlparse(start_url)
        self._stop_r = urlparse.urlparse(stop_url)
        self._hostname = socket.gethostname()
        self._process_id = int(time.time())


    def _handle_send_status(self, package_id, package_name, action):
        self._conn = httplib.HTTPConnection(self._status_r.hostname)
        url = "/%s?%s" % (self._status_r.path, self._status_r.query % (
                {   'package_id': package_id, 
                    'package_name': package_name, 
                    'action': action,
                    'hostname': self._hostname,
                    'process_id': self._process_id
                }
            )
        )
        self._conn.request("GET", url)
        r = self._conn.getresponse()
        print r.status, r.reason

    def _handle_send_info(self, info_type, info_text):
        pass

    def _handle_send_done(self):
        self._log_info(u"done!")

    def run(self):
        self._conn = httplib.HTTPConnection(self._start_r.hostname)
        url = "/%s?%s" % (self._start_r.path, self._start_r.query % (
                {   'action': 'start',
                    'hostname': self._hostname,
                    'process_id': self._process_id
                }
            )
        )
        self._conn.request("GET", url)
        r = self._conn.getresponse()
        print r.status, r.reason
        self.open()
        # Waits until either a time-out interval elapses or an instance of the specified named pipe is available to be connected to
        #win32pipe.WaitNamedPipe(self._pipe_name, self._pipe_wait_timeout)
        self._version = self.get_version()
        if self._version == 1:
            self._steps = self.get_steps()
            self._log.log_debug(u"steps: %d" % self._steps)
            self._conn = httplib.HTTPConnection(self._pronounce_steps_r.hostname)
            url = "/%s?%s" % (self._pronounce_steps_r.path, self._pronounce_steps_r.query % (
                    {   'action': 'pronounce_steps', 
                        'steps': self._steps,
                        'hostname': self._hostname,
                        'process_id': self._process_id
                    }
                )
            )
            self._conn.request("GET", url)
            r = self._conn.getresponse()
            print r.status, r.reason
        else:
            pass
        self._conn = httplib.HTTPConnection(self._stop_r.hostname)
        url = "/%s?%s" % (self._stop_r.path, self._stop_r.query % (
                {   'action': 'stop',
                    'hostname': self._hostname,
                    'process_id': self._process_id
                }
            )
        )
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
    fh = open(os.path.join(get_application_path(), 'http_transmission.urls'), 'r')
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