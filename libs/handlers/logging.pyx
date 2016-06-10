# -*- coding: utf-8 -*-

# standard library imports

# third party imports

# application/library imports


log_interface = "file"

#cdef class BaseHandler:
cdef class BaseHandler:

    def __cinit__(self):
        self._log_info = True
        self._log_warn = True
        self._log_err = True
        self._log_debug = False

    def __init__(self):
        pass

    def log_err(self, unicode msg):
        pass

    def log_info(self, unicode msg):
        pass

    def log_warn(self, unicode msg):
        pass

    def log_debug(self, unicode msg):
        pass


def register_handler(plugins):
    plugins[log_interface] = BaseHandler
    return (log_interface, BaseHandler)