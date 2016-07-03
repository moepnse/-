# -*- coding: utf-8 -*-

# standard library imports
import os
import os.path
import time
import hashlib
import urlparse
import urllib
import urllib2
import tempfile 

# third party imports


# application/library imports
import libs.handlers.protocol
import libs.common

# application/library cimports
from libs.handlers.protocol cimport BaseHandler
from c_windows_data_types cimport DWORD
from libs.handlers.config cimport STATUS_SOURCE, ss__cmd, ss__connection_handler, ss__protocol, STATUS_TYPES, st__info, st__success, st__warn, st__error

url_prefix = "http://"

#cdef class HTTPHandler(libs.handlers.protocol.BaseHandler):
cdef class HTTPHandler(BaseHandler):

    cdef:
        public object _path
        public object _url_prefix2
        public dict _cache
        public unicode _cache_path
        public bint _use_cache

    def __init__(self, log, status_handler, url, username=None, password=None, **kwargs):
        #libs.handlers.protocol.BaseHandler.__init__(self, log, url, username, password)
        self._url_prefix = url_prefix
        BaseHandler.__init__(self, log, status_handler, url, username, password)
        self._url_prefix2 = "https"
        self._cache_path = u"cache\http"
        self._use_cache = True
        self._cache = {}
        if url.startswith(r'"'):
            for i in range(1, len(url)):
                if url[i:i+1] == r'"':
                    self._parameters = url[i+1:len(url)].strip().split(" ")
                    self._url = url[1:i]
                    break
        else:
            self._url = url

    def delete(self):
        try:
            os.unlink(self.path)
        except IOError:
            pass

    def __del__(self):
        pass
        #self.delete()

    def _strip_url_prefix(self, url):
        if url.startswith(self._url_prefix2):
            return url[len(self._url_prefix2):]
        else:
            return url[len(self._url_prefix):]

    def is_responsible(self, url):
        cdef:
            bint is_responsible = False
        is_responsible = url.startswith(self._url) or url[len(self._url_prefix):].startswith(self._url)
        self._log_debug(u"[http (%s)] [%d] is responsible: %s" % (self._plugin_name, libs.common.get_current_line_nr(), is_responsible))
        if is_responsible:
            if not self._status_handler is None:
                status_id = self._status_handler.set_status(ss__connection_handler, st__info, self._plugin_name.decode("utf-8"), 1, u"Plugin \"%s\" is responsible for URL \"%s\"." % (self._plugin_name, url))
        return is_responsible

    def _download_w_urllib2(self, url):
        cdef:
            object local_file
            object req
            object f
            object e
            basestring  file_name
            basestring  file_extension
            basestring  data
            basestring  scheme
            basestring  netloc
            basestring  path
            basestring  query
            basestring  fragment
            unicode cache_dir
            basestring  head
            basestring  tail
            str creation_time
            unsigned int status_id
        scheme, netloc, path, query, fragment = urlparse.urlsplit(url)
        path = path[1:]
        path = path.replace("/", "\\")
        #print scheme, netloc, path, query, fragment
        head, tail = os.path.split(urllib.unquote(path))
        file_name, file_extension = os.path.splitext(tail)
        req = urllib2.Request(url)
        if self._use_cache:
            if not os.path.exists(self._cache_path):
                if self._status_handler is not None:
                    status_id = self._status_handler.set_status(ss__connection_handler, st__info, u"http", 1, u"Creating cache directory: %s" % (self._cache_path))
                os.makedirs(self._cache_path)
            cache_dir = os.path.join(self._cache_path, netloc, head)
            if not os.path.exists(cache_dir):
                os.makedirs(cache_dir)
            self._path = os.path.join(cache_dir, tail)
            if os.path.isfile(self._path):
                creation_time = time.strftime("%a, %d %b %Y %H:%M:%S GMT", time.gmtime(os.path.getctime(self._path)))
                req.add_header("If-Modified-Since", creation_time)
        #print "path:", self._path
        try:
            f = urllib2.urlopen(req)
        except urllib2.HTTPError, e:
            if e.code == 304:
                if self._status_handler is not None:
                    status_id = self._status_handler.set_status(ss__connection_handler, st__info, u"http", 1, u"Using file from cache: %s" % (self._path))
                return self._path
            elif e.code == 404:
                raise libs.handlers.protocol.FileNotFound(url)
        if self._status_handler is not None:
            status_id = self._status_handler.set_status(ss__connection_handler, st__info, u"http", 1, u"Downloading file %s and store it under %s." % (url, self._path))
        if self._use_cache:
            local_file = open(self._path, 'wb')
        else:
            local_file = tempfile.NamedTemporaryFile(delete=False, suffix=file_extension)
            self._path = local_file.name
        data = f.read()
        local_file.write(data)
        local_file.close()
        f.close()
        #print self._path, os.path.isfile(self._path)
        self._cache[url] = self._path
        return self._path

    def _download_w_urllib(self, url):
        cdef:
            object web_file
            object info
            int content_length
            int data_length = 0
            object line
            object local_file
            object file_name
            object file_extension
            object tmp_file_name
        file_name, file_extension = os.path.splitext(url)
        web_file = urllib.urlopen(url)
        info = web_file.info()
        self._log.log_debug(u"[http] [%d] HTTP Connection Information: %s" % (libs.common.get_current_line_nr(), info))
        local_file = tempfile.NamedTemporaryFile(delete=False)
        tmp_file_name = local_file.name
        self._path =  u"%s%s" % (tmp_file_name, file_extension)
        content_length = int(info['Content-Length'])
        for line in web_file:
            #self._log.log_debug(u"[http] [%d] writing: '%s' to %s" % (libs.common.get_current_line_nr(), line, self._path))
            local_file.write(line)
        web_file.close()
        local_file.close()
        os.rename(tmp_file_name, self._path)
        self._cache[url] = self._path
        return self._path

    def _download_w_urllib_rr(self, url):
        cdef:
            object filename
            object file_extension
            object tmp_file_name
            object data
        filename, headers = urllib.urlretrieve(url)
        self._path = filename
        self._cache[url] = self._path
        return self._path

    def open(self, path, mode):
        return open(self.get_path(path), mode)

    def get_path(self, path):
        if path in self._cache:
            return self._cache[path]
        return self._download_w_urllib2(path)

    def execute(self, unicode cmd):
        cdef:
            object args
            DWORD ret_code = -1
            DWORD last_error_code = 0
        args = libs.win.commandline.parse(cmd, True)
        args[0] = self.get_path(args[0].strip("\""))
        #print args[0], os.path.isfile(args[0])
        #cmd = " ".join(args)
        #if 'log_info' in self._log:
        self._log.log_info(u"[http] [%d] %s (%d kb, md5: %s)" % (libs.common.get_current_line_nr(), cmd, os.path.getsize(args[0]), hashlib.md5(args[0])))
        #print "CMD:", repr(cmd)
        ret_code = self._execute(cmd.strip(), &last_error_code)
        #if 'log_info' in self._log:
        self._log.log_info(u"[http] [%d] ret code: %d" % (libs.common.get_current_line_nr(), ret_code))
        return ret_code

    def copy(self):
        pass


def register_handler(plugins):
    plugins[url_prefix[:-3]] = HTTPHandler
    return (url_prefix, HTTPHandler)