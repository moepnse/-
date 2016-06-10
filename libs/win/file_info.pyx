# -*- coding: utf-8 -*-

# standard library cimports
from cpython.ref cimport PyObject
from libc.stdlib cimport malloc, free

# application/library cimports
from c_windows_data_types cimport DWORD, LPBYTE, LPWSTR, UINT, PUINT, LPVOID, LPCVOID, LPCWSTR
from c_windows cimport GetFileVersionInfoSizeW, VS_FIXEDFILEINFO, GetFileVersionInfoW, VerQueryValueW, HIWORD, LOWORD, GetLastError
from libs.common cimport un_camel


cdef class FileInfo:

    def __init__(self, unicode path):
        self._path = path
        self._file_info = {}
        self._get_file_info()

    cdef _get_file_info(self):
        cdef:
            DWORD dw_handle
            DWORD dw_len
            UINT buf_len
            LPCVOID lp_data
            LPWSTR lp_buffer
            LPCWSTR cw_path = <LPCWSTR>self._path
            VS_FIXEDFILEINFO *p_file_info
            unicode sub_block = u""
            unicode entry = u""
        dw_len = GetFileVersionInfoSizeW (cw_path, &dw_handle)
        if not dw_len:
            return -1;

        lp_data = <LPCVOID>malloc(dw_len)
        if  not lp_data:
            return -1;
        if not GetFileVersionInfoW(cw_path, dw_handle, dw_len, lp_data):
            free(lp_data)
            return -1
        sub_block = u"\\"
        if VerQueryValueW(lp_data, <LPCWSTR>sub_block, <LPVOID*>&p_file_info, <PUINT>&buf_len):
            self['major_version'] = HIWORD(p_file_info.dwFileVersionMS)
            self['minor_version'] = LOWORD(p_file_info.dwFileVersionMS)
            self['build_number'] = HIWORD(p_file_info.dwFileVersionLS)
            self['revision_number'] = LOWORD(p_file_info.dwFileVersionLS)

        for entry in (u"Comments", u"InternalName",	u"ProductName", u"CompanyName", u"LegalCopyright", u"ProductVersion", u"FileDescription", u"LegalTrademarks", u"PrivateBuild", u"FileVersion", u"OriginalFilename", u"SpecialBuild"):
            sub_block = u"\\StringFileInfo\\040904E4\\%s" % entry
            # language ID 040904E4: U.S. English, char set = Windows, Multilingual
            if VerQueryValueW(lp_data, <LPCWSTR>sub_block, <LPVOID*>&lp_buffer, <PUINT>&buf_len):
                self[entry] = unicode(lp_buffer)
                self[un_camel(entry)] = unicode(lp_buffer)
        free (lp_data)

    def items(self):
        return self._file_info.items()

    def iteritems(self):
        return self._file_info.iteritems()

    def keys(self):
        return self._file_info.keys()

    def __iter__(self):
        return iter(self._file_info)

    def __setitem__(self, key, value):
        self._file_info[key] = value

    def __getitem__(self, key):
        return self._file_info[key]