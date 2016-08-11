# -*- coding: utf-8 -*- 

# standard library imports
import re
#import subprocess

# third party imports


# application/library imports
import libs.handlers.protocol
from libs.handlers.protocol cimport BaseHandler
from c_windows_data_types cimport DWORD
import libs.common
from libs.handlers.config cimport STATUS_SOURCE, ss__cmd, ss__connection_handler, ss__protocol, STATUS_TYPES, st__info, st__success, st__warn, st__error


url_prefix = "file://"


#cdef class FileHandler(libs.handlers.protocol.BaseHandler):
cdef class FileHandler(BaseHandler):

    _drive_letter_regex = re.compile(r'^[A-Za-z]{1}:\\')

    def __init__(self, log, status_handler, url, username=None, password=None, log_info=True, log_warn=True, log_err=True, log_debug=False, **kwargs):
        #libs.handlers.protocol.BaseHandler.__init__(self, log, url, username=username, password=password, log_info=log_info, log_warn=log_warn, log_err=log_err, log_debug=log_debug)
        self._url_prefix = url_prefix
        BaseHandler.__init__(self, log, status_handler, url, username=username, password=password, log_info=log_info, log_warn=log_warn, log_err=log_err, log_debug=log_debug)

    def is_responsible(self, url):
        cdef:
            bint is_responsible = False
        if url.startswith('"') and url.endswith('"'):
            url = url.strip('"')
        elif url.startswith("'") and url.endswith("'"):
            url = url.strip("'")
        self._log_debug(u'[file] [%d] %s' % (libs.common.get_current_line_nr(), url))
        self._log_debug(u'[file] [%d] Regex Match: %s' % (libs.common.get_current_line_nr(), self._drive_letter_regex.match(url)))
        #responsible = True if self._drive_letter_regex.match(url) is not None else libs.handlers.protocol.BaseHandler.is_responsible(self, url)
        #is_responsible = True if self._drive_letter_regex.match(url) is not None else BaseHandler.is_responsible(self, url)
        if self._drive_letter_regex.match(url) is not None:
            is_responsible = True
            if not self._status_handler is None:
                status_id = self._status_handler.set_status(ss__connection_handler, st__info, self._plugin_name.decode("utf-8"), 1, u"Plugin \"%s\" is responsible for URL \"%s\"." % (self._plugin_name, url))
        elif BaseHandler.is_responsible(self, url):
            is_responsible = True
        self._log_debug(u'[file] [%d] responsible: %s' % (libs.common.get_current_line_nr(), is_responsible))
        return is_responsible

    def get_file(self, unicode path):
        self.connect()
        return self._strip_url_prefix(path)

    def execute(self, unicode cmd):
        cdef:
            DWORD ret_code = -1
            DWORD last_error_code = 0
            object args
        args = libs.win.commandline.parse(cmd, True)
        args[0] = libs.win.commandline.strip_qoutes(args[0])
        if args[0].startswith(self._url_prefix):
            args[0] = self._strip_url_prefix(args[0])

        cmd = (u'"%s" %s' if " " in args[0] else u'%s %s') % (args[0] , libs.win.commandline.merge(args[1:]))
        self._log_debug("[file] [%d] executing: %s" % (libs.common.get_current_line_nr(), cmd))
        ret_code = self._execute(cmd, &last_error_code)
        self._log_info("[file] [%d] cmd: %s, ret code: %s" % (libs.common.get_current_line_nr(), cmd, ret_code))
        return ret_code


def register_handler(plugins):
    plugins[url_prefix[:-3]] = FileHandler
    return (url_prefix, FileHandler)