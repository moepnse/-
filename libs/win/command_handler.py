# -*- coding: utf-8 -*-

# standard library imports
import os
import re
import urllib
import tempfile
import subprocess

# third party imports

# application/library imports
import commandline

URL_REGEX  = re.compile(r'(https?://([-\w\.]+)+(:\d+)?(/([\w/_\.-]*(\?\S+)?)?)?)')


class FileNotFound(Exception):

    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)


class FileDownload(object):

    def __init__(self, url, delete=False):

        if url.startswith(r'"'):
            #print True
            for i in range(1, len(url)):
                if url[i:i+1] == r'"':

                    self._parameters = url[i+1:len(url)].strip().split(" ")
                    #print self._parameters
                    self._url = url[1:i]
                    break
        else:
            self._url = url

        web_file = urllib.urlopen(self._url)
        local_file = tempfile.NamedTemporaryFile(delete=delete)
        self.path = local_file.name
        local_file.write(web_file.read())
        web_file.close()
        local_file.close()
        if os.path.exists(self.path):
            pass

    def delete(self):
        os.unlink(self.path)

    def __del__(self):
        self.delete()


class CommandHandler(object):

    def __init__(self, cmd, plugins):
        self._delete = False

        m = URL_REGEX.search(cmd)

        if m != None:
            url = m.group(0)
            extension = os.path.splitext(url)[1]
            web_file = urllib.urlopen(url)
            if web_file.getcode() != 200:
                raise FileNotFound(url)
            local_file = tempfile.NamedTemporaryFile(suffix=extension, delete=self._delete)
            self.path = local_file.name
            local_file.write(web_file.read())
            web_file.close()
            local_file.close()

            self._cmd = cmd.replace(url, self.path)
        else:
            self._cmd = cmd

    def __del__(self):
        if self._delete == True:
            os.unlink(self.path)

    def execute(self):
        #print self._cmd

        args = commandline.parse(self._cmd)

        #print args
        ret_code = subprocess.call(args)
        #print ret_code
        return ret_code