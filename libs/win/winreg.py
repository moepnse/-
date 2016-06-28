# -*- coding: utf-8 -*-

# standard library imports
import sys
import _winreg as winreg

# third party imports

# application/library imports


# Access Modes
KEY_QUERY_VALUE = 1
KEY_SET_VALUE = 2
KEY_CREATE_SUB_KEY = 4
KEY_ENUMERATE_SUB_KEYS = 8
KEY_NOTIFY = 16
KEY_CREATE_LINK = 32
KEY_WRITE = 131078
KEY_EXECUTE = 131097
KEY_READ = 131097
KEY_ALL_ACCESS = 983103

# Data Types
REG_NONE = 0
REG_SZ = 1
REG_EXPAND_SZ = 2
REG_BINARY = 3
REG_DWORD = 4
REG_DWORD_BIG_ENDIAN = 5
REG_LINK = 6
REG_MULTI_SZ = 7
REG_RESOURCE_LIST = 8
REG_FULL_RESOURCE_DESCRIPTOR = 9
REG_RESOURCE_REQUIREMENTS_LIST = 10
REG_QWORD = 11

# Reg Mapping
REG_MAPPING = {
    "HKLM": winreg.HKEY_LOCAL_MACHINE,
    "HKCU": winreg.HKEY_CURRENT_USER,
    "HKU": winreg.HKEY_USERS,
    "HKEY_LOCAL_MACHINE": winreg.HKEY_LOCAL_MACHINE,
    "HKEY_CURRENT_USER": winreg.HKEY_CURRENT_USER,
    "HKEY_USERS": winreg.HKEY_USERS
    }

REGISTRY_ENCODING = 'utf-8'

# Error Class
class KeyNotFound(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)


class AttributeNotFound(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)


class ItemNotFound(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)


class Value(object):
    def __init__(self, key, sub_key, value_name, value_data, value_type):
        self._name = value_name
        self._data = value_data
        self._type = value_type
        self._key = REG_MAPPING[key]

        try:
            self._key_handle = winreg.OpenKey(REG_MAPPING[key], "%s" % (sub_key), 0, winreg.KEY_READ | winreg.KEY_WRITE | winreg.KEY_SET_VALUE)
        except WindowsError, err:
            self._key_handle = winreg.OpenKey(REG_MAPPING[key], "%s" % (sub_key), 0, winreg.KEY_READ)

    def is_key(self):
        return False

    def is_value(self):
        return True

    def get_name(self):
        return self._name

    def set_name(self, name):
        winreg.DeleteValue(self._key_handle, r"%s\%s" % (self._sub_key, self._name))
        winreg.SetValueEx(self._key_handle, r"%s\%s" % (self._sub_key, name ), self._type, self._data)
        self._name = name

    def del_name(self):
        pass

    def get_data(self):
        return self._data

    def set_data(self, data):
        self._data = data
        winreg.SetValueEx(self._key_handle, r"%s\%s" % (self._sub_key, self._name ), self._type, self._data)

    def del_data(self):
        pass

    def get_type(self):
        return self._type

    def set_type(self, type):
        self._type = type
        winreg.SetValueEx(self._key_handle, r"%s\%s" % (self._sub_key, self._name ), self._type, self._data)

    def del_type(self):
        pass

    def __del__(self):
        try:
            winreg.CloseKey(self._key_handle)
        except:
            pass

    name = property(get_name, set_name, del_name, "'name' property.")
    data = property(get_data, set_data, del_data, "'data' property.")
    type = property(get_type, set_type, del_type, "'type' property.")


class Key(object):
    def __init__(self, key, sub_key, key_name):
        self._name = key_name
        self._sub_key = sub_key
        self._key = key

        try:
            #self._key_handle = winreg.OpenKey(REG_MAPPING[key], r"%s\%s" % (sub_key, key_name), 0, winreg.KEY_READ | winreg.KEY_WRITE | winreg.KEY_SET_VALUE)
            self._key_handle = winreg.OpenKey(REG_MAPPING[key], r"%s\%s" % (sub_key, key_name), 0, winreg.KEY_ALL_ACCESS)

        except WindowsError, err:
            self._key_handle = winreg.OpenKey(REG_MAPPING[key], r"%s\%s" % (sub_key, key_name), 0, winreg.KEY_READ)

        #self._set_values()
        #self._set_keys()

    def reset(self):
        self._key_count = winreg.QueryInfoKey(self._key_handle)[0]
        self._key_index = 0
        self._value_count = winreg.QueryInfoKey(self._key_handle)[1]
        self._value_index = 0

    def is_key(self):
        return True

    def is_value(self):
        return False

    def __iter__(self):
        self.reset()
        return self

    def next(self):
        if self._key_index >= self._key_count:
            if self._value_index >= self._value_count:
                raise StopIteration
            return self._get_next_value()
        return self._get_next_key()

    def _get_next_key(self):

        # winreg.EnumKey:
        # Enumerates values of an open registry key, returning a tuple.
        #
        # The result is the name of a key
        key_name = winreg.EnumKey(self._key_handle, self._key_index)

        self._key_index += 1

        return Key(self._key, r"%s\%s" % (self._sub_key, self._name), key_name)

    def _get_next_value(self):

        # winreg.EnumValue:
        # Enumerates values of an open registry key, returning a tuple.
        #
        # The result is a tuple of 3 items:
        # Index     Meaning
        # 0         A string that identifies the value name
        # 1         An object that holds the value data, and whose type depends on the underlying registry type
        # 2         An integer that identifies the type of the value data
        value = winreg.EnumValue(self._key_handle, self._value_index)

        value_name = value[0]
        value_data = value[1]
        value_type = value[2]

        self._value_index += 1

        return Value(self._key, self._sub_key, value_name, value_data, value_type)

    def __getattr__(self, name):
        'Return the new Key Instance over an Attribute'
        if not sub_key_exists(self._key, r"%s\%s\%s" % (self._sub_key, self._name, name)):
            if not value_exists(self._key, r"%s\%s" % (self._sub_key, self._name), name):
                raise AttributeNotFound(name)
            value = winreg.QueryValueEx(self._key_handle, name)
            value_data = value[0]
            value_type = value[1]
            return Value(self._key, r"%s\%s" % (self._sub_key, self._name), name, value_data, value_type)
        return Key(self._key, r"%s\%s" % (self._sub_key, self._name), name)

    def __getitem__(self, name):
        'Return the new Key Instance over a Item'
        if not sub_key_exists(self._key, r"%s\%s\%s" % (self._sub_key, self._name, name)):
            if not value_exists(self._key, r"%s\%s" % (self._sub_key, self._name), name):
                raise AttributeNotFound(name)
            value = winreg.QueryValueEx(self._key_handle, name)
            value_data = value[0]
            value_type = value[1]
            return Value(self._key, r"%s\%s" % (self._sub_key, self._name), name, value_data, value_type)
        return Key(self._key, r"%s\%s" % (self._sub_key, self._name), name)

    def __delitem__(self, index):
        if self[index].is_key():
            for key in self[index].get_keys():
                del self[index][key.get_name()]
            key_path = r"%s\%s\%s" % (self._sub_key, self._name, index)
            #print key_path
            #winreg.DeleteKey(self._key_handle, key_path)
            winreg.DeleteKey(REG_MAPPING[self._key], key_path)
        else:
            winreg.DeleteValue(self._key_handle, key_path)

    def __contains__(self, index):
        self.reset()
        while self._key_index < self._key_count:
            if self._get_next_key().name == index:
                return True
        while self._value_index < self._value_count:
            if self._get_next_value().name == index:
                return True
        return False

    def iteritems(self):
        for child in self:
            yield((child.get_name(), child))

    def create_key(self, key_name):
        handle = winreg.CreateKey(REG_MAPPING[self._key], r'%s\%s\%s' % (self._sub_key, self._name, key_name))
        return Key(self._key, r'%s\%s' % (self._sub_key, self._name), key_name)

    def get_name(self):
        return self._name

    def set_name(self, value):
        pass
        #self._name = value

    def del_name(self):
        pass

    def set_value(self, value_name, value_type, value_data):
        winreg.SetValueEx(self._key_handle, value_name, 0, value_type, value_data)

    """
    # __getattr__ is a better solution!
    def _set_values(self):

        # winreg.QueryInfoKey:
        # Returns information about a key, as a tuple.
        #
        # Index        Meaning
        # 0            An integer giving the number of sub keys this key has.
        # 1         An integer giving the number of values this key has.
        # 2         An integer giving when the key was last modified (if available) as 100?s of nanoseconds since Jan 1, 1600.
        value_count = winreg.QueryInfoKey(self._key_handle)[1]
        for i in range(0, value_count):

            # winreg.EnumValue:
            # Enumerates values of an open registry key, returning a tuple.
            #
            # The result is a tuple of 3 items:
            # Index     Meaning
            # 0         A string that identifies the value name
            # 1         An object that holds the value data, and whose type depends on the underlying registry type
            # 2         An integer that identifies the type of the value data
            value = winreg.EnumValue(self._key_handle, i)

            value_name = value[0]
            value_data = value[1]
            value_type = value[2]

            setattr(self, value_name, Value(self._key, self._sub_key, value_name, value_data, value_type))

    def _set_keys(self):

        key_handle = winreg.OpenKey(REG_MAPPING[self._key], "%s\%s" % (self._sub_key, self._name))

        # winreg.QueryInfoKey:
        # Returns information about a key, as a tuple.
        #
        # Index        Meaning
        # 0            An integer giving the number of sub keys this key has.
        # 1         An integer giving the number of values this key has.
        # 2         An integer giving when the key was last modified (if available) as 100?s of nanoseconds since Jan 1, 1600.
        key_count = winreg.QueryInfoKey(self._key_handle)[0]
        for i in range(0, key_count):

            # winreg.EnumKey:
            # Enumerates values of an open registry key, returning a tuple.
            #
            # The result is the name of a key
            key_name = winreg.EnumKey(self._key_handle, i)

            setattr(self, key_name, partial(self._get_key, key_name))

    def _get_key(self, key_name):
        return Key(self._key, "%s\%s" % (self._sub_key, self._name), key_name)
    """
    def get_values(self):

        # winreg.QueryInfoKey:
        # Returns information about a key, as a tuple.
        #
        # Index        Meaning
        # 0            An integer giving the number of sub keys this key has.
        # 1         An integer giving the number of values this key has.
        # 2         An integer giving when the key was last modified (if available) as 100?s of nanoseconds since Jan 1, 1600.
        value_count = winreg.QueryInfoKey(self._key_handle)[1]
        for i in range(0, value_count):

            # winreg.EnumValue:
            # Enumerates values of an open registry key, returning a tuple.
            #
            # The result is a tuple of 3 items:
            # Index     Meaning
            # 0         A string that identifies the value name
            # 1         An object that holds the value data, and whose type depends on the underlying registry type
            # 2         An integer that identifies the type of the value data
            value = winreg.EnumValue(self._key_handle, i)

            value_name = value[0]
            value_data = value[1]
            value_type = value[2]

            yield Value(self._key, self._sub_key, value_name, value_data, value_type)

    def get_keys(self):

        key_handle = winreg.OpenKey(REG_MAPPING[self._key], "%s\%s" % (self._sub_key, self._name))

        # winreg.QueryInfoKey:
        # Returns information about a key, as a tuple.
        #
        # Index     Meaning
        # 0         An integer giving the number of sub keys this key has.
        # 1         An integer giving the number of values this key has.
        # 2         An integer giving when the key was last modified (if available) as 100?s of nanoseconds since Jan 1, 1600.
        key_count = winreg.QueryInfoKey(self._key_handle)[0]
        for i in range(0, key_count):

            # winreg.EnumKey:
            # Enumerates values of an open registry key, returning a tuple.
            #
            # The result is the name of a key
            key_name = winreg.EnumKey(self._key_handle, i)

            yield Key(self._key, "%s\%s" % (self._sub_key, self._name), key_name)

    def get_key_count(self):

        key_handle = winreg.OpenKey(REG_MAPPING[self._key], "%s\%s" % (self._sub_key, self._name))

        # winreg.QueryInfoKey:
        # Returns information about a key, as a tuple.
        #
        # Index     Meaning
        # 0         An integer giving the number of sub keys this key has.
        # 1         An integer giving the number of values this key has.
        # 2         An integer giving when the key was last modified (if available) as 100?s of nanoseconds since Jan 1, 1600.
        key_count = winreg.QueryInfoKey(self._key_handle)[0]
        return key_count

    def __del__(self):
        try:
            winreg.CloseKey(self._key_handle)
        except:
            pass

    name = property(get_name, set_name, del_name, "'name' property.")


def set_value(key, sub_key, value_name, value_type, value_data):
    # https://docs.python.org/2/faq/design.html#why-can-t-raw-strings-r-strings-end-with-a-backslash
    key = key.strip("\\")
    sub_key = sub_key.strip("\\").encode(REGISTRY_ENCODING)
    value_name = value_name.strip("\\").encode(REGISTRY_ENCODING)

    if sub_key_exists(key, sub_key) == False:
        key_handle = winreg.CreateKey(REG_MAPPING[key], sub_key)

    if value_type:
        key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key, 0, winreg.KEY_SET_VALUE)
        winreg.SetValueEx(key_handle, value_name, 0, value_type, value_data)


def get_value(key, sub_key, value_name):
    # https://docs.python.org/2/faq/design.html#why-can-t-raw-strings-r-strings-end-with-a-backslash
    key = key.strip("\\")
    sub_key = sub_key.strip("\\").encode(REGISTRY_ENCODING)
    value_name = value_name.strip("\\").encode(REGISTRY_ENCODING)

    #print key, sub_key, value_name

    if not key in REG_MAPPING:
        return "ERROR"

    key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key)
    value = winreg.QueryValueEx(key_handle, value_name)
    winreg.CloseKey(key_handle)
    value_data, value_type = value
    return Value(key, sub_key, value_name, value_data, value_type)


def sub_key_exists(key, sub_key):

    key = key.strip("\\")
    sub_key = sub_key.strip("\\").encode(REGISTRY_ENCODING)

    try:
        key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key)
    except WindowsError, err:
        return False
    winreg.CloseKey(key_handle)
    return True


def value_exists(key, sub_key, value_name):
    # https://docs.python.org/2/faq/design.html#why-can-t-raw-strings-r-strings-end-with-a-backslash
    key = key.strip("\\")
    sub_key = sub_key.strip("\\").encode(REGISTRY_ENCODING)

    try:
        key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key)
        value = winreg.QueryValueEx(key_handle, value_name)
    except WindowsError, err:
        return False
    winreg.CloseKey(key_handle)
    return True


def get_values(key, sub_key):
    # https://docs.python.org/2/faq/design.html#why-can-t-raw-strings-r-strings-end-with-a-backslash
    key = key.strip("\\")
    sub_key = sub_key.strip("\\")

    key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key)

    # winreg.QueryInfoKey:
    # Returns information about a key, as a tuple.
    #
    # Index        Meaning
    # 0            An integer giving the number of sub keys this key has.
    # 1         An integer giving the number of values this key has.
    # 2         An integer giving when the key was last modified (if available) as 100?s of nanoseconds since Jan 1, 1600.
    value_count = winreg.QueryInfoKey(key_handle)[1]
    for i in range(0, value_count):

        # winreg.EnumValue:
        # Enumerates values of an open registry key, returning a tuple.
        #
        # The result is a tuple of 3 items:
        # Index     Meaning
        # 0         A string that identifies the value name
        # 1         An object that holds the value data, and whose type depends on the underlying registry type
        # 2         An integer that identifies the type of the value data
        value = winreg.EnumValue(key_handle, i)

        value_name = value[0]
        value_data = value[1]
        value_type = value[2]

        yield Value(value_name, value_data, value_type)

    winreg.CloseKey(key_handle)


def get_keys(key, sub_key):
    # https://docs.python.org/2/faq/design.html#why-can-t-raw-strings-r-strings-end-with-a-backslash
    key = key.strip("\\")
    sub_key = sub_key.strip("\\")

    if sub_key_exists(key, sub_key) == False:
        raise KeyNotFound(r"%s\%s" % (key, sub_key))

    key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key)

    # winreg.QueryInfoKey:
    # Returns information about a key, as a tuple.
    #
    # Index        Meaning
    # 0            An integer giving the number of sub keys this key has.
    # 1         An integer giving the number of values this key has.
    # 2         An integer giving when the key was last modified (if available) as 100?s of nanoseconds since Jan 1, 1600.
    key_count = winreg.QueryInfoKey(key_handle)[0]
    for i in range(0, key_count):

        # winreg.EnumValue:
        # Enumerates values of an open registry key, returning a tuple.
        #
        # The result is a tuple of 3 items:
        # Index     Meaning
        # 0         A string that identifies the value name
        # 1         An object that holds the value data, and whose type depends on the underlying registry type
        # 2         An integer that identifies the type of the value data
        key_name = winreg.EnumKey(key_handle, i)

        yield Key(key, sub_key, key_name)

    winreg.CloseKey(key_handle)


def delete_key(key, sub_key):
    # https://docs.python.org/2/faq/design.html#why-can-t-raw-strings-r-strings-end-with-a-backslash
    key = key.strip("\\")
    sub_key = sub_key.strip("\\")
    winreg.DeleteKey(key, sub_key)

    # IMPORTANT:
    # If you need to Delete a Key, you need to set the access mask to KEY_WRITE!
    # Default Value is KEY_READ!
    key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key, 0, winreg.KEY_WRITE)
    winreg.DeleteKey(key_handle, sub_key)
    winreg.CloseKey(key_handle)


def del_value(key, sub_key, value):
    # https://docs.python.org/2/faq/design.html#why-can-t-raw-strings-r-strings-end-with-a-backslash
    value = value.strip("\\")
    key = key.strip("\\")
    sub_key = sub_key.strip("\\")

    # IMPORTANT:
    # If you need to Delete a Key, you need to set the access mask to KEY_WRITE!
    # Default Value is KEY_READ!
    key_handle = winreg.OpenKey(REG_MAPPING[key], sub_key, 0, winreg.KEY_WRITE)
    winreg.DeleteValue(key_handle, value)
    winreg.CloseKey(key_handle)