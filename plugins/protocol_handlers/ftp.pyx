# -*- coding: utf-8 -*-

# standard library imports

# third party imports

# application/library imports
import libs.handlers.protocol
from libs.handlers.protocol cimport BaseHandler


url_prefix = "ftp://"

#cdef class FTPHandler(libs.handlers.protocol.BaseHandler):
cdef class FTPHandler(BaseHandler):

    def __init__(self, url, username, password, **kwargs):
        #libs.handlers.protocol.BaseHandler.__init__(self, url, username, password)
        BaseHandler.__init__(self, url, username, password)

def register_handler(plugins):
    plugins[url_prefix[:-3]] = FTPHandler
    return (url_prefix, FTPHandler)