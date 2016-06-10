# -*- coding: utf-8 -*-

# standard library imports
import os
import codecs
import datetime  

#import distutils.util

# third party imports

# application/library imports
import libs.handlers.logging
from libs.handlers.logging cimport BaseHandler

import package_installer
import libs.common


log_interface = "file"


#cdef class FileHandler(libs.handlers.logging.BaseHandler):
cdef class FileHandler(BaseHandler):
    cdef:
        public object _url_info
        public object _url_warn
        public object _url_err
        public object _url_debug
        public object _fh_log
        public object _fh_info
        public object _fh_warn
        public object _fh_err
        public object _fh_debug
        public object _newline
        public object _template

    def __init__(self, url=None, url_info=os.path.join(package_installer.get_application_path(), r'logs\info.log'), url_warn=os.path.join(package_installer.get_application_path(), r'logs\warn.log'), url_err=os.path.join(package_installer.get_application_path(), r'logs\err.log'), url_debug=os.path.join(package_installer.get_application_path(), r'logs\debug.log'), log_gen=True, log_info=True, log_warn=True, log_err=True, log_debug=False, **kwargs):
        #libs.handlers.logging.BaseHandler.__init__(self)
        BaseHandler.__init__(self)

        print url_info, url_warn, url_err, url_debug

        self._url = url
        self._url_info = url_info
        self._url_warn = url_warn
        self._url_err = url_err
        self._url_debug = url_debug

        self._log_gen = libs.common.str2bool(log_gen)
        self._log_info = libs.common.str2bool(log_info)
        self._log_warn = libs.common.str2bool(log_warn)
        self._log_err = libs.common.str2bool(log_err)
        self._log_debug = libs.common.str2bool(log_debug)

        if url is not None:
            try:
                self._check_path(url)
                self._fh_log = open(url, 'a')
            except IOError as e:
                self._log_gen = False
        if url_info is not None:
            try:
                self._check_path(url_info)
                self._fh_info = open(url_info, 'a')
            except IOError as e:
                self._log_info = False
        if url_warn is not None:
            try:
                self._check_path(url_warn)
                self._fh_warn = open(url_warn, 'a')
            except IOError as e:
                self._log_warn = False
        if url_err is not None:
            try:
                self._check_path(url_err)
                self._fh_err = open(url_err, 'a')
            except IOError as e:
                self._log_err = False
        if url_debug is not None:
            try:
                self._check_path(url_debug)
                self._fh_debug = open(url_debug, 'a')
            except IOError as e:
                self._log_debug = False
        self._newline = '\n'
        self._template = u'[%s] %s%s'

    def _check_path(self, path):
        """ Creates the directory structure obmited in path, if they don't exists."""
        dir_path = os.path.dirname(path)
        if not os.path.isdir(dir_path):
            os.makedirs(dir_path)

    def _get_timestamp(self):
        utc = datetime.datetime.utcnow() 
        return utc.strftime("%Y-%m-%d %H:%M:%S")

    def _write(self, fh, unicode msg):
        #print msg, type(msg)
        fh.write((self._template % (self._get_timestamp(), msg, self._newline)).encode('UTF-8', errors='replace'))
        fh.flush()

    def _log_general(self, unicode msg):
        if self._log_gen and self._url is not None:
            try:
                self._write(self._fh_log, msg)
            except IOError as e:
                self._log_gen = False

    def log_err(self, unicode msg): 
        if self._log_err:
            self._log_general(msg)
            if self._url_err is not None:
                try:
                    self._write(self._fh_err, msg)
                except IOError as e:
                    self._log_err = False

    def log_info(self, unicode msg):
        if self._log_info:
            self._log_general(msg)
            if self._url_info is not None:
                try:
                    self._write(self._fh_info, msg)
                except IOError as e:
                    self._log_info = False

    def log_warn(self, unicode msg):
        if self._log_warn:
            self._log_general(msg)
            if self._url_warn is not None:
                try:
                    self._write(self._fh_warn, msg)
                except IOError as e:
                    self._log_warn = False

    def log_debug(self, unicode msg):
        if self._log_debug:
            self._log_general(msg)
            if self._url_debug is not None:
                try:
                    self._write(self._fh_debug, msg)
                except IOError as e:
                    self._log_debug = False


def register_handler(plugins):
    plugins[log_interface] = FileHandler
    return (log_interface, FileHandler)