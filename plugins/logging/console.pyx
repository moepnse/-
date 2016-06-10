# -*- coding: utf-8 -*-

# standard library imports
import sys
#import distutils.util

# third party imports

# application/library imports
import libs.handlers.logging
from libs.handlers.logging cimport BaseHandler
import libs.common

log_interface = "console"

#cdef class ConsoleHandler(libs.handlers.logging.BaseHandler):
cdef class ConsoleHandler(BaseHandler):

    def __init__(self, log_info=True, log_warn=True, log_err=True, log_debug=False, **kwargs):
        #libs.handlers.logging.BaseHandler.__init__(self)
        BaseHandler.__init__(self)

        self._log_info = libs.common.str2bool(log_info)
        self._log_warn = libs.common.str2bool(log_warn)
        self._log_err = libs.common.str2bool(log_err)
        self._log_debug = libs.common.str2bool(log_debug)

        #print log_info, log_warn, log_err, log_debug

    def _encode_msg(self, unicode msg):
        # CP850 Encoding is important for Text Output in the Windows Console
        return msg.encode("CP850", errors='replace')

    def log_err(self, unicode msg):
        if self._log_err:
            try:
                print >>sys.stderr, self._encode_msg(msg)
            except IOError as e:
                print e
                #pass

    def log_info(self, unicode msg):
        if self._log_info:
            try:
                print >>sys.stdout, self._encode_msg(msg)
            except IOError as e:
                print e
                #pass

    def log_warn(self, unicode msg):
        if self._log_warn:
            try:
                print >>sys.stdout, self._encode_msg(msg)
            except IOError as e:
                print e
                #pass

    def log_debug(self, unicode msg):
        if self._log_debug:
            try:
                print >>sys.stdout, self._encode_msg(msg)
            except IOError as e:
                print e
                #pass


def register_handler(plugins):
    plugins[log_interface] = ConsoleHandler
    return (log_interface, ConsoleHandler)