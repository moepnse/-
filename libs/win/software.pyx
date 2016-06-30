# -*- coding: utf-8 -*-

# standard library imports
import re

# third party imports

# application/library imports
import winreg

UNINSTALL_PATH = r"Software\Microsoft\Windows\CurrentVersion\Uninstall"
UNINSTALL_PATHS = [r"Software\Microsoft\Windows\CurrentVersion\Uninstall", r"Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"]

class Product(object):

    def __init__(self, display_name="", uninstall_string="", parent_display_name="", parent_key_name="", display_version="", version=0, version_major=0, version_minor=0, **kwargs):
        self._display_name = display_name
        self._display_version = display_version
        self._version = version
        self._version_major = version_major
        self._version_minor = version_minor
        self._uninstall_string = uninstall_string
        self._has_parent = (parent_display_name != "" or parent_key_name != "")
        self._parent_display_name = parent_display_name
        self._parent_key_name = parent_key_name
        self._childs = {}
        self._attrs = kwargs

    def uninstall():
        pass

    @property
    def uninstall_string(self):
        return self._uninstall_string

    @property
    def display_name(self):
        return self._display_name

    @property
    def display_version(self):
        return self._display_version

    @property
    def version(self):
        return self._version

    @property
    def version_major(self):
        return self._version_major

    @property
    def version_minor(self):
        return self._version_minor

    @property
    def product_name(self):
        return self._display_name

    @property
    def parent_key_name(self):
        return self._parent_key_name

    @property
    def parent_display_name(self):
        return self._parent_display_name

    @property
    def has_parent(self):
        return self._has_parent

    def __setitem__(self, key, item):
        self._childs[key] = item

    def __getitem__(self, key):
        return self._childs[key]

    def keys(self):
        return self._childs.keys()

    def values(self):
        return self._childs.values()

    def items(self):
        return self._childs.items()

    def __getattr__(self, name):
        if name in self._attrs[name]:
            return self._attrs[name]
        else:
            # Default behaviour
            raise AttributeError


cdef class SoftwareList:

    def __init__(self):
        self._mapping = {
            "DisplayIcon": winreg.REG_SZ,
            "DisplayName": winreg.REG_SZ,
            "DisplayVersion": winreg.REG_SZ,
            "Emitter": winreg.REG_DWORD,
            "EstimatedSize": winreg.REG_DWORD,
            "HelpLink": winreg.REG_SZ,
            "InstallDate": winreg.REG_SZ,
            "InstallLocation": winreg.REG_SZ,
            "Integrated": winreg.REG_DWORD,
            "NoModify": winreg.REG_DWORD,
            "NoRepair": winreg.REG_DWORD,
            "Publisher": winreg.REG_SZ,
            "Readme": winreg.REG_SZ,
            "Size": winreg.REG_DWORD,
            "SystemComponent": winreg.REG_DWORD,
            "QuietUninstallString": winreg.REG_SZ,
            "RequiresIESysFile": winreg.REG_SZ,
            "QuietUninstallString": winreg.REG_SZ,
            "UninstallString": winreg.REG_SZ,
            "URLInfoAbout": winreg.REG_SZ,
            "URLUpdateInfo": winreg.REG_SZ,
            "Version": winreg.REG_DWORD,
            "VersionMajor": winreg.REG_DWORD,
            "VersionMinor": winreg.REG_DWORD,
            "WindowsInstaller": winreg.REG_DWORD
        }
        self._update()

    def _update(self):
        self._sw_list = {}
        for uninstall_path in UNINSTALL_PATHS:
            if not winreg.sub_key_exists(r"HKEY_LOCAL_MACHINE", uninstall_path):
                continue
            for product in winreg.get_keys(r"HKEY_LOCAL_MACHINE", uninstall_path):
                kwargs = {}
                if winreg.value_exists(r"HKEY_LOCAL_MACHINE", r"%s\%s" % (uninstall_path, product.name), "DisplayName"):
                    product_name = product.DisplayName.data
                    uninstall_string = product.DisplayName.data
                    path = uninstall_path + '\\' + product.name
                    for entry_name, value_type in self._mapping.items():
                        if winreg.value_exists(r"HKEY_LOCAL_MACHINE", path, entry_name):
                            reg_value = winreg.get_value(r"HKEY_LOCAL_MACHINE", path, entry_name).data
                            if value_type == winreg.REG_DWORD:
                                if reg_value == '':
                                    reg_value = 0
                                else:
                                    reg_value = int(reg_value)
                            kwargs[entry_name] = reg_value
                            kwargs[re.sub('(?!^)([A-Z]+)', r'_\1', entry_name).lower()] = reg_value
                    self._sw_list[product_name] = Product(**kwargs)

    def __iter__(self):
        self._update()
        return self._sw_list.__iter__()

    def __len__(self):
        return len(self._sw_list)

    def next(self):
        return self._sw_list.next()

    def keys(self):
        return self._sw_list.keys()

    def values(self):
        return self._sw_list.values()

    def items(self):
        return self._sw_list.items()

    def __getitem__(self, key):
        return self._sw_list[key]

    def __setitem__(self, key, value):
        new_key = winreg.create_key(r"HKEY_LOCAL_MACHINE", "\\".join((UNINSTALL_PATH, key)))
        for _key, _value in value.items():
            if _key in self._mapping:
                new_key.set_value(_key, self._mapping[_key], _value)


# http://flexget.com/ticket/1641?cversion=0&cnum_hist=2
# FIXT IT! 
class SoftwareTree(SoftwareList):
    def _update(self):
        SoftwareList._update(self)

        for product in self._sw_list.values():
            if product.has_parent:
                parent_display_name = product.parent_display_name
                if parent_display_name in self._sw_list:
                    display_name = product.display_name
                    self._sw_list[parent_display_name][display_name] = product
                    del self._sw_list[display_name]


def get_products():
    for product in winreg.get_keys(r"HKEY_LOCAL_MACHINE", UNINSTALL_PATH):
        if winreg.value_exists(r"HKEY_LOCAL_MACHINE", r"%s\%s" % (UNINSTALL_PATH, product.name), "DisplayName"):
            display_name = product.DisplayName.data
        else:
            display_name = None
        if winreg.value_exists(r"HKEY_LOCAL_MACHINE", r"%s\%s" % (UNINSTALL_PATH, product.name), "UninstallString"):
            uninstall_string = product.UninstallString.data
        else:
            uninstall_string = None

        yield Product(display_name, uninstall_string)

def is_installed(product_name):
    for product in winreg.get_keys(r"HKEY_LOCAL_MACHINE", UNINSTALL_PATH):
        if winreg.value_exists(r"HKEY_LOCAL_MACHINE", r"%s\%s" % (UNINSTALL_PATH, product.name), "DisplayName"):
            if product.DisplayName.data == product_name:
                return True

    return False
