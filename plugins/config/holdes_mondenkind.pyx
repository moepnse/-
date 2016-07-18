# -*- coding: utf-8 -*-

# standard library imports
import os
import sys
import re
import copy
import platform
import urllib
import urlparse
import traceback
import sqlite3

# third party imports


# application/library imports
import libs.handlers.config
import libs
from libs.win import software
from libs.win import system


# standard library cimports
from cpython.ref cimport PyObject
#from cpython.mem cimport PyMem_Malloc, PyMem_Realloc, PyMem_Free
from cpython.ref cimport Py_INCREF, Py_DECREF
from cpython.long cimport PyLong_AsVoidPtr
from libc.stdlib cimport malloc, free, calloc

# application/library cimports
from libs.handlers.config cimport Base, Settings as BaseSettings, ConnectionList as BaseConnectionList, LogList as BaseLogList, InstallList as BaseInstallList, HostList as BaseHostList, Package as BasePackage, PackageList as BasePackageList, ProfileList as BaseProfileList, Cmd, Host, Profile
from libs.win.software cimport SoftwareList
from pi_service cimport ON_START, ON_SHUTDOWN, REPEATEDLY, CURRENT_USER, WINLOGON
from c_lua cimport lua_State, luaL_newstate, luaL_openlibs, luaL_loadfile, lua_pcall, lua_close, lua_pushcfunction, lua_setglobal, lua_getglobal, lua_tonumber, lua_pushnumber, luaL_checkstring, luaL_checkinteger, lua_toboolean, lua_tointeger, lua_pushlightuserdata, lua_rawlen, lua_pushinteger, lua_pop, lua_rawgeti, luaL_getn, lua_tolstring, lua_tostring, lua_isstring, lua_typename, lua_type, lua_next, lua_pushnil, lua_istable, lua_isinteger, lua_isnumber, lua_isboolean, lua_touserdata, lua_pushboolean, lua_pushcclosure, lua_getmetatable, lua_newuserdata, luaL_getmetatable, lua_setmetatable, lua_pushstring, lua_upvalueindex, luaL_newmetatable, lua_settable, lua_isfunction, lua_gettop, lua_rawseti, lua_setfield, lua_createtable, lua_newtable, luaL_ref, LUA_REGISTRYINDEX, lua_isnil, lua_pushvalue, lua_Integer, lua_getinfo, lua_Debug, lua_getstack, LUA_TSTRING, LUA_TBOOLEAN, LUA_TNUMBER, LUA_MASKLINE, lua_sethook, LUA_ERRFILE
from c_windows_data_types cimport LPSTR, LPTSTR, DWORD, LPBYTE, LPWSTR, LPCWSTR, BYTE, PBYTE, LPVOID,  WCHAR, UINT, PUINT, LPDWORD, LONG, PHKEY
from c_windows cimport NetShareEnum, NetApiBufferFree, NetApiBufferFree, SHARE_INFO_502, NET_API_STATUS,  MAX_PREFERRED_LENGTH, ERROR_SUCCESS, ERROR_MORE_DATA, PSHARE_INFO_502, STYPE_DISKTREE, STYPE_PRINTQ, STYPE_DEVICE, STYPE_IPC, STYPE_SPECIAL, STYPE_TEMPORARY, ACCESS_READ, ACCESS_WRITE, ACCESS_CREATE, ACCESS_EXEC, ACCESS_DELETE, ACCESS_ATRIB, ACCESS_PERM, ACCESS_ALL, Sleep, GetFileVersionInfoSizeW, VS_FIXEDFILEINFO, GetFileVersionInfoW, VerQueryValueW, HIWORD, LOWORD, GetLastError, DsRoleGetPrimaryDomainInformation, DSROLE_PRIMARY_DOMAIN_INFO_BASIC, DsRolePrimaryDomainInfoBasic, GetComputerNameExW, ComputerNameDnsDomain, ComputerNameDnsFullyQualified, ComputerNameDnsHostname, ComputerNameNetBIOS, ComputerNamePhysicalDnsDomain, ComputerNamePhysicalDnsFullyQualified, ComputerNamePhysicalDnsHostname, ComputerNamePhysicalNetBIOS, COMPUTER_NAME_FORMAT,HKEY_CLASSES_ROOT, HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE, HKEY_USERS, HKEY_PERFORMANCE_DATA, HKEY_PERFORMANCE_TEXT, HKEY_PERFORMANCE_NLSTEXT, HKEY_CURRENT_CONFIG, HKEY_DYN_DATA, RegCreateKeyExW, HKEY, RegOpenKeyExW, RegQueryValueExW, RegCloseKey, KEY_QUERY_VALUE, KEY_READ, KEY_SET_VALUE, KEY_CREATE_SUB_KEY, REG_NONE, REG_SZ, REG_EXPAND_SZ, REG_BINARY, REG_DWORD, REG_DWORD_LITTLE_ENDIAN, REG_DWORD_BIG_ENDIAN, REG_LINK, REG_MULTI_SZ, REG_RESOURCE_LIST, REG_FULL_RESOURCE_DESCRIPTOR, REG_RESOURCE_REQUIREMENTS_LIST, REG_QWORD, REG_QWORD_LITTLE_ENDIAN, RegSetValueExW, KEY_ALL_ACCESS


cdef extern from "stdio.h":
    int sprintf(char *, char *,...) 

file_extension = "lua"
plugin_name = "holdes_mondenkind"
api_versions = ["1.0"]
flags = {"1.0": 100}


cdef:
    object lua_log_err
    object lua_log_out
    object lua_log_debug

    enum cmd_type:
        ct_string,
        ct_lua_cmd

    union un_cmd:
        const char* cmd
        void *lua_cmd

    struct cmd:
        cmd_type type
        un_cmd cmd

    enum allowed_types:
        BOOLEAN,
        INTEGER,
        STRING,
        ARRAY,
        DICT,
        FUNCTION

    int current_line = 0

cdef lua_stack_dump(lua_State *L):
    cdef:
        int i
        int t
        int top = lua_gettop(L)
    for i in range(0, top): 
        t = lua_type(L, i);
        if t == LUA_TSTRING:
            print lua_tostring(L, i)
        elif t == LUA_TBOOLEAN:
            print lua_toboolean(L, i)
        elif t == LUA_TNUMBER:
            print lua_tonumber(L, i)
        else:
            print lua_typename(L, t)


cdef void lua_hook(lua_State* L, lua_Debug *ar):
    global current_line
    lua_getinfo(L, "n", ar)
    current_line = ar.currentline


cdef int lua_get_current_line_number(lua_State *L):
    cdef:
        lua_Debug ar
        int line
        int level = 0
    """
    This function fills parts of a lua_Debug structure with an identification of the activation record of the function executing at a given level. Level 0 is the current running function, whereas level n+1 is the function that has called level n (except for tail calls, which do not count on the stack). When there are no errors, lua_getstack returns 1; when called with a level greater than the stack depth, it returns 0. 
    """
    if lua_getstack(L, level, &ar) == 0:
        return -1
    """
    Each character in the string what selects some fields of the structure ar to be filled or a value to be pushed on the stack:
        'n': fills in the field name and namewhat;
        'S': fills in the fields source, short_src, linedefined, lastlinedefined, and what;
        'l': fills in the field currentline;
        'u': fills in the field nups;
        'f': pushes onto the stack the function that is running at the given level;
        'L': pushes onto the stack a table whose indices are the numbers of the lines that are valid on the function. (A valid line is a line with some associated code, that is, a line where you can put a break point. Non-valid lines include empty lines and comments.)

    This function returns 0 on error (for instance, an invalid option in what). 
    """
    lua_getinfo(L, <const char*>"nSl", &ar)
    line = ar.currentline
    return line


cdef unicode lua_string_to_python_unicode(lua_State *L, int index):
    cdef:
        const char *lua_string = ""
        size_t length = 0
    lua_string = lua_tolstring (L, index, &length)
    return lua_string[:length].decode("utf-8")


cdef int l_log_debug(lua_State *L):
    cdef const char* msg = luaL_checkstring(L, 1)
    return 0


cdef int l_log_info(lua_State *L):
    cdef const char* msg = luaL_checkstring(L, 1)
    return 0


cdef int l_log_warn(lua_State *L):
    cdef const char* msg = luaL_checkstring(L, 1)
    return 0


cdef int l_log_err(lua_State *L):
    cdef const char* msg = luaL_checkstring(L, 1)
    return 0


cdef lua_push_logging(lua_State *l):
    lua_pushcfunction(l, l_log_debug)
    lua_setglobal(l, "log_debug")

    lua_pushcfunction(l, l_log_info)
    lua_setglobal(l, "log_info")

    lua_pushcfunction(l, l_log_warn)
    lua_setglobal(l, "log_warn")

    lua_pushcfunction(l, l_log_err)
    lua_setglobal(l, "log_err")


cdef lua_push_is_array(lua_State *l):
    lua_pushcfunction(l, l_is_array)
    lua_setglobal(l, "is_array")


cdef int __handle_lua_func(lua_State *L, cmd *p_func, int index):
    cdef:
        LuaCmd lua_cmd
    if lua_isstring(L, index):
        # dereference and access data member cmd and type.
        p_func.cmd.cmd = lua_tostring(L, index)
        p_func.type = ct_string
    elif lua_isfunction(L, index):
        lua_pushvalue(L, index)
        ref = luaL_ref(L, LUA_REGISTRYINDEX)
        lua_cmd = LuaCmd(<long>L, ref)
        # Cython is unable to do the refcounting automatically when a Python object is used as a union, or struct member. 
        Py_INCREF(lua_cmd)
        # dereference and access data member lua_cmd and type.
        p_func.cmd.lua_cmd = <PyObject*>lua_cmd
        p_func.type = ct_lua_cmd
    return 0


cdef lua_push_winreg(lua_State *l):

    lua_pushinteger(l, <lua_Integer>REG_NONE)
    lua_setglobal(l, "REG_NONE")

    lua_pushinteger(l, <lua_Integer>REG_SZ)
    lua_setglobal(l, "REG_SZ")

    lua_pushinteger(l, <lua_Integer>REG_EXPAND_SZ)
    lua_setglobal(l, "REG_EXPAND_SZ")

    lua_pushinteger(l, <lua_Integer>REG_BINARY)
    lua_setglobal(l, "REG_BINARY")

    lua_pushinteger(l, <lua_Integer>REG_DWORD)
    lua_setglobal(l, "REG_DWORD")

    lua_pushinteger(l, <lua_Integer>REG_DWORD_LITTLE_ENDIAN)
    lua_setglobal(l, "REG_DWORD_LITTLE_ENDIAN")

    lua_pushinteger(l, <lua_Integer>REG_DWORD_BIG_ENDIAN)
    lua_setglobal(l, "REG_DWORD_BIG_ENDIAN")

    lua_pushinteger(l, <lua_Integer>REG_LINK)
    lua_setglobal(l, "REG_LINK")

    lua_pushinteger(l, <lua_Integer>REG_MULTI_SZ)
    lua_setglobal(l, "REG_MULTI_SZ")

    lua_pushinteger(l, <lua_Integer>REG_RESOURCE_LIST)
    lua_setglobal(l, "REG_RESOURCE_LIST")

    lua_pushinteger(l, <lua_Integer>REG_FULL_RESOURCE_DESCRIPTOR)
    lua_setglobal(l, "REG_FULL_RESOURCE_DESCRIPTOR")

    lua_pushinteger(l, <lua_Integer>REG_RESOURCE_REQUIREMENTS_LIST)
    lua_setglobal(l, "REG_RESOURCE_REQUIREMENTS_LIST")

    lua_pushinteger(l, <lua_Integer>REG_QWORD)
    lua_setglobal(l, "REG_QWORD")

    lua_pushinteger(l, <lua_Integer>REG_QWORD_LITTLE_ENDIAN)
    lua_setglobal(l, "REG_QWORD_LITTLE_ENDIAN")

    lua_pushlightuserdata(l, HKEY_CLASSES_ROOT)
    lua_setglobal(l, "HKEY_CLASSES_ROOT")

    lua_pushlightuserdata(l, HKEY_CURRENT_CONFIG)
    lua_setglobal(l, "HKEY_CURRENT_CONFIG")

    lua_pushlightuserdata(l, HKEY_CURRENT_USER)
    lua_setglobal(l, "HKEY_CURRENT_USER")

    lua_pushlightuserdata(l, HKEY_LOCAL_MACHINE)
    lua_setglobal(l, "HKEY_LOCAL_MACHINE")

    lua_pushlightuserdata(l, HKEY_USERS)
    lua_setglobal(l, "HKEY_USERS")

    lua_pushcfunction(l, l_winreg_create_key)
    lua_setglobal(l, "winreg_create_key")

    lua_pushcfunction(l, l_winreg_query_value)
    lua_setglobal(l, "winreg_query_value")

    lua_pushcfunction(l, l_winreg_set_value)
    lua_setglobal(l, "winreg_set_value")


cdef int l_winreg_create_key(lua_State *L):
    cdef:
        LONG ret_val
    return 0


cdef int l_winreg_query_value(lua_State *L):
    cdef:
        HKEY h_reserved_key = <HKEY>lua_touserdata(L, 1)
        HKEY h_key
        unicode sub_key = lua_string_to_python_unicode(L, 2)
        unicode value_name =lua_string_to_python_unicode(L, 3)
        DWORD type = 0
        DWORD size = 1024
        #char *res = <char *>malloc(size)
        LPBYTE res = <LPBYTE>calloc(1, size)
        LONG ret_val
    ret_val = RegOpenKeyExW(h_reserved_key, <LPCWSTR>sub_key,
0, KEY_QUERY_VALUE, &h_key)
    if ret_val == ERROR_SUCCESS:
        ret_val = RegQueryValueExW(h_key,
            <LPCWSTR>value_name,
            NULL,
            &type,
            <LPBYTE>res,
            &size)
        RegCloseKey(h_key)
    lua_pushinteger(L, <lua_Integer>ret_val)
    lua_pushinteger(L, <lua_Integer>type)
    """
    REG_BINARY
    Binary data in any form.

    REG_DWORD
    32-bit number.

    REG_QWORD
    64-bit number.

    REG_DWORD_LITTLE_ENDIAN
    32-bit number in little-endian format. This is equivalent to REG_DWORD.

    In little-endian format, a multibyte value is stored in memory from the lowest byte (the "little end") to the highest byte. For example, the value 0x12345678 is stored as (0x78 0x56 0x34 0x12) in little-endian format.

    REG_QWORD_LITTLE_ENDIAN
    A 64-bit number in little-endian format. This is equivalent to REG_QWORD.

    REG_DWORD_BIG_ENDIAN
    32-bit number in big-endian format.

    In big-endian format, a multibyte value is stored in memory from the highest byte (the "big end") to the lowest byte. For example, the value 0x12345678 is stored as (0x12 0x34 0x56 0x78) in big-endian format.

    REG_EXPAND_SZ
    Null-terminated string that contains unexpanded references to environment variables (for example, "%PATH%"). It will be a Unicode or ANSI string, depending on whether you use the Unicode or ANSI functions.

    REG_LINK
    Unicode symbolic link.

    REG_MULTI_SZ
    Array of null-terminated strings that are terminated by two null characters.

    REG_NONE
    No defined value type.

    REG_RESOURCE_LIST
    Device-driver resource list.

    REG_SZ
    Null-terminated string. It will be a Unicode or ANSI string, depending on whether you use the Unicode or ANSI functions.
    """
    if type in (REG_DWORD,
REG_QWORD):
        lua_pushinteger(L,<lua_Integer>(<lua_Integer*>res)[0])
    elif type in (REG_EXPAND_SZ, REG_SZ):
        lua_pushstring(L, <const char*>res)
    free(res)
    return 3


cdef union RegValue:
    DWORD dw_data
    bint b_data
    BYTE* data


cdef int l_winreg_set_value(lua_State *L):
    cdef:
        HKEY h_reserved_key = <HKEY>lua_touserdata(L, 1)
        HKEY h_key
        unicode sub_key = lua_string_to_python_unicode(L, 2)
        unicode value_name =lua_string_to_python_unicode(L, 3)
        DWORD type = <DWORD>lua_tointeger(L, 4)
        RegValue reg_value
        LONG ret_val
        DWORD size

    if lua_isboolean(L , 5):
        reg_value.b_data = <bint>lua_toboolean(L, 5)
        size = sizeof(bint)
    elif lua_isinteger(L, 5):
        reg_value.dw_data = <DWORD>lua_tointeger(L, 5)
        size = sizeof(DWORD)
    elif lua_isstring(L, 5):
        reg_value.data = <BYTE*>lua_tostring(L, 5)
        size = len(reg_value.data) * sizeof(BYTE)
    else:
        print >>lua_log_err, "Error in winreg_set_value(): Unknown type!"
    #ret_val =  RegOpenKeyExW(h_reserved_key, <LPCWSTR>sub_key, 0, KEY_ALL_ACCESS, &h_key)
    ret_val =  RegOpenKeyExW(h_reserved_key, <LPCWSTR>sub_key, 0, KEY_READ | KEY_SET_VALUE, &h_key)
    if ret_val == ERROR_SUCCESS:
        ret_val = RegSetValueExW(
            h_key,
            <LPCWSTR>value_name,
            0,
            type,
            <const BYTE *>&(reg_value.data),
            size
        )
        RegCloseKey(h_key)
    lua_pushinteger(L, ret_val)
    return 1


cdef int l_set_package_check_functions(lua_State *L):
    cdef:
        const char * package_id = luaL_checkstring(L, 1)
        int cmd_size = sizeof(cmd)
        cmd *func1 = <cmd*>malloc(cmd_size)
        cmd *func2 = <cmd*>malloc(cmd_size)
        PyObject* p_package_list
        PackageList package_list
        Package package
        int ref
    __handle_lua_func(L, func1, 2)
    __handle_lua_func(L, func2, 3)
    lua_getglobal(L, 'p_package_list')
    p_package_list = <PyObject*>lua_touserdata (L, -1)
    package_list = <object>p_package_list
    package = package_list[package_id]
    package.set_lua_check_functions(L, func1, func2)
    return 0


cdef bint get_domain_info(DSROLE_PRIMARY_DOMAIN_INFO_BASIC **info):
    cdef:
        DWORD dw

    global lua_log_err
    dw = DsRoleGetPrimaryDomainInformation(NULL, DsRolePrimaryDomainInfoBasic, <PBYTE *>info)
    if dw != ERROR_SUCCESS:
        lua_log_err("DsRoleGetPrimaryDomainInformation() failed with error code: %d" % GetLastError())
        return False
    return True


cdef int l_get_domain_name (lua_State *L):
    cdef:
        DSROLE_PRIMARY_DOMAIN_INFO_BASIC *info
        const char* domain_name_dns = ""

    get_domain_info(&info)
    if info.DomainNameDns != NULL:
        domain_name_dns = <const char*>info.DomainNameDns
    # Pushes the zero-terminated string pointed to by s onto the stack. Lua makes (or reuses) an internal copy of the given string, so the memory at s can be freed or reused immediately after the function returns. The string cannot contain embedded zeros; it is assumed to end at the first zero. 
    lua_pushstring(L, domain_name_dns)

    return 1


cdef int l_get_netbios_domain_name (lua_State *L):
    cdef:
        DSROLE_PRIMARY_DOMAIN_INFO_BASIC *info

    get_domain_info(&info)

    # Pushes the zero-terminated string pointed to by s onto the stack. Lua makes (or reuses) an internal copy of the given string, so the memory at s can be freed or reused immediately after the function returns. The string cannot contain embedded zeros; it is assumed to end at the first zero. 
    lua_pushstring(L, <const char*>info.DomainNameFlat)

    return 1


cdef int l_get_forest_name (lua_State *L):
    cdef:
        DSROLE_PRIMARY_DOMAIN_INFO_BASIC *info
        const char* domain_forest_name = ""

    get_domain_info(&info)
    if info.DomainForestName != NULL:
        domain_forest_name = <const char*>info.DomainForestName
    # Pushes the zero-terminated string pointed to by s onto the stack. Lua makes (or reuses) an internal copy of the given string, so the memory at s can be freed or reused immediately after the function returns. The string cannot contain embedded zeros; it is assumed to end at the first zero. 
    lua_pushstring(L, domain_forest_name)

    return 1


cdef int _get_computer_name_ex_w_to_lua_mb_string (lua_State *L, COMPUTER_NAME_FORMAT format):
    cdef:
        WCHAR w_buffer[256]
        unicode u_buffer
        bytes buffer
        DWORD dw_size = sizeof(w_buffer)

    GetComputerNameExW(format, <LPWSTR>w_buffer, &dw_size)
    u_buffer = <unicode>w_buffer
    buffer = u_buffer.encode("utf-8")
    # Pushes the zero-terminated string pointed to by s onto the stack. Lua makes (or reuses) an internal copy of the given string, so the memory at s can be freed or reused immediately after the function returns. The string cannot contain embedded zeros; it is assumed to end at the first zero. 
    lua_pushstring(L, <const char*>buffer)
    return 0


cdef int l_get_computer_name_net_bios (lua_State *L):
    """
    The NetBIOS name of the local computer or the cluster associated with the local computer.
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNameNetBIOS)
    return 1


cdef int l_get_computer_name_dns_hostname (lua_State *L):
    """
    The DNS name of the local computer or the cluster associated with the local computer.
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNameDnsHostname)
    return 1


cdef int l_get_computer_name_dns_domain (lua_State *L):
    """
    The name of the DNS domain assigned to the local computer or the cluster associated with the local computer.
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNameDnsDomain)
    return 1


cdef int l_get_computer_name_dns_fully_qualified (lua_State *L):
    """
    The fully qualified DNS name that uniquely identifies the local computer or the cluster associated with the local computer.

    This name is a combination of the DNS host name and the DNS domain name, using the form HostName.DomainName. For example, if the DNS host name is "samba" and the DNS domain name is "unicom.ws", the fully qualified DNS name is "samba.unicom.ws".
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNameDnsFullyQualified)
    return 1


cdef int l_get_computer_name_physical_net_bios (lua_State *L):
    """
    The NetBIOS name of the local computer. On a cluster, this is the NetBIOS name of the local node on the cluster.
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNamePhysicalNetBIOS)
    return 1


cdef int l_get_computer_name_physical_dns_hostname (lua_State *L):
    """
    The DNS host name of the local computer. On a cluster, this is the DNS host name of the local node on the cluster.
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNamePhysicalDnsHostname)
    return 1


cdef int l_get_computer_name_physical_dns_domain (lua_State *L):
    """"
    The name of the DNS domain assigned to the local computer. On a cluster, this is the DNS domain of the local node on the cluster.
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNamePhysicalDnsDomain)
    return 1


cdef int l_get_computer_name_physical_dns_fully_qualified (lua_State *L):
    """
    The fully qualified DNS name that uniquely identifies the computer. On a cluster, this is the fully qualified DNS name of the local node on the cluster. The fully qualified DNS name is a combination of the DNS host name and the DNS domain name, using the form HostName.DomainName.
    """
    _get_computer_name_ex_w_to_lua_mb_string(L, ComputerNamePhysicalDnsFullyQualified)
    return 1


cdef bint lua_push_get_computer_name_ex_functions(lua_State *L):
    lua_pushcfunction(L, l_get_computer_name_net_bios)
    lua_setglobal(L, "get_computer_name_net_bios")

    lua_pushcfunction(L, l_get_computer_name_dns_hostname)
    lua_setglobal(L, "get_computer_name_dns_hostname")

    lua_pushcfunction(L, l_get_computer_name_dns_domain)
    lua_setglobal(L, "get_computer_name_dns_domain")

    lua_pushcfunction(L, l_get_computer_name_dns_fully_qualified)
    lua_setglobal(L, "get_computer_name_dns_fully_qualified")

    lua_pushcfunction(L, l_get_computer_name_physical_net_bios)
    lua_setglobal(L, "get_computer_name_physical_net_bios")

    lua_pushcfunction(L, l_get_computer_name_physical_dns_hostname)
    lua_setglobal(L, "get_computer_name_physical_dns_hostname")

    lua_pushcfunction(L, l_get_computer_name_physical_dns_domain)
    lua_setglobal(L, "get_computer_name_physical_dns_domain")

    lua_pushcfunction(L, l_get_computer_name_physical_dns_fully_qualified)
    lua_setglobal(L, "get_computer_name_physical_dns_fully_qualified")


cdef int software_list_iter (lua_State *L):
    cdef:
        PyObject* p_software_list
        PyObject* p_software_list_iter
        SoftwareList obj_software_list
        object obj_software_list_iter
        object key
        object entry
        object key2
    p_software_list = <PyObject *>lua_touserdata(L, lua_upvalueindex(1))
    p_software_list_iter = <PyObject *>lua_touserdata(L, lua_upvalueindex(2))
    obj_software_list = <object>p_software_list
    obj_software_list_iter = <object>p_software_list_iter
    try:
        key = obj_software_list_iter.next()
        entry = obj_software_list[key]
        key2 = key.encode("UTF-8")
        lua_pushstring(L, <char*>key2)
        return 1
    except StopIteration:
        # no more values to return
        return 0
    except:
        traceback.print_exc()
        return 0


cdef int software_list_gc( lua_State* L ):
    cdef:
        PyObject* p_software_list
        SoftwareList obj_software_list
        PyObject* p_software_list_iter
        object obj_software_list_iter
    p_software_list = <PyObject *>lua_touserdata(L, lua_upvalueindex(1))
    obj_software_list = <object>p_software_list
    Py_DECREF(obj_software_list)
    p_software_list_iter = <PyObject *>lua_touserdata(L, lua_upvalueindex(2))
    obj_software_list_iter = <object>p_software_list_iter
    Py_DECREF(obj_software_list_iter)
    return 0


cdef int l_software_list (lua_State *L):
    cdef:
        PyObject* p_software_list
        PyObject* p_software_list_iter
        SoftwareList obj_software_list
        object obj_software_list_iter
        object entry
    luaL_newmetatable( L, "LuaBook.software_list" )
    lua_pushstring( L, "__gc" )
    lua_pushcfunction( L, software_list_gc)
    lua_settable( L, -3 )
    # create a userdatum to store a python object address 
    #p_software_list = <PyObject *>lua_newuserdata(L, sizeof(PyObject *))
    #p_software_list_iter = <PyObject *>lua_newuserdata(L, sizeof(PyObject *))
    obj_software_list = SoftwareList()
    obj_software_list_iter = iter(obj_software_list)
    lua_pushlightuserdata (L, <PyObject*>obj_software_list)
    lua_pushlightuserdata (L, <PyObject*>obj_software_list_iter)
    Py_INCREF(obj_software_list)
    Py_INCREF(obj_software_list_iter)
    #p_software_list[0] = <PyObject>((<PyObject*>software_list)[0])
    #p_software_list_iter[0] = <PyObject>((<PyObject*>software_list_iter)[0])
    # set its metatable
    luaL_getmetatable(L, "LuaBook.software_list")
    lua_setmetatable(L, -2)
    lua_pushcclosure(L, software_list_iter, 2)
    return 1


cdef int l_is_in_software_list(lua_State *L):
    cdef:
        const char* product_name = luaL_checkstring(L, 1)
        object product
        bint return_val = False
        basestring reg_product_name
        SoftwareList software_list = SoftwareList()
    for product in software_list.values():
        reg_product_name = product.product_name
        #self._log.log_debug('[holdes_mondenkind] [%d] product_name: %s' % (libs.common.get_current_line_nr(), reg_product_name))
        if reg_product_name.strip() == "":
            #self._log.log_warn('[holdes_mondenkind] [%d] Found an empty Entry in the Software-List!'  % libs.common.get_current_line_nr())
            continue
        return_val = re.match(product_name, reg_product_name) is not None
        #self._log.log_debug('[holdes_mondenkind] [%d] return value: %s' % (libs.common.get_current_line_nr(), condition_return_val))
        if return_val:
            lua_pushboolean(L, 1)
            return 1
    lua_pushboolean(L, 0)
    return 1


cdef int software_list2_iter (lua_State *L):
    cdef:
        PyObject* p_software_list
        PyObject* p_software_list_iter
        SoftwareList obj_software_list
        object obj_software_list_iter
        object key
        object entry
        object py_byte_string
    p_software_list = <PyObject *>lua_touserdata(L, lua_upvalueindex(1))
    p_software_list_iter = <PyObject *>lua_touserdata(L, lua_upvalueindex(2))
    obj_software_list = <object>p_software_list
    obj_software_list_iter = <object>p_software_list_iter
    try:
        key = obj_software_list_iter.next()
        entry = obj_software_list[key]

        # creates and pushes new table on top of Lua stack
        lua_createtable(L, 0, 5)
        py_byte_string = entry.display_name.encode("UTF-8")
        # Pushes table value on top of Lua stack
        lua_pushstring(L, <char*>py_byte_string)
        #table["name"] = row->name. Pops key value
        lua_setfield(L, -2, "display_name")

        # no need to keep a reference, lua_pushstring will create a copy
        py_byte_string = entry.display_version.encode("UTF-8")
        lua_pushstring(L, <char*>py_byte_string)
        lua_setfield(L, -2, "display_version")

        lua_pushinteger(L, <lua_Integer>(entry.version))
        lua_setfield(L, -2, "version")

        lua_pushinteger(L, <lua_Integer>(entry.version_major))
        lua_setfield(L, -2, "version_major")

        lua_pushinteger(L, <lua_Integer>(entry.version_minor))
        lua_setfield(L, -2, "version_minor")

        return 1
    except StopIteration:
        # no more values to return
        return 0
    except:
        traceback.print_exc()
        return 0


cdef int software_list2_gc( lua_State* L ):
    cdef:
        PyObject* p_software_list
        SoftwareList obj_software_list
        PyObject* p_software_list_iter
        object obj_software_list_iter
    p_software_list = <PyObject *>lua_touserdata(L, lua_upvalueindex(1))
    obj_software_list = <object>p_software_list
    Py_DECREF(obj_software_list)
    p_software_list_iter = <PyObject *>lua_touserdata(L, lua_upvalueindex(2))
    obj_software_list_iter = <object>p_software_list_iter
    Py_DECREF(obj_software_list_iter)
    return 0


cdef int l_software_list2 (lua_State *L):
    cdef:
        PyObject* p_software_list
        PyObject* p_software_list_iter
        SoftwareList obj_software_list
        object obj_software_list_iter
        object entry
    luaL_newmetatable( L, "LuaBook.software_list2" )
    lua_pushstring( L, "__gc" )
    lua_pushcfunction( L, software_list2_gc)
    lua_settable( L, -3 )
    # create a userdatum to store a python object address 
    #p_software_list = <PyObject *>lua_newuserdata(L, sizeof(PyObject *))
    #p_software_list_iter = <PyObject *>lua_newuserdata(L, sizeof(PyObject *))
    obj_software_list = SoftwareList()
    obj_software_list_iter = iter(obj_software_list)
    lua_pushlightuserdata (L, <PyObject*>obj_software_list)
    lua_pushlightuserdata (L, <PyObject*>obj_software_list_iter)
    Py_INCREF(obj_software_list)
    Py_INCREF(obj_software_list_iter)
    #p_software_list[0] = <PyObject>((<PyObject*>software_list)[0])
    #p_software_list_iter[0] = <PyObject>((<PyObject*>software_list_iter)[0])
    # set its metatable
    luaL_getmetatable(L, "LuaBook.software_list2")
    lua_setmetatable(L, -2)
    lua_pushcclosure(L, software_list2_iter, 2)
    return 1


cdef int l_is_upgrade_available(lua_State *L):
    cdef:
        unicode package_id = lua_string_to_python_unicode(L, 1)
        object version = lua_string_to_python_unicode(L, 2)
        #lua_Integer rev = lua_tointeger(L, 3)
        object rev = lua_string_to_python_unicode(L, 3)
        object package
        bint upgrade_available = False
        object installed_list
        object package_version = "0"
        #lua_Integer package_rev = 0
        object package_rev = "0"
        PyObject* p_installed_list
    lua_getglobal(L, "p_installed_list")
    p_installed_list = <PyObject*>lua_touserdata(L, -1)
    installed_list = <object>p_installed_list
    if package_id in installed_list:
        package = installed_list[package_id]
        #version = package.get("version", "0")
        #rev = <lua_Integer>package.get("rev", 0)
        package_version = package[1]
        package_rev = package[2]
        #print(package_version, package_rev)

        if version > package_version or (version == package_version and rev > package_rev):
            upgrade_available = True

    lua_pushboolean(L, upgrade_available)
    return 1


cdef int l_is_in_installed_list(lua_State *L):
    cdef:
        unicode package_id = lua_string_to_python_unicode(L, 1)
        object package
        bint installed = False
        object installed_list
        object version = "0"
        object rev = "0"
        #lua_Integer rev = 0
        PyObject* p_installed_list
    lua_getglobal(L, "p_installed_list")
    p_installed_list = <PyObject*>lua_touserdata(L, -1)
    installed_list = <object>p_installed_list
    if package_id in installed_list:
        #print "package is in installed_list"
        installed = True
        package = installed_list[package_id]
        #version = package.get("version", "0")
        #rev = <lua_Integer>package.get("rev", 0)
        version = package[1]
        rev = package[2]
        #print "IS_IN_INSTALLED_LIST", version, rev
    lua_pushboolean(L, installed)
    lua_pushstring(L, <const char*>version)
    #lua_pushinteger(L, rev)
    lua_pushstring(L, <const char*>rev)
    return 3


cdef int net_shares_iter (lua_State *L):
    cdef:
        PSHARE_INFO_502 p_share_info_502, p
        NET_API_STATUS res
        LPWSTR lpwstr_server = NULL
        const char* server_name = NULL
        unicode u_server_name = u""
        DWORD i
        DWORD* p_resume
        DWORD* p_er
        DWORD* p_tr
        DWORD* p_i
        bint* p_nse
        PSHARE_INFO_502* pp_share_info_502
        DWORD er = 0
        DWORD tr = 0

    lua_newtable(L)
    p_share_info_502 = <PSHARE_INFO_502>lua_touserdata(L, lua_upvalueindex(1))
    #lpwstr_server = <LPWSTR>lua_touserdata(L, lua_upvalueindex(2))
    server_name = lua_tostring(L, lua_upvalueindex(2))
    u_server_name = (server_name).decode("UTF-8")
    lpwstr_server = <LPWSTR>u_server_name
    #print "SERVER:", lpwstr_server
    p_resume = <DWORD*>lua_touserdata(L, lua_upvalueindex(3))
    p_er = <DWORD*>lua_touserdata(L, lua_upvalueindex(4))
    p_tr = <DWORD*>lua_touserdata(L, lua_upvalueindex(5))
    p_i = <DWORD*>lua_touserdata(L, lua_upvalueindex(6))
    p_nse = <bint*>lua_touserdata(L, lua_upvalueindex(7))
    pp_share_info_502 = <PSHARE_INFO_502*>lua_touserdata(L, lua_upvalueindex(8))

    er = p_er[0]
    tr = p_tr[0]
    #print er, tr
    if p_nse[0] == False:
        res = NetShareEnum(lpwstr_server, 502, <LPBYTE *> &p_share_info_502, MAX_PREFERRED_LENGTH, p_er, p_tr, p_resume)
        p_nse[0] = True
        # If the call succeeds
        if res == ERROR_SUCCESS or res == ERROR_MORE_DATA:
            pass
        else:
            return 0
        pp_share_info_502[0] = p_share_info_502

    # Loop through the entries
    if p_i[0] <= p_er[0]:
        #print p_i[0]
        lua_pushstring(L, (pp_share_info_502[0].shi502_netname).encode('UTF-8')) # Pushes table value on top of Lua stack
        lua_setfield(L, -2, "netname")  # table["netname"] = row->name. Pops key value

        lua_pushinteger(L, (pp_share_info_502[0].shi502_type))
        lua_setfield(L, -2, "type")

        lua_pushstring(L, (pp_share_info_502[0].shi502_remark).encode('UTF-8'))
        lua_setfield(L, -2, "remark")

        lua_pushinteger(L, (pp_share_info_502[0].shi502_permissions))
        lua_setfield(L, -2, "permissions")

        lua_pushstring(L, (pp_share_info_502[0].shi502_path).encode('UTF-8'))
        lua_setfield(L, -2, "path")

        lua_pushinteger(L, pp_share_info_502[0].shi502_max_uses)
        lua_setfield(L, -2, "max_uses")

        lua_pushinteger(L, pp_share_info_502[0].shi502_current_uses)
        lua_setfield(L, -2, "current_uses")

        lua_pushstring(L, (pp_share_info_502[0].shi502_passwd).encode('UTF-8'))
        lua_setfield(L, -2, "passwd")

        # Validate the value of the 
        #  shi502_security_descriptor member.
        #lua_pushboolean(L, IsValidSecurityDescriptor(p.shi502_security_descriptor))
        #lua_setfield(L, -2, "current_uses")

        # Validate the value of the 
        #  shi502_security_descriptor member.

        pp_share_info_502[0] += 1
        p_i[0] += 1
        if p_i[0] == p_er[0]:
            p_nse[0] = False
        return 1


cdef int net_shares_gc( lua_State* L ):
    cdef:
        PSHARE_INFO_502 p_share_info_502 = <PSHARE_INFO_502>lua_touserdata(L, lua_upvalueindex(1))
        LPWSTR lpwstr_server = <LPWSTR>lua_touserdata(L, lua_upvalueindex(2))
        DWORD* p_resume = <DWORD*>lua_touserdata(L, lua_upvalueindex(3))
        DWORD* p_er = <DWORD*>lua_touserdata(L, lua_upvalueindex(4))
        DWORD* p_tr = <DWORD*>lua_touserdata(L, lua_upvalueindex(5))
        DWORD* p_i = <DWORD*>lua_touserdata(L, lua_upvalueindex(6))
        bint* p_nse = <bint*>lua_touserdata(L, lua_upvalueindex(7))
        PSHARE_INFO_502*pp_share_info_502 = <PSHARE_INFO_502*>lua_touserdata(L, lua_upvalueindex(8))

    # Free the allocated buffer.
    NetApiBufferFree(p_share_info_502)
    free(p_resume)
    free(p_er)
    free(p_tr)
    free(p_i)
    free(p_nse)
    free(pp_share_info_502)
    return 0


cdef int l_net_shares(lua_State *L):
    cdef:
        const char* server_name = luaL_checkstring(L, 1)
        #unicode u_server_name = (server_name).decode("UTF-8")
        PSHARE_INFO_502 p_share_info_502 = NULL
        #LPWSTR lpwstr_server = <LPWSTR>u_server_name
        PSHARE_INFO_502 *pp_share_info_502 = <PSHARE_INFO_502*>malloc(sizeof(PSHARE_INFO_502))
        DWORD *p_resume = <DWORD*>malloc(sizeof(DWORD))
        DWORD *p_er = <DWORD*>malloc(sizeof(DWORD))
        DWORD *p_tr = <DWORD*>malloc(sizeof(DWORD))
        DWORD *p_i = <DWORD*>malloc(sizeof(DWORD))
        bint *p_nse = <bint*>malloc(sizeof(bint))

    luaL_newmetatable( L, "LuaBook.net_shares" )
    lua_pushstring( L, "__gc" )
    lua_pushcfunction( L, net_shares_gc)
    lua_settable( L, -3 )

    p_resume[0] = 0
    p_er[0] = 0
    p_tr[0] = 0
    p_i[0] = 1
    p_nse[0] = False
    lua_pushlightuserdata (L, p_share_info_502)
    #lua_pushlightuserdata (L, lpwstr_server)
    lua_pushstring(L, server_name)
    lua_pushlightuserdata (L, p_resume)
    lua_pushlightuserdata (L, p_er)
    lua_pushlightuserdata (L, p_tr)
    lua_pushlightuserdata (L, p_i)
    lua_pushlightuserdata (L, p_nse)
    lua_pushlightuserdata (L, pp_share_info_502)
    # set its metatable
    luaL_getmetatable(L, "LuaBook.net_shares")
    lua_setmetatable(L, -2)
    lua_pushcclosure(L, net_shares_iter, 8)
    return 1


cdef int installed_list_iter (lua_State *L):
    cdef:
        PyObject* p_installed_list
        PyObject* p_installed_list_iter
        object obj_installed_list
        object obj_installed_list_iter
        object package
        unicode package_id
    p_installed_list = <PyObject *>lua_touserdata(L, lua_upvalueindex(1))
    p_installed_list_iter = <PyObject *>lua_touserdata(L, lua_upvalueindex(2))
    obj_installed_list = <object>p_installed_list
    obj_installed_list_iter = <object>p_installed_list_iter

    try:
        package_id = obj_installed_list_iter.next()
        package = obj_installed_list[package_id]
    except StopIteration:
        # no more values to return
        return 0
    except:
        traceback.print_exc()
        return 0

    lua_newtable(L)
    #print(package)
    #(package_id, version, rev, date)
    lua_pushstring(L, package_id.encode("UTF-8"))
    lua_setfield(L, -2, "package_id")  

    lua_pushstring(L, package[0].encode("UTF-8"))
    lua_setfield(L, -2, "version")

    #lua_pushinteger(L, package[2])
    lua_pushstring(L, package[1].encode("UTF-8"))
    lua_setfield(L, -2, "rev")

    lua_pushstring(L, package[2].encode("UTF-8"))
    lua_setfield(L, -2, "date")

    return 1


cdef int installed_list_gc( lua_State* L ):
    cdef:
        PyObject* p_installed_list
        object obj_installed_list
        PyObject* p_installed_list_iter
        object obj_installed_list_iter
    p_installed_list = <PyObject *>lua_touserdata(L, lua_upvalueindex(1))
    obj_installed_list = <object>p_installed_list
    Py_DECREF(obj_installed_list)
    p_installed_list_iter = <PyObject *>lua_touserdata(L, lua_upvalueindex(2))
    obj_installed_list_iter = <object>p_installed_list_iter
    Py_DECREF(obj_installed_list_iter)
    return 0


cdef int l_installed_list (lua_State *L):
    cdef:
        PyObject* p_installed_list
        PyObject* p_installed_list_iter
        object obj_installed_list
        object obj_installed_list_iter
    luaL_newmetatable( L, "LuaBook.installed_list" )
    lua_pushstring(L, "__gc")
    lua_pushcfunction(L, installed_list_gc)
    lua_settable(L, -3)

    lua_getglobal(L, "p_installed_list")
    p_installed_list = <PyObject*>lua_touserdata(L, -1)
    obj_installed_list = <object>p_installed_list
    obj_installed_list_iter = iter(obj_installed_list)
    lua_pushlightuserdata (L, p_installed_list)
    lua_pushlightuserdata (L, <PyObject*>obj_installed_list_iter)
    Py_INCREF(obj_installed_list)
    Py_INCREF(obj_installed_list_iter)
    # set its metatable
    luaL_getmetatable(L, "LuaBook.installed_list")
    lua_setmetatable(L, -2)
    lua_pushcclosure(L, installed_list_iter, 2)
    return 1


cdef int l_get_file_version_info(lua_State *L):
    cdef:
        const char* file_path = luaL_checkstring(L, 1)
        LPCWSTR pcw_file_path
        unicode u_file_path
        DWORD dw_dummy
        DWORD dw_fvi_size
        LPVOID p_version_info
        UINT u_len
        VS_FIXEDFILEINFO *p_fixed_fileinfo
        DWORD dwFileVersionMS
        DWORD dwFileVersionLS
        DWORD dwLeftMost
        DWORD dwSecondLeft
        DWORD dwSecondRight
        DWORD dwRightMost

    global lua_log_err

    u_file_path = (file_path).decode("UTF-8")
    pcw_file_path = <LPWSTR>u_file_path
    dw_fvi_size = GetFileVersionInfoSizeW( pcw_file_path , &dw_dummy )
    p_version_info = <LPVOID>malloc(dw_fvi_size)

    if dw_fvi_size == 0:
        print >>lua_log_err, "Error in GetFileVersionInfoSizeW: %d" % GetLastError()
        return 0
    if not GetFileVersionInfoW( pcw_file_path , 0 , dw_fvi_size , p_version_info ):
        print >>lua_log_err, "Error in GetFileVersionInfoW: %d" % GetLastError()
        return 0
    if not VerQueryValueW( p_version_info , u"\\" , <LPVOID *>&p_fixed_fileinfo , &u_len ):
        print >>lua_log_err, "Error in VerQueryValue: %d" % GetLastError()
        return 0

    lua_newtable(L)
    #dwFileVersionMS = p_fixed_fileinfo.dwFileVersionMS
    #dwFileVersionLS = p_fixed_fileinfo.dwFileVersionLS

    #dwLeftMost = HIWORD(dwFileVersionMS)
    #dwSecondLeft = LOWORD(dwFileVersionMS)
    #dwSecondRight = HIWORD(dwFileVersionLS)
    #dwRightMost = LOWORD(dwFileVersionLS)
    #print "Version: %d.%d.%d.%d" % (dwLeftMost, dwSecondLeft, dwSecondRight, dwRightMost)
    lua_pushinteger(L, (p_fixed_fileinfo.dwSignature))
    lua_setfield(L, -2, "signature")
    lua_pushinteger(L, (p_fixed_fileinfo.dwStrucVersion))
    lua_setfield(L, -2, "struct_version")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileVersionMS))
    lua_setfield(L, -2, "file_version_ms")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileVersionLS))
    lua_setfield(L, -2, "file_version_ls")
    lua_pushinteger(L, (p_fixed_fileinfo.dwProductVersionMS))
    lua_setfield(L, -2, "product_version_ms")
    lua_pushinteger(L, (p_fixed_fileinfo.dwProductVersionLS))
    lua_setfield(L, -2, "product_version_ls")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileFlagsMask))
    lua_setfield(L, -2, "file_flags_mask")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileFlags))
    lua_setfield(L, -2, "file_flags")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileOS))
    lua_setfield(L, -2, "file_os")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileType))
    lua_setfield(L, -2, "file_tpye")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileSubtype))
    lua_setfield(L, -2, "file_subtype")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileDateMS))
    lua_setfield(L, -2, "file_date_ms")
    lua_pushinteger(L, (p_fixed_fileinfo.dwFileDateLS))
    lua_setfield(L, -2, "file_date_ls")

    lua_pushinteger(L, HIWORD(p_fixed_fileinfo.dwFileVersionMS))
    lua_setfield(L, -2, "major_version")

    lua_pushinteger(L, LOWORD(p_fixed_fileinfo.dwFileVersionMS))
    lua_setfield(L, -2, "minor_version")

    lua_pushinteger(L, HIWORD(p_fixed_fileinfo.dwFileVersionLS))
    lua_setfield(L, -2, "build_number")

    lua_pushinteger(L, LOWORD(p_fixed_fileinfo.dwFileVersionLS))
    lua_setfield(L, -2, "revision_number")

    return 1


cdef int l_hiword(lua_State *L):
    cdef:
        DWORD dw_value = 0

    dw_value = <DWORD>lua_tointeger(L, -1)
    lua_pushinteger(L, HIWORD(dw_value))
    return 1


cdef int l_loword(lua_State *L):
    cdef:
        DWORD dw_value = 0

    dw_value = <DWORD>lua_tointeger(L, -1)
    lua_pushinteger(L, LOWORD(dw_value))
    return 1


cdef int l_sleep(lua_State *L):
    cdef DWORD milliseconds = 0
    milliseconds = <DWORD>lua_tointeger(L, -1)
    Sleep(milliseconds)
    return 0


cdef int isabs(lua_State *L):
    cdef:
        const char* path = luaL_checkstring(L, 1)
    lua_pushboolean(L, os.path.isabs(path.decode("UTF-8")))
    return 1


cdef int l_isabs(lua_State *L):
    """
    Return True if path is an absolute pathname. On Windows, that means it begins with a (back)slash after chopping off a potential drive letter.
    """
    cdef:
        const char* path = luaL_checkstring(L, 1)
    lua_pushboolean(L, os.path.isabs(path.decode("UTF-8")))
    return 1


cdef int l_isfile(lua_State *L):
    """
    Return True if path is an existing regular file. This follows symbolic links, so both islink() and isfile() can be true for the same path.
    """
    cdef:
        const char* path = luaL_checkstring(L, 1)
    lua_pushboolean(L, os.path.isfile(path.decode("UTF-8")))
    return 1


cdef int l_isdir(lua_State *L):
    """
    Return True if path is an existing directory. This follows symbolic links, so both islink() and isdir() can be true for the same path.
    """
    cdef:
        const char* path = luaL_checkstring(L, 1)
    lua_pushboolean(L, os.path.isdir(path.decode("UTF-8")))
    return 1


cdef int l_islink(lua_State *L):
    """
    Return True if path refers to a directory entry that is a symbolic link. Always False if symbolic links are not supported by the python runtime.
    """
    cdef:
        const char* path = luaL_checkstring(L, 1)
    lua_pushboolean(L, os.path.islink(path.decode("UTF-8")))
    return 1


cdef int l_getatime(lua_State *L):
    """
    Return the time of last access of path. The return value is a number giving the number of seconds since the epoch (see the time module). Raise os.error if the file does not exist or is inaccessible.

    If os.stat_float_times() returns True, the result is a floating point number.
    """
    cdef:
        const char* path = luaL_checkstring(L, 1)
    if os.stat_float_times():
        lua_pushnumber(L, os.path.getatime(path.decode("UTF-8")))
    else:
        lua_pushinteger(L, os.path.getatime(path.decode("UTF-8")))
    return 1


cdef int l_getmtime(lua_State *L):
    """
    Return the time of last modification of path. The return value is a number giving the number of seconds since the epoch (see the time module). Raise os.error if the file does not exist or is inaccessible.

    If os.stat_float_times() returns True, the result is a floating point number.
    """
    cdef:
        const char* path = luaL_checkstring(L, 1)
    if os.stat_float_times():
        lua_pushnumber(L, os.path.getmtime(path.decode("UTF-8")))
    else:
        lua_pushinteger(L, os.path.getmtime(path.decode("UTF-8")))
    return 1


cdef int l_getctime(lua_State *L):
    """
    Return the time of last modification of path. The return value is a number giving the number of seconds since the epoch (see the time module). Raise os.error if the file does not exist or is inaccessible.

    If os.stat_float_times() returns True, the result is a floating point number.
    """
    cdef:
        const char* path = luaL_checkstring(L, 1)
    if os.stat_float_times():
        lua_pushnumber(L, os.path.getctime(path.decode("UTF-8")))
    else:
        lua_pushinteger(L, os.path.getctime(path.decode("UTF-8")))
    return 1


cdef int l_join_path(lua_State *L):
    """
    ...
    """
    cdef:
        int i, n
        const char* path
        list paths = []

    # remove the name parameter from the stack
    #lua_remove(L, 1)
    path = luaL_checkstring(L, 1)

    # check how many arguments are left
    n = lua_gettop(L)

    for i in range(1, n):
        paths.append(luaL_checkstring(L, i).decode("UTF-8"))
    lua_pushstring(L, os.path.join(path.decode("UTF-8"), *paths).encode("UTF-8"))
    return 1


cdef int l_splitdrive(lua_State *L):
    """
    ...
    """
    cdef:
        const char* path
        const char* drive
        const char* tail
        list paths = []

    path = luaL_checkstring(L, 1)

    drive, tail = os.path.splitdrive(path.decode("UTF-8"))
    lua_pushstring(L, drive.encode("UTF-8"))
    lua_pushstring(L, tail.encode("UTF-8"))
    return 2


cdef int l_split(lua_State *L):
    cdef:
        const char* string
        unicode u_string
        const char* delimiter
        unicode u_delimiter = u" "
        int count = -1
        list tmp
        int stack_element_count = lua_gettop(L)
        int i = 0
        unicode entry
        object py_byte_string
    string = luaL_checkstring(L, 1)
    u_string = string.decode("UTF-8")
    if stack_element_count > 1:
        delimiter = luaL_checkstring(L, 2)
        u_delimiter = delimiter.decode("UTF-8")
    if stack_element_count > 2:
        count = luaL_checkinteger(L, 3)
    tmp = u_string.split(u_delimiter, count)
    lua_newtable(L)
    for entry in tmp:
        py_byte_string = entry.encode("UTF-8")
        lua_pushstring(L, <char*>py_byte_string)
        lua_rawseti(L, -2, i)
        i+=1
    return 1


cdef int l_startswith(lua_State *L):
    cdef:
        const char* var1 = luaL_checkstring(L, 1)
        const char* var2 = luaL_checkstring(L, 2)
    lua_pushboolean(L, var1.startswith(var2))
    return 1


cdef int l_endswith(lua_State *L):
    cdef:
        const char* var1 = luaL_checkstring(L, 1)
        const char* var2 = luaL_checkstring(L, 2)
    lua_pushboolean(L, var1.endswith(var2))
    return 1


cdef int l_regex_does_match(lua_State *L):
    cdef:
        object match
        unicode pattern = lua_string_to_python_unicode(L, 1)
        unicode string = lua_string_to_python_unicode(L, 2)
    match = re.match(pattern, string)
    lua_pushboolean(L, match is not None)
    return 1


cdef int l_regex_match(lua_State *L):
    cdef:
        object match
        unicode pattern = lua_string_to_python_unicode(L, 1)
        unicode string = lua_string_to_python_unicode(L, 2)
        unicode group
        object py_byte_string
        int i = 1
    match = re.match(pattern, string)
    lua_pushboolean(L, match is not None)
    if match is None:
        lua_pushnil(L)
    else:
        py_byte_string = match.group(0).encode("UTF-8")
        lua_pushstring(L, <char*>py_byte_string)
    lua_newtable(L)
    if match is not None:
        for group in match.groups():
            py_byte_string = group.encode("UTF-8")
            lua_pushstring(L, <char*>py_byte_string)
            lua_rawseti(L, -2, i)
            i+=1
    return 3


cdef int l_set_installed(lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        bint installed = lua_toboolean(L, -1)
        PyObject* p_package_list
        PackageList package_list
        object package
    lua_getglobal(L, 'p_package_list')
    p_package_list = <PyObject*>lua_touserdata (L, -1)
    package_list = <object>p_package_list
    package = package_list[package_id]
    package.installed = installed
    return 0


cdef int l_set_upgrade_available(lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        bint upgrade_available = lua_toboolean(L, -1)
        PyObject* p_package_list
        PackageList package_list
        object package
    lua_getglobal(L, 'p_package_list')
    p_package_list = <PyObject*>lua_touserdata (L, -1)
    package_list = <object>p_package_list
    package = package_list[package_id]
    package.upgrade_available = upgrade_available
    return 0


cdef int l_set_install_cmds(lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        PyObject* p_package_list
        PackageList package_list
        object package
        list cmds = []

    if not lua_istable(L, 2):
        return 0
    lua_getglobal(L, 'p_package_list')
    p_package_list = <PyObject*>lua_touserdata (L, -1)
    package_list = <object>p_package_list
    get_cmds(L, 2, package_list, cmds, package_list._status_handler)
    package = package_list[package_id]
    package.install_cmds = cmds
    return 0


cdef int l_set_uninstall_cmds(lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        PyObject* p_package_list
        PackageList package_list
        object package
        list cmds = []

    if not lua_istable(L, 2):
        return 0
    lua_getglobal(L, 'p_package_list')
    p_package_list = <PyObject*>lua_touserdata (L, -1)
    package_list = <object>p_package_list
    get_cmds(L, 2, package_list, cmds, package_list._status_handler)
    package = package_list[package_id]
    package.uninstall_cmds = cmds
    return 0


cdef int l_set_upgrade_cmds(lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        PyObject* p_package_list
        PackageList package_list
        object package
        list cmds = []

    if not lua_istable(L, 2):
        return 0
    lua_getglobal(L, 'p_package_list')
    p_package_list = <PyObject*>lua_touserdata (L, -1)
    package_list = <object>p_package_list
    get_cmds(L, 2, package_list, cmds, package_list._status_handler)
    package = package_list[package_id]
    package.upgrade_cmds = cmds
    return 0


cdef int l_include(lua_State *L):
    """
    Includes another lua-file, using a connection handler
    """
    cdef:
        #const char* path = luaL_checkstring(L, 1)
        bint status = True
        int ret_code
        unicode path = lua_string_to_python_unicode(L, 1)
        object url
        PyObject* p_connection_list
        ConnectionList connection_list
        object protocol_handler

    lua_getglobal(L, 'p_connection_list')
    p_connection_list = <PyObject*>lua_touserdata (L, -1)
    connection_list = <object>p_connection_list

    for url in connection_list:
        connection = connection_list[url]
        protocol_handler = connection['protocol_handler']
        if protocol_handler.is_responsible(path):
            path = protocol_handler.get_path(path)

    ret_code = luaL_loadfile(L, path)

    if ret_code:
        err_msg = lua_tostring(L, -1)
        print >>lua_log_err, err_msg
        if ret_code ==  LUA_ERRFILE:
            raise IOError(2, "File not found!", path)
        status = False
    else:
        # Run the lua
        ret_code = lua_pcall(L, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(L, -1)
            print >>lua_log_err, err_msg
        if ret_code != 0:
            #print "lua_pcall() failed!"
            status = False
    lua_pushboolean(L, status)
    return 1


cdef int get_paramters(lua_State *L):
    pass


cdef int handle_cmd_args_arg(lua_State *L, list parameters):
    """
    {   parameter = [[/uninstall]],
        values = {
            {
                "ProPlus",
                false
            },
        }
    }
    """
    cdef:
        unicode parameter = u""
        #unicode value = u""
        object value
        unicode key = u""
        list values = []
        list values_values = []
        bint allow_connection_handler = False
    # first key
    lua_pushnil(L)
    while lua_next(L, -2) != 0:
        # uses 'key' (at index -2) and 'value' (at index -1)
        #print ("%s - %s" % (
        #    lua_typename(L, lua_type(L, -2)),
        #    lua_typename(L, lua_type(L, -1))))
        if lua_isstring(L, -2):
            #values = []
            key = lua_string_to_python_unicode(L, -2)
            # parameter = [[/uninstall]]
            if key == "parameter" and lua_isstring(L, -1):
                parameter = lua_string_to_python_unicode(L, -1)
            elif key == "values" and lua_istable(L, -1):
                """
                 values = {
                    {
                        "ProPlus",
                        false
                    },
                }
                """
                # first key
                lua_pushnil(L)
                while lua_next(L, -2) != 0:
                    values_values = []
                    # uses 'key' (at index -2) and 'value' (at index -1)
                    #print ("%s - %s" % (
                    #    lua_typename(L, lua_type(L, -2)),
                    #    lua_typename(L, lua_type(L, -1))))
                    """
                    {
                        "ProPlus",
                        false
                    }
                    """
                    if lua_istable(L, -1):
                        lua_pushnil(L)
                        while lua_next(L, -2) != 0:
                            if lua_isinteger(L, -2):
                                if lua_isstring(L, -1):
                                    value = lua_string_to_python_unicode(L, -1)
                                elif lua_isboolean(L, -1):
                                    value = lua_toboolean(L, -1)
                                values_values.append(value)
                            lua_pop(L, 1)
                        """
                        lua_pushnil(L)
                        # "ProPlus"
                        if lua_next(L, -2) != 0:
                            print ("%s - %s" % (
                                lua_typename(L, lua_type(L, -2)),
                                lua_typename(L, lua_type(L, -1))))
                            if lua_isinteger(L, -2) and lua_isstring(L, -1):
                                value = lua_tostring(L, -1).decode("UTF-8")
                                print "value:", value
                                values.append(value)
                            # removes 'value'; keeps 'key' for next iteration
                            lua_pop(L, 1)
                            # false
                            if lua_next(L, -2) != 0:
                                print ("%s - %s" % (
                                    lua_typename(L, lua_type(L, -2)),
                                    lua_typename(L, lua_type(L, -1))))
                                if lua_isinteger(L, -2) and lua_isboolean(L, -1):
                                    allow_connection_handler = lua_toboolean(L, -1)
                                    values.append(allow_connection_handler)
                                    print value, allow_connection_handler
                                # removes 'value'and 'key'
                                lua_pop(L, 2)
                        """
                    # removes 'value'; keeps 'key' for next iteration
                    lua_pop(L, 1)
                    #print lua_typename(L, lua_type(L, -2))
                values.append(values_values)
        # removes 'value'; keeps 'key' for next iteration
        lua_pop(L, 1)
    #parameters.append({'parameter': parameter, 'values': values})
    parameters.append({'argument': parameter, 'values': values})
    return True


cdef int handle_cmd_args(lua_State *L, list parameters):
    """
    {
        {   parameter = [[/uninstall]],
            values = {
                {
                    "ProPlus",
                    false
                },
            }
        },
        {   parameter = [[/config]],
            values = {
                {
                    [[smb://\\10.0.19.10\software\msoffice2013pp_uninstall.xml]],
                    True
                }
            }
        }
    }
    """
    # first key
    lua_pushnil(L)
    while lua_next(L, -2) != 0:
        # uses 'key' (at index -2) and 'value' (at index -1)
        #print ("%s - %s" % (
        #    lua_typename(L, lua_type(L, -2)),
        #    lua_typename(L, lua_type(L, -1))))
        if lua_istable(L, -1) and  lua_isinteger(L, -2):
            handle_cmd_args_arg(L, parameters)
        # removes 'value'; keeps 'key' for next iteration
        lua_pop(L, 1)
    return True


cdef int handle_cmd_s_o_e_code(lua_State *L, int error_code, dict error_codes):
    """
    {
        id = "ERROR_SUCCESS",
        description = "The operation completed successfully."
    }
    """
    cdef:
        unicode u_key = u""
        unicode u_id = u""
        unicode u_description = u""
    # first key
    lua_pushnil(L)
    while lua_next(L, -2) != 0:
        # uses 'key' (at index -2) and 'value' (at index -1)
        if lua_isstring(L, -2):
            u_key = lua_string_to_python_unicode(L, -2)
            if u_key == u"id":
                if lua_isstring(L, -1):
                    u_id = lua_string_to_python_unicode(L, -1)
            elif u_key == u"description":
                if lua_isstring(L, -1):
                    u_description = lua_string_to_python_unicode(L, -1)
                    error_codes[error_code] = u_description
        # removes 'value'; keeps 'key' for next iteration
        lua_pop(L, 1)
    return True


cdef int handle_cmd_s_o_e_codes(lua_State *L, dict error_codes):
    """
    {
        [0] = {
            id = "ERROR_SUCCESS",
            description = "The operation completed successfully."
        }
    }
    """
    cdef:
        int error_code
        unicode u_description = u""
    # first key
    lua_pushnil(L)
    while lua_next(L, -2) != 0:
        # uses 'key' (at index -2) and 'value' (at index -1)
        if lua_isinteger(L, -2):
            error_code  = lua_tointeger(L, -2)
            if lua_istable(L, -1):
                """
                {
                    [0] = {
                        id = "ERROR_SUCCESS",
                        description = "The operation completed successfully."
                    }
                }
                """
                handle_cmd_s_o_e_code(L, error_code, error_codes)
            elif lua_isstring(L, -1):
                """
                {
                    [0] = "The operation completed successfully."
                }
                """
                u_description = lua_string_to_python_unicode(L, -1)
                error_codes[error_code] = u_description
        # removes 'value'; keeps 'key' for next iteration
        lua_pop(L, 1)
    return True


cdef int handle_cmd_return_codes(lua_State *L, dict success_codes, dict error_codes):
    """
    return_codes = {
        success_codes = {
            [0] = {
                id = "ERROR_SUCCESS",
                description = "The operation completed successfully."
            }
        },
        error_codes = {
            [1] = {
                id = "ERROR_INVALID_FUNCTION",
                description = "Incorrect function."
            },
            [2] = {
                id = "ERROR_FILE_NOT_FOUND",
                description = "The system cannot find the file specified."
            },
            [3] = {
                id = "ERROR_PATH_NOT_FOUND",
                description = "The system cannot find the path specified."
            },
            [4] = {
                id = "ERROR_TOO_MANY_OPEN_FILES",
                description = "The system cannot open the file."
            },
            [5] = {
                id = "ERROR_ACCESS_DENIED",
                description = "Access is denied."
            },
            [6] = {
                id = "ERROR_INVALID_HANDLE",
                description = "The handle is invalid."
            },
            [7] = {
                id = "ERROR_ARENA_TRASHED",
                description = "The storage control blocks were destroyed."
            },
            [8] = {
                id = "ERROR_NOT_ENOUGH_MEMORY",
                description = "Not enough storage is available to process this command."
            }
        }
    },
    success_codes = {
        [0] = {
            id = "ERROR_SUCCESS",
            description = "The operation completed successfully."
        }
    },
    error_codes = {
        [1] = {
            id = "ERROR_INVALID_FUNCTION",
            description = "Incorrect function."
        }
    }
    """
    cdef:
        unicode u_key = u""
    # first key
    lua_pushnil(L)
    while lua_next(L, -2) != 0:
        # uses 'key' (at index -2) and 'value' (at index -1)
        if lua_isstring(L, -2):
            u_key = lua_string_to_python_unicode(L, -2)
            if u_key == u"success_codes":
                if lua_istable(L, -1):
                    handle_cmd_s_o_e_codes(L, success_codes)
            elif u_key == u"error_codes":
                if lua_istable(L, -1):
                    handle_cmd_s_o_e_codes(L, error_codes)
        # removes 'value'; keeps 'key' for next iteration
        lua_pop(L, 1)
    return True


cdef int handle_cmd(lua_State *L, object cmds, const char** path, list parameters, const char** md5, const char** hash, const char** hash_algorithm, bint* break_on_md5_violation, bint* break_on_hash_violation, dict success_codes = {}, dict error_codes = {}):
    """
    {
        cmd = SETUP_PATH,
        args = {
            {   parameter = [[/uninstall]],
                values = {
                    {
                        "ProPlus",
                        false
                    },
                }
            },
            {   parameter = [[/config]],
                values = {
                    {
                        [[smb://\\10.0.19.10\software\msoffice2013pp_uninstall.xml]],
                        True
                    }
                }
            }
        },
        return_codes = {
            success_codes = {
                [0] = {
                    id = "ERROR_SUCCESS",
                    description = "The operation completed successfully."
                }
            },
            error_codes = {
                [1] = {
                    id = "ERROR_INVALID_FUNCTION",
                    description = "Incorrect function."
                },
                [2] = {
                    id = "ERROR_FILE_NOT_FOUND",
                    description = "The system cannot find the file specified."
                },
                [3] = {
                    id = "ERROR_PATH_NOT_FOUND",
                    description = "The system cannot find the path specified."
                },
                [4] = {
                    id = "ERROR_TOO_MANY_OPEN_FILES",
                    description = "The system cannot open the file."
                },
                [5] = {
                    id = "ERROR_ACCESS_DENIED",
                    description = "Access is denied."
                },
                [6] = {
                    id = "ERROR_INVALID_HANDLE",
                    description = "The handle is invalid."
                },
                [7] = {
                    id = "ERROR_ARENA_TRASHED",
                    description = "The storage control blocks were destroyed."
                },
                [8] = {
                    id = "ERROR_NOT_ENOUGH_MEMORY",
                    description = "Not enough storage is available to process this command."
                }
            }
        },
        success_codes = {
            [0] = {
                id = "ERROR_SUCCESS",
                description = "The operation completed successfully."
            }
        },
        error_codes = {
            [1] = {
                id = "ERROR_INVALID_FUNCTION",
                description = "Incorrect function."
            }
        }
    }
    """
    cdef:
        unicode u_key = u""
        unicode u_cmd = u""
        int ref
        bint b_lua_cmd = False
        #dict local_error_codes = error_codes
        #dict local_success_codes = success_codes
    # first key
    lua_pushnil(L)
    while lua_next(L, -2) != 0:
        # uses 'key' (at index -2) and 'value' (at index -1)
        #print ("%s - %s" % (
        #    lua_typename(L, lua_type(L, -2)),
        #    lua_typename(L, lua_type(L, -1))))

        if lua_isstring(L, -2):
            u_key = lua_string_to_python_unicode(L, -2)
            if u_key == u"cmd":
                u_cmd = lua_string_to_python_unicode(L, -1)
                path[0] = u_cmd
                #print "cmd path: %s" % path[0]
            if u_key in (u"md5", u"md5sum"):
                md5[0] = lua_tostring(L, -1)
            elif u_key == u"hash":
                hash[0] = lua_tostring(L, -1)
            elif u_key == u"hash_algorithm":
                hash_algorithm[0] = lua_tostring(L, -1)
            elif u_key == u"break_on_hash_violation":
                break_on_hash_violation[0] = lua_toboolean(L, -1)
            elif u_key == u"break_on_md5_violation":
                break_on_md5_violation[0] = lua_toboolean(L, -1)
            elif u_key == u"args":
                if lua_istable(L, -1):
                    handle_cmd_args(L, parameters)
            elif u_key in (u"return_codes", u"ret_codes"):
                if lua_istable(L, -1):
                    #local_success_codes = {}
                    #local_error_codes = {}
                    #handle_cmd_return_codes(L, local_success_codes, local_error_codes)
                    handle_cmd_return_codes(L, success_codes, error_codes)
                    #print "RETURN CODES", local_success_codes, local_error_codes
            elif u_key == u"success_codes":
                if lua_istable(L, -1):
                    #local_success_codes = {}
                    #handle_cmd_s_o_e_codes(L, local_success_codes)
                    handle_cmd_s_o_e_codes(L, success_codes)
            elif u_key == u"error_codes":
                if lua_istable(L, -1):
                    #local_error_codes = {}
                    #handle_cmd_s_o_e_codes(L, local_error_codes)
                    handle_cmd_s_o_e_codes(L, error_codes)
            elif lua_isfunction(L, -1):
                """
                Creates and returns a reference, in the table at index t, for the object at the top of the stack (and pops the object).

                A reference is a unique integer key. As long as you do not manually add integer keys into table t, luaL_ref ensures the uniqueness of the key it returns. You can retrieve an object referred by reference r by calling lua_rawgeti(L, t, r). Function luaL_unref frees a reference and its associated object.

                If the object at the top of the stack is nil, luaL_ref returns the constant LUA_REFNIL. The constant LUA_NOREF is guaranteed to be different from any reference returned by luaL_ref. 
                """
                ref = luaL_ref(L, LUA_REGISTRYINDEX)
                b_lua_cmd = True
                continue
        # removes 'value'; keeps 'key' for next iteration
        lua_pop(L, 1)
        if b_lua_cmd:
            cmds.append(LuaCmd(<long>L, ref, success_codes, error_codes))

    return True


cdef int get_cmds(lua_State *L, int table, PackageList package_list, object cmds, object status_handler):

    """
    UNINSTALL_CMD = 
    {
        cmd = SETUP_PATH,
        args = {
            {   parameter = [[/uninstall]],
                values = {
                    {
                        "ProPlus",
                        false
                    },
                }
            },
            {   parameter = [[/config]],
                values = {
                    {
                        [[smb://\\10.0.19.10\software\msoffice2013pp_uninstall.xml]],
                        True
                    }
                }
            }
        },
        return_codes = {
            success_codes = {
                [0] = {
                    id = "ERROR_SUCCESS",
                    description = "The operation completed successfully."
                }
            },
            error_codes = {
                [1] = {
                    id = "ERROR_INVALID_FUNCTION",
                    description = "Incorrect function."
                },
                [2] = {
                    id = "ERROR_FILE_NOT_FOUND",
                    description = "The system cannot find the file specified."
                },
                [3] = {
                    id = "ERROR_PATH_NOT_FOUND",
                    description = "The system cannot find the path specified."
                },
                [4] = {
                    id = "ERROR_TOO_MANY_OPEN_FILES",
                    description = "The system cannot open the file."
                },
                [5] = {
                    id = "ERROR_ACCESS_DENIED",
                    description = "Access is denied."
                },
                [6] = {
                    id = "ERROR_INVALID_HANDLE",
                    description = "The handle is invalid."
                },
                [7] = {
                    id = "ERROR_ARENA_TRASHED",
                    description = "The storage control blocks were destroyed."
                },
                [8] = {
                    id = "ERROR_NOT_ENOUGH_MEMORY",
                    description = "Not enough storage is available to process this command."
                }
            }
        },
        success_codes = {
            [0] = {
                id = "ERROR_SUCCESS",
                description = "The operation completed successfully."
            }
        },
        error_codes = {
            [1] = {
                id = "ERROR_INVALID_FUNCTION",
                description = "Incorrect function."
            }
        }
    }
    """

    cdef:
        int i = 1
        int n
        int ref
        unicode cmd = u""
        const char* md5 = ""
        const char* hash = ""
        const char* hash_algorithm = ""
        bint break_on_md5_violation
        bint break_on_hash_violation
        list args
        #basestring path = u""
        const char* path = ""
        #basestring paramters = u""
        basestring parameter_name = ""
        dict parameter
        list parameters = []
        list values = []
        dict success_codes = {}
        dict error_codes = {}
        object cmd_obj
        LuaCmd lua_cmd

    #luaL_checktype(L, table, LUA_TTABLE);

    n = lua_rawlen(L, table)

    while i <= n:
        md5 = ""
        hash = ""
        hash_algorithm = ""
        break_on_hash_violation = True
        break_on_md5_violation = True
        lua_rawgeti(L, table, i)
        if lua_isstring(L, -1):
            cmd = lua_string_to_python_unicode(L, -1)
            #print "cmd: %s" % cmd
            args = libs.win.commandline.parse(cmd)
            path = args[0]
            #print "path: %s" % path
            #parameters = args[1:]
            #print "path: %s, paramters: %s" % (path, parameters)
            parameter_name = ''
            values = []
            for arg in args[1:]:
                if arg.startswith('/'):
                    parameter = {'argument': parameter_name.decode("utf-8"), 'values': values.decode("utf-8")}
                    parameters.append(parameter)
                    values = []
                    parameter_name = arg
                    #print "parameter name: %s" % parameter_name
                    continue
                #print "appending value: %s" % arg
                values.append({'value': arg, 'allow_connection_handler': False})
            parameter = {'argument': parameter_name, 'values': values}
            parameters.append(parameter)
        elif lua_istable(L, -1):
            parameters = []
            handle_cmd(L, cmds, &path, parameters, &md5, &hash, &hash_algorithm, &break_on_md5_violation, &break_on_hash_violation, success_codes, error_codes)
        elif lua_isfunction(L, -1):
            ref = luaL_ref(L, LUA_REGISTRYINDEX)
            cmds.append(LuaCmd(<long>L, ref))
            #lua_cmd = LuaCmd(<long>ref)
            #lua_cmd._l = L
            #cmds.append(lua_cmd)
            i += 1
            continue
        try:
            #cmd_obj = libs.handlers.config.Cmd(path.decode("utf-8"), parameters, package_list._connection_list, success_codes, error_codes)
            cmd_obj = Cmd(path.decode("utf-8"), parameters, md5.decode("utf-8"), hash.decode("utf-8"), hash_algorithm.decode("utf-8"), break_on_md5_violation, break_on_hash_violation, package_list._connection_list, success_codes, error_codes, status_handler)

            #print "cmd to execute: %s" % str(cmd_obj)
            cmds.append(cmd_obj)
        except:
            traceback.print_exc()

        i += 1

    return 0


cdef int l_register_package (lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        unicode name = lua_string_to_python_unicode(L, 2)
        bint installed = lua_toboolean(L, 5)
        bint upgrade_available = lua_toboolean(L, 6)
        object rev = luaL_checkstring(L, 4)
        object version = luaL_checkstring(L, 3)
        list install_cmds = []
        list upgrade_cmds = []
        list uninstall_cmds = []
        list keywords = []
        unicode description = lua_string_to_python_unicode(L, 10)
        unicode icon = lua_string_to_python_unicode(L, 11)
        unicode icon_type = lua_string_to_python_unicode(L, 12)
        PyObject* p_package_list
        PackageList package_list

    lua_getglobal(L, 'p_package_list')
    p_package_list = <PyObject*>lua_touserdata (L, -1)
    package_list = <object>p_package_list        
    get_cmds(L, 7, package_list, install_cmds, package_list._status_handler)
    get_cmds(L, 8, package_list, upgrade_cmds, package_list._status_handler)
    get_cmds(L, 9, package_list, uninstall_cmds, package_list._status_handler)
    get_table_as_list(L, 11, keywords)
    package_list[package_id] = Package(package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, icon, icon_type, package_list, package_list._connection_list, [], package_list._log, package_list._status_handler)
    return 1


cdef int l_install (lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        PyObject* p_host_list
        HostList host_list

    lua_getglobal(L, 'p_host_list')
    p_host_list = <PyObject*>lua_touserdata (L, -1)
    host_list = <object>p_host_list
    host_list.append({'action': 'install', 'package_id': package_id.decode('UTF-8')})
    return 1


cdef int l_uninstall (lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        PyObject* p_host_list
        HostList host_list

    lua_getglobal(L, 'p_host_list')
    p_host_list = <PyObject*>lua_touserdata (L, -1)
    host_list = <object>p_host_list
    host_list.append({'action': 'uninstall', 'package_id': package_id.decode('UTF-8')})
    return 1


cdef int l_upgrade (lua_State *L):
    cdef:
        const char* package_id = luaL_checkstring(L, 1)
        PyObject* p_host_list
        HostList host_list

    lua_getglobal(L, 'p_host_list')
    p_host_list = <PyObject*>lua_touserdata (L, -1)
    host_list = <object>p_host_list
    host_list.append({'action': 'upgrade', 'package_id': package_id.decode('UTF-8')})
    return 1


cdef bint get_table_as_list(lua_State *L, int table, list l, structure=None):

    """
        {"cat", "dog", "turtle"}
    """

    cdef:
        int i = 1
        int n
        object value
        dict new_dict = {}
        list new_list = []
        object structure1 = None
        object structure2 = None
        object new_structure
        int index = -1
    global current_line
    #print "get_table_as_list"
    #print "structure", structure
    #luaL_checktype(L, table, LUA_TTABLE);
    if not lua_istable(L, table):
        return False
    if structure is not None:
        if len(structure) == 1 or isinstance(structure, dict):
            structure1 = structure
        elif len(structure) == 2:
            structure1 = structure[0]
            structure2 = structure[1]
            if not isinstance(structure1, dict):
                structure1 = None
            if not isinstance(structure2, dict):
                structure2 = None
    #print "structure1", structure1
    #print "structure2", structure2
    # Push another reference to the table on top of the stack (so we know
    # where it is, and this function can work for negative, positive and
    # pseudo indices
    lua_pushvalue(L, table)
    # stack now contains: -1 => table
    #n = lua_rawlen(L, table)
    lua_pushnil(L)
    # stack now contains: -1 => nil; -2 => table
    while lua_next(L, -2) != 0:
        index = index + 1
        #print "next"
    #while i <= n:
        #lua_rawgeti(L, table, i)
        if lua_isinteger(L, -2):
            #print "[%d] index is an integer" % current_line
            if lua_isstring(L, -1):
                value = lua_string_to_python_unicode(L, -1)
                #print "[%d] value (%s:%s) is a string" % (current_line, index, value)
                if structure is not None:
                    if structure1 is not None and not STRING in structure1:
                        print >>lua_log_err, "[%d] [gtal] String (%s) as value is not allowed here!" % (current_line, index)
                        lua_pop(L, 1)
                        continue
                    if index in structure2 and not STRING in structure2[index]:
                        print >>lua_log_err, "[%d] [gtal] String (%s) as value is not allowed here!" % (current_line, index)
                        lua_pop(L, 1)
                        continue
                #print value
                l.append(value)
            elif lua_isboolean(L, -1):
                #print "[%d] value (%s:%s) is a boolean" % (current_line, index, value)
                if structure is not None:
                    if structure1 is not None and not BOOLEAN in structure1:
                        print >>lua_log_err, "[%d] [gtal] Boolean as value is not allowed here!" % current_line
                        lua_pop(L, 1)
                        continue
                    if index in structure2 and not BOOLEAN in structure2[index]:
                        print >>lua_log_err, "[%d] [gtal] Boolean as value is not allowed here!" % current_line
                        lua_pop(L, 1)
                        continue
                value = lua_toboolean(L, -1)
                #print value
                l.append(value)
            elif lua_isinteger(L, -1):
                value = lua_tointeger(L, -1)
                #print "[%d] value (%s:%s) is an integer" % (current_line, index, value)
                if structure is not None:
                    if structure1 is not None and not INTEGER in structure1:
                        print >>lua_log_err, "[%d] [gtal] Integer (%s) as value is not allowed here!" % (current_line, index)
                        lua_pop(L, 1)
                        continue
                    if index in structure2 and not INTEGER in structure2[index]:
                        print >>lua_log_err, "[%d] [gtal] String (%s) as value is not allowed here!" % (current_line, index)
                        lua_pop(L, 1)
                        continue

                #print value
                l.append(value)
            elif lua_isfunction(L, -1):
                #print "[%d] value (%s) is a function" % (current_line, index)
                if structure is not None:
                    if structure1 is not None and not FUNCTION in structure1:
                        print >>lua_log_err, "[%d] [gtal] Function (%s) as value is not allowed here!" % (current_line, index)
                        lua_pop(L, 1)
                        continue
                    if index in structure2 and not FUNCTION in structure2[index]:
                        print >>lua_log_err, "[%d] [gtal] Function (%s) as value is not allowed here!" % (current_line, index)
                        lua_pop(L, 1)
                        continue
                """
                Creates and returns a reference, in the table at index t, for the object at the top of the stack (and pops the object).

                A reference is a unique integer key. As long as you do not manually add integer keys into table t, luaL_ref ensures the uniqueness of the key it returns. You can retrieve an object referred by reference r by calling lua_rawgeti(L, t, r). Function luaL_unref frees a reference and its associated object.

                If the object at the top of the stack is nil, luaL_ref returns the constant LUA_REFNIL. The constant LUA_NOREF is guaranteed to be different from any reference returned by luaL_ref. 
                """
                ref = luaL_ref(L, LUA_REGISTRYINDEX)
                l.append(LuaCmd(<long>L, ref))
                #lua_cmd = LuaCmd(<long>ref)
                #lua_cmd._l = L
                #l.append(lua_cmd)
                # luaL_ref pops the object, so we skip the next pop
                continue
            elif lua_istable(L, -1):
                #print "[%d] value (%s) is a table" % (current_line, index)
                if not (structure is not None and ((structure1 is not None and DICT in structure1) or (structure2 is not None and index in structure2 and DICT in structure2[index]))) and is_array(L, -1):
                #if is_array(L, -1):
                    #print "[%d] table (%s) is an array" % (current_line, index)
                    if structure is not None:
                        if structure1 is not None and not ARRAY in structure1:
                            new_list = []
                            get_table_as_list(L, -1, new_list, None)
                            print >>lua_log_err, "[%d] [gtal] Array (%s) as value is not allowed here! Not allowed: %s (s: %s, s1: %s, s2: %s)" % (current_line, index, new_list, structure, structure1, structure2)
                            lua_pop(L, 1)
                            continue
                        if structure2 is not None and index in structure2 and structure2[index] is not None and not ARRAY in structure2[index]:
                            new_list = []
                            get_table_as_list(L, -1, new_list, None)
                            print >>lua_log_err, "[%d] [gtal] Array (%s) as value is not allowed here! Not allowed: %s (s: %s, s1: %s, s2: %s" % (current_line, index, new_list, structure, structure1, structure2)
                            lua_pop(L, 1)
                            continue
                    new_list = []
                    if structure2 is not None and index in structure2 and structure2[index] is not None and ARRAY in structure2[index]:
                        new_structure = structure2[index][ARRAY]
                    elif structure1 is not None:
                        new_structure = structure1.get(ARRAY, None)
                    else:
                        new_structure = None
                    get_table_as_list(L, -1, new_list, new_structure)
                    #print unicode(new_list)
                    l.append(new_list)
                else:
                    #print "[%d] value (%s) is a dict" % (current_line, index)
                    if structure is not None:
                        if structure1 is not None and len(structure1) > 0 and not DICT in structure1:
                            new_dict = {}
                            get_table_as_dict(L, -1, new_dict, None)
                            print >>lua_log_err, "[%d] [gtal] Dict (%s) as value is not allowed here!\nNot allowed: %s (s: %s, s1: %s, s2: %s)" % (current_line, index, new_dict, structure, structure1, structure2)
                            lua_pop(L, 1)
                            continue
                        if structure2 is not None and index in structure2 and structure2[index] is not None and not DICT in structure2[index]:
                            new_dict = {}
                            get_table_as_dict(L, -1, new_dict, None)
                            print >>lua_log_err, "[%d] [gtal] Dict (%s) as value is not allowed here!\nNot allowed: %s (%s, %s, %s)" % (current_line, index, new_dict, structure, structure1, structure2)
                            lua_pop(L, 1)
                            continue
                    new_dict = {}
                    if structure2 is not None and index in structure2 and structure2[index] is not None and DICT in structure2[index]:
                        new_structure = structure2[index][DICT]
                    elif structure1 is not None:
                        new_structure = structure1.get(DICT, None)
                    else:
                        new_structure = None
                    get_table_as_dict(L, -1, new_dict, new_structure)
                    #print unicode(new_dict)
                    l.append(new_dict)
        lua_pop(L, 1)
        #i += 1
    # stack now contains: -1 => table (when lua_next returns 0 it pops the key
    # but does not push anything.)
    # Pop table
    lua_pop(L, 1)
    # Stack is now the same as it was on entry to this function
    return True


cdef bint get_table_as_dict(lua_State *L, int table, dict d, structure=None):

    """
        {"pet": "cat", "size": "big"}
    """

    cdef:
        int i = 1
        int n
        object key
        object value
        object structure1 = None
        object structure2 = None
        object new_structure
        dict new_dict = {}
        list new_list = []
    global current_line
    #print "structure", structure
    #luaL_checktype(L, table, LUA_TTABLE);
    #print "get_table_as_dict"
    #n = lua_rawlen(L, table)
    if not lua_istable(L, table):
        return False
    if structure is not None:
        if len(structure) == 1 or isinstance(structure, dict):
            structure1 = structure
        elif len(structure) == 2:
            structure1 = structure[0]
            structure2 = structure[1]
            if not isinstance(structure1, dict):
                structure1 = None
            if not isinstance(structure2, dict):
                structure2 = None
    #print "structure1", structure1
    #print "structure2", structure2
    # Push another reference to the table on top of the stack (so we know
    # where it is, and this function can work for negative, positive and
    # pseudo indices
    lua_pushvalue(L, table)
    # stack now contains: -1 => table
    lua_pushnil(L)
    # stack now contains: -1 => nil; -2 => table
    while lua_next(L, -2) != 0:
    #while i <= n:
        #lua_rawgeti(L, table, i)
        if lua_isinteger(L, -2):
            #print "index is an integer"
            key = lua_tointeger(L, -2)
        elif lua_isstring(L, -2):
            #print "index is a string"
            key = lua_string_to_python_unicode(L, -2)
        else:
            #print "pop"
            lua_pop(L, 1)
            continue
        if lua_isstring(L, -1):
            value = lua_string_to_python_unicode(L, -1)
            #print "value (%s:%s) is a string" % (key, value)
            if structure is not None:
                if key in structure2 and not STRING in structure2[key]:
                    print >>lua_log_err, "[%d] [gtad] String (%s:%s) as value is not allowed here!" % (current_line, key, value)
                    lua_pop(L, 1)
                    continue
                if structure1 is not None and not STRING in structure1:
                    print >>lua_log_err, "[%d] [gtad] String (%s:%s) as value is not allowed here!" % (current_line, key, value)
                    lua_pop(L, 1)
                    continue
            #print value
            d[key] = value
        elif lua_isinteger(L, -1):
            value = lua_tointeger(L, -1)
            #print "value (%s:%s) is an integer" % (key, value)
            if structure is not None:
                if key in structure and not INTEGER in structure2[key]:
                    print >>lua_log_err, "[%d] [gtad] Integer (%s:%s) as value is not allowed here!" % (current_line, key, value)
                    lua_pop(L, 1)
                    continue
                if structure1 is not None and not INTEGER in structure1:
                    print >>lua_log_err, "[%d] [gtad] Integer (%s:%s) as value is not allowed here!" % (current_line, key, value)
                    lua_pop(L, 1)
                    continue
            #print value
            d[key] = value
        elif lua_isboolean(L, -1):
            value = lua_toboolean(L, -1)
            #print "value (%s:%s) is an booelan" % (key, value)
            if structure is not None:
                if key in structure and not BOOLEAN in structure2[key]:
                    print >>lua_log_err, "[%d] [gtad] Boolean (%s:%s) as value is not allowed here!" % (current_line, key, value)
                    lua_pop(L, 1)
                    continue
                if structure1 is not None and not BOOLEAN in structure1:
                    print >>lua_log_err, "[%d] [gtad] Boolean (%s:%s) as value is not allowed here!" % (current_line, key, value)
                    lua_pop(L, 1)
                    continue
            #print value
            d[key] = value
        elif lua_isfunction(L, -1):
            #print "value (%s) is a function" % key
            if structure is not None:
                if key in structure2 and not FUNCTION in structure2[key]:
                    print >>lua_log_err, "[%d] [gtad] Function (%s) as value is not allowed here!" % (current_line, key)
                    lua_pop(L, 1)
                    continue
                if structure1 is not None and not FUNCTION in structure1:
                    print >>lua_log_err, "[%d] [gtad] Function (%s) as value is not allowed here!" % (current_line, key)
                    lua_pop(L, 1)
                    continue
            """
            Creates and returns a reference, in the table at index t, for the object at the top of the stack (and pops the object).

            A reference is a unique integer key. As long as you do not manually add integer keys into table t, luaL_ref ensures the uniqueness of the key it returns. You can retrieve an object referred by reference r by calling lua_rawgeti(L, t, r). Function luaL_unref frees a reference and its associated object.

            If the object at the top of the stack is nil, luaL_ref returns the constant LUA_REFNIL. The constant LUA_NOREF is guaranteed to be different from any reference returned by luaL_ref. 
            """
            ref = luaL_ref(L, LUA_REGISTRYINDEX)
            #print ref
            d[key] = LuaCmd(<long>L, ref)
            # luaL_ref pops the object, so we skip the next pop.
            continue
        elif lua_istable(L, -1):
            #print "value is a table"
            if not (structure is not None and ((structure1 is not None and DICT in structure1) or (structure2 is not None and key in structure2 and DICT in structure2[key]))) and is_array(L, -1):
                #print "table is an array"
                if structure is not None:
                    if key in structure2 and not ARRAY in structure2[key]:
                        new_list = []
                        get_table_as_list(L, -1, new_list, None)
                        print >>lua_log_err, "[%d] [gtad] Array (%s) as value is not allowed here!\nNot allowed: %s (s: %s, s1: %s, s2: %s)" % (current_line, key, new_list, structure, structure1, structure2)
                        lua_pop(L, 1)
                        continue
                    if structure1 is not None and not ARRAY in structure1:
                        new_list = []
                        get_table_as_list(L, -1, new_list, None)
                        print >>lua_log_err, "[%d] [gtad] Array (%s) as value is not allowed here!\nNot allowed: %s (s: %s, s1: %s, s2: %s)" % (current_line, key, new_list, structure, structure1, structure2)
                        lua_pop(L, 1)
                        continue
                new_list = []
                if structure2 is not None and key in structure2 and structure2[key] is not None and ARRAY in structure2[key]:
                    new_structure = structure2[key][ARRAY]
                elif structure1 is not None:
                    new_structure = structure1.get(ARRAY, None)
                else:
                    new_structure = None
                get_table_as_list(L, -1, new_list, new_structure)
                #print unicode(new_list)
                d[key] = new_list
            else:
                #print "table is a dict"
                if structure is not None:
                    if structure2 is not None and key in structure2 and not DICT in structure2[key]:
                        new_dict = {}
                        get_table_as_dict(L, -1, new_dict, None)
                        print >>lua_log_err, "[%d] [gtad] Dict (%s) as value is not allowed here!\nNot allowed: %s (s: %s, s1: %s, s2: %s)" % (current_line, key, new_dict, structure, structure1, structure2)
                        lua_pop(L, 1)
                        continue
                    if structure1 is not None and len(structure1) > 0 and not DICT in structure1:
                        new_dict = {}
                        get_table_as_dict(L, -1, new_dict, None)
                        print >>lua_log_err, "[%d] [gtad] Dict (%s) as value is not allowed here!\nNot allowed: %s (s: %s, s1: %s, s2: %s)" % (current_line, key, new_dict, structure, structure1, structure2)
                        lua_pop(L, 1)
                        continue
                new_dict = {}
                if structure2 is not None and key in structure2 and structure2[key] is not None and DICT in structure2[key]:
                    new_structure = structure2[key][DICT]
                elif structure1 is not None:
                    new_structure = structure1.get(DICT, None)
                else:
                    new_structure = None
                get_table_as_dict(L, -1, new_dict, new_structure)
                #print unicode(new_dict)
                d[key] = new_dict
        lua_pop(L, 1)
        #i += 1
    # stack now contains: -1 => table (when lua_next returns 0 it pops the key
    # but does not push anything.)
    # Pop table
    lua_pop(L, 1)
    # Stack is now the same as it was on entry to this function
    return True


cdef int l_execute(lua_State *L):
    cdef:
        const char* path = luaL_checkstring(L, 1)
        bint use_connection_handlers = lua_toboolean(L, 2)
        dict parameters = {}
        dict success_codes = {}
        dict error_codes = {}
    get_table_as_dict(L, 3, parameters)
    get_table_as_dict(L, 4, success_codes)
    get_table_as_dict(L, 5, error_codes)


cdef int is_array(lua_State *L, int table):
    cdef:
        int i = 1
        int n
    if lua_istable(L, table):
        table = table - 1
        # key is at index -2 and value is at index -1
        lua_pushnil(L)
        while lua_next(L, table) != 0:
            if not lua_isinteger(L, -2):
                lua_pop(L, 2)
                return False
            lua_pop(L, 1)
        """
        n = lua_rawlen(L, table)
        while i <= n:
            lua_rawgeti(L, table, i)
            i = i + 1
            if not lua_isinteger(L, -2):
                print "NO INTEGER!"
                return False
        """
    else:
        return False
    return True


cdef int l_is_array(lua_State *L):
    cdef:
        int i = 1
        int n
        bint is_array = True
    if lua_istable(L, 1):
        lua_pushnil(L)
        # key is at index -2 and value is at index -1
        while lua_next(L, 1) != 0:
            if not lua_isinteger(L, -2):
                is_array = False
                lua_pop(L, 2)
                break
            lua_pop(L, 1)
        """
        n = lua_rawlen(L, 1)
        while i <= n:
            lua_rawgeti(L, 1, i)
            i = i + 1
            if not lua_isinteger(L, -2):
                is_array = False
                break
        """
    else:
        is_array = False
    lua_pushboolean(L, is_array)
    return 1


cdef list get_version(lua_State* L):
    cdef:
        DWORD dw_version
        const char* version
    lua_getglobal(L, "version")
    if lua_isinteger(L, -1):
        dw_version = lua_tointeger(L, -1)
        return (HIWORD(dw_version), LOWORD(dw_version))
    elif lua_isstring(L, -1):
        version = lua_tostring(L, -1)
        return version.split(".")
    return (1, 0)


def get_absolute_config_path(settings_path, path):
    # is path absolute?
    m = re.match(r"[a-zA-Z]{1,1}:\\", path)
    # is path a url?
    m2 = re.match(r"[a-zA-Z]+://", path)
    if m is None and m2 is None:
        path = os.path.join(os.path.dirname(os.path.abspath(settings_path)), path)
    return path


cdef class LuaCmd(Cmd):

    cdef:
        public int _ref
        lua_State *_l

    def __init__(self, long l, int ref, success_codes = {}, error_codes = {}):
    #def __init__(self, int ref):
        self._l = <lua_State*>PyLong_AsVoidPtr(l)
        self._ref = ref
        self._parameters = []
        self._success_codes = success_codes
        self._error_codes = error_codes
        self._ret_code_type = libs.handlers.config.RET_CODE_UNKNOWN
        self._ret_code_description = ''

    def _get_cmd(self, parameters=[]):
        return u""

    def __call__(self, parameters=[]):
        return self._execute(parameters)

    cdef int get_ref(self):
        return self._ref

    cdef int set_lua_state(self, lua_State *l):
        self._l = l

    @property
    def ref(self):
        return self._ref

    cdef unsigned long _execute(self, object parameters=[]):
        cdef:
            unsigned long ret_code = 0
            const char* err_msg

        global lua_log_err
        global lua_log_out
        lua_rawgeti(self._l, LUA_REGISTRYINDEX, self._ref)
        # Lua state variable, arguments count, return value count.
        ret_code = lua_pcall(self._l, 0, 1, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            self._ret_code_type = libs.handlers.config.RET_CODE_ERROR
            self._ret_code_description = err_msg

        # retrieve result
        if not lua_isinteger(self._l, -1):
            pass
        ret_code = lua_tointeger(self._l, -1)
        if ret_code in self._success_codes:
            self._ret_code_type = libs.handlers.config.RET_CODE_SUCCESS
            self._ret_code_description = self._success_codes.get(ret_code, u"")
        elif ret_code in self._error_codes:
            self._ret_code_type = libs.handlers.config.RET_CODE_ERROR
            self._ret_code_description = self._error_codes.get(ret_code, u"")

        lua_pop(self._l, 1);  # pop returned value

        return ret_code

    def execute(self, object parameters=[]):
        return self._execute()

    def __iter__(self):
        return self._parameters

    def remove(self, value):
        self._parameters.remove(value)

    def __repr__(self):
        return self._get_cmd()

    def __unicode__(self):
        return self._get_cmd()


cdef class Package(BasePackage):
    cdef:
        cmd* _function_is_installed
        cmd* _function_is_upgrade_available
        lua_State* _l

    def __init__(self, package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, icon,icon_type, package_list, connection_list, dependencies_list, log, status_handler, l=None, function_is_installed = None, function_is_upgrade_available = None):
        BasePackage.__init__(self, package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, icon, icon_type, package_list, connection_list, dependencies_list, log, status_handler)

    def __cinit__(self, package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, icon, icon_type, package_list, connection_list, dependencies_list, log, status_handler, l=None, function_is_installed = None, function_is_upgrade_available = None):
        if isinstance(l, int):
            self._l = <lua_State*>PyLong_AsVoidPtr(l)
            if function_is_installed is None:
                self._function_is_installed = NULL
            elif isinstance(function_is_upgrade_available, int):
                self._function_is_installed = <cmd*>PyLong_AsVoidPtr(function_is_installed)
            if function_is_upgrade_available is None:
                self._function_is_upgrade_available = NULL
            elif isinstance(function_is_upgrade_available, int):
                self._function_is_upgrade_available = <cmd*>PyLong_AsVoidPtr(function_is_upgrade_available)

    cdef set_lua_check_functions(self, lua_State *L, cmd *func1, cmd *func2):
        self._function_is_installed = func1
        self._function_is_upgrade_available = func2
        self._l = L

    cdef bint _is(self, cmd *func, bint b_is):
        cdef:
            int ret_val
            const char* err_msg
            LuaCmd lua_cmd
        global lua_log_err
        if func == NULL:
            return b_is
        if func.type == ct_lua_cmd:
            lua_cmd = <object>func.cmd.lua_cmd
            lua_rawgeti(self._l, LUA_REGISTRYINDEX,  lua_cmd.get_ref())
        elif func.type == ct_string:
            lua_getglobal(self._l, func.cmd.cmd)
        if not lua_isfunction (self._l, -1):
            #print "no function available to check if an upgrade is available"
            return b_is

        #print "checking if upgrade is available..."
        ret_code = lua_pcall(self._l, 0, 1, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg

        if ret_code != 0:
            #print "error running function '%s': %s" % (func, lua_tostring(self._l, -1))
            return b_is
        # retrieve result 
        if not lua_isboolean(self._l, -1):
            #print "function '%s' must return a booelan" % func
            return b_is
        b_is = lua_toboolean(self._l, -1)
        return b_is

    @property
    def installed(self):
        return self._is(self._function_is_installed, self._installed)

    @property
    def upgrade_available(self):
        return self._is(self._function_is_upgrade_available, self._upgrade_available)

   # redundant code
    def install(self, force=False):
        return self._execute_cmds(self.install_cmds)

    def upgrade(self):
        return self._execute_cmds(self.upgrade_cmds)

    def uninstall(self):
        return self._execute_cmds(self.uninstall_cmds)
    """
    def __dealloc__(self):
        cdef:
            #LuaCmd lua_cmd
            object lua_cmd
        print 1
        if self._function_is_installed != NULL:
            print 11
            if self._function_is_installed.type == ct_lua_cmd:
                print 111
                lua_cmd = <object>(self._function_is_installed.cmd.lua_cmd)
                print 112
                Py_DECREF(lua_cmd)
            print 12
            free(self._function_is_installed)
            print 13
        print 2
        if self._function_is_upgrade_available != NULL:
            print 21
            if self._function_is_upgrade_available.type == ct_lua_cmd:
                print 211
                lua_cmd = <object>(self._function_is_upgrade_available.cmd.lua_cmd)
                print 212
                Py_DECREF(lua_cmd)
            print 22
            free(self._function_is_upgrade_available)
            print 23
    """


cdef class Settings(BaseSettings):

    cdef:
        lua_State *_l

    def __init__(self, settings_path):

        BaseSettings.__init__(self, settings_path)
        #print >>sys.stdout, "settings path:", settings_path
        self._lua()

    def _lua(self):
        cdef:
            int ret_code
            const char* err_msg
            unicode package_list_path
        global lua_log_err
        # Create Lua state variable
        self._l = luaL_newstate()
        # Load Lua libraries
        luaL_openlibs(self._l)
        #lua_pushcfunction(self._l, l_register_package)
        #lua_setglobal(self._l, "register_package")

        #lua_push_logging(self._l)
        # Load but don't run the Lua script 
        ret_code = luaL_loadfile(self._l, self._settings_path)
        if ret_code:
            #print "luaL_loadfile(%s) failed!" % self._settings_path
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            if ret_code ==  LUA_ERRFILE:
                raise IOError(2, "File not found!", self._settings_path)
            return False

        # Run the lua
        ret_code = lua_pcall(self._l, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
        if ret_code != 0:
            #print "lua_pcall() failed!"
            return False

        self._install_list = get_absolute_config_path(self._settings_path, self._lua_get_string("install_list"))
        self._host_list = get_absolute_config_path(self._settings_path, self._lua_get_string("host_list"))
        self._installed_list = get_absolute_config_path(self._settings_path, self._lua_get_string("installed_list"))
        package_list_path = self._lua_get_string("package_list")
        if package_list_path != "":
            self._package_list = get_absolute_config_path(self._settings_path, package_list_path)
        lua_getglobal(self._l, "package_lists")
        if lua_istable(self._l, -1):
            get_table_as_list(self._l, -1, self._package_lists)
        self._connection_list = get_absolute_config_path(self._settings_path, self._lua_get_string("connection_list"))
        self._log_list = get_absolute_config_path(self._settings_path, self._lua_get_string("log_list"))
        self._profile_list = get_absolute_config_path(self._settings_path, self._lua_get_string("profile_list"))
        self._u_run = self._lua_get_string("run").lower()
        if self._u_run in (u"shutdown", u"on_shutdown"):
            self._run = ON_SHUTDOWN
        elif self._u_run in (u"", u"start", u"on_start"):
            self._run = ON_START
        elif self._u_run in (u"repeatedly", u"frequently"):
            self._run = REPEATEDLY
        else:
            #print >>sys.stderr, "unknown", self._u_run
            self._run = ON_START
        self._u_display_target = self._lua_get_string("display_target").lower()
        if self._u_display_target in ("u", u"current_user"):
            self._display_target = CURRENT_USER
        elif self._u_display_target == u"winlogon":
            self._display_target = WINLOGON
        self._interval = self._lua_get_int("interval")
        self._target_source = self._lua_get_string("target_source")
        self._status_gui_cmd = self._lua_get_string("status_gui")

        #print "install_list: %s\ninstall_list: %s\nhost_list: %s\npackage_list: %s\nconnection_list: %s\nlog_list: %s\nprofile_list: %s\ntarget_source: %s\nstatus_gui_cmd: %s\n" % (self._install_list, self._host_list, self._installed_list, self._package_list, self._connection_list, self._log_list, self._profile_list, self._target_source, self._status_gui_cmd)
        lua_close(self._l)
        return True

    cdef unicode _lua_get_string(self, const char *var_name):
        lua_getglobal(self._l, var_name)
        if lua_isstring(self._l, -1):
            return lua_string_to_python_unicode(self._l, -1)
        return u""

    cdef int _lua_get_int(self, const char *var_name):
        lua_getglobal(self._l, var_name)
        if lua_isinteger(self._l, -1):
            return lua_tointeger(self._l, -1)
        return 0


cdef class PackageList(BasePackageList):

    cdef:
        lua_State *_l

    def __init__(self, package_list_path, connection_list, installed_list, log, status_handler):

        BasePackageList.__init__(self, package_list_path, connection_list, installed_list, log, status_handler)
        self._packages = {}

        self._log.log_info(unicode(self._packages))
        self._lua()

    def _translate_ret_codes_for_api_1_0(self, dict ret_codes):
        for ret_code_id in ret_codes:
            ret_code = ret_codes[ret_code_id]
            ret_codes[ret_code_id] = ret_code.get("description", u"")

    def _set_default_return_codes(self, list cmds, dict ret_codes):
        cdef:
            object cmd

        for cmd in cmds:
            if isinstance(cmd, Cmd) or isinstance(cmd, LuaCmd):
                if len(cmd.success_codes) == 0:
                    cmd.success_codes = ret_codes.get("success_codes", {})
                if len(cmd.error_codes) == 0:
                    cmd.error_codes = ret_codes.get("error_codes", {})

    def _lua(self):
        cdef:
            str arch = platform.machine()
            const char *c_arch = <const char*>arch
            int ret_code
            const char* err_msg
            list package_list = []
            str var_name
            unicode package_id
            dict dict_package
            unicode version
            unicode rev
            object icon
            dict ret_codes
            list install_cmds
            list uninstall_cmds
            list upgrade_cmds
            #bint installed
            unicode description
            list keywords
            #bint upgrade_available
            list dependencies
            object installed_function
            object upgrade_available_function
            # Can be LuaCmd or Boolean
            object installed
            # Can be LuaCmd or Boolean
            object upgrade_available
            int cmd_size = sizeof(cmd)
            # will be freed in class Package.__dealloc__() 
            cmd *p_func_installed
            cmd *p_func_upgrade_available

        global lua_log_err
        global lua_log_out
        # Create Lua state variable
        self._l = luaL_newstate()
        # Load Lua libraries
        luaL_openlibs(self._l)
        lua_pushcfunction(self._l, l_register_package)
        lua_setglobal(self._l, "register_package")

        lua_pushcfunction(self._l, l_is_in_software_list)
        lua_setglobal(self._l, "is_in_software_list")

        lua_pushcfunction(self._l, l_is_in_installed_list)
        lua_setglobal(self._l, "is_in_installed_list")

        lua_pushcfunction(self._l, l_is_upgrade_available)
        lua_setglobal(self._l, "is_upgrade_available")

        # iterator
        lua_pushcfunction(self._l, l_software_list)
        lua_setglobal(self._l, "software_list")

        # iterator
        lua_pushcfunction(self._l, l_software_list2)
        lua_setglobal(self._l, "software_list2")

        # iterator
        lua_pushcfunction(self._l, l_installed_list)
        lua_setglobal(self._l, "installed_list")

        lua_pushcfunction(self._l, l_execute)
        lua_setglobal(self._l, "execute")

        lua_pushcfunction(self._l, l_include)
        lua_setglobal(self._l, "include")

        # SHARE TYPE 
        lua_pushinteger(self._l, STYPE_DISKTREE)
        lua_setglobal(self._l, "STYPE_DISKTREE")
        lua_pushinteger(self._l, STYPE_PRINTQ)
        lua_setglobal(self._l, "STYPE_PRINTQ")
        lua_pushinteger(self._l, STYPE_DEVICE)
        lua_setglobal(self._l, "STYPE_DEVICE")
        lua_pushinteger(self._l, STYPE_IPC)
        lua_setglobal(self._l, "STYPE_IPC")
        lua_pushinteger(self._l, STYPE_TEMPORARY)
        lua_setglobal(self._l, "STYPE_TEMPORARY")
        lua_pushinteger(self._l, STYPE_SPECIAL)
        lua_setglobal(self._l, "STYPE_SPECIAL")
        # PERMISSIONS
        lua_pushinteger(self._l, ACCESS_READ)
        lua_setglobal(self._l, "ACCESS_READ")
        lua_pushinteger(self._l, ACCESS_WRITE)
        lua_setglobal(self._l, "ACCESS_WRITE")
        lua_pushinteger(self._l, ACCESS_CREATE)
        lua_setglobal(self._l, "ACCESS_CREATE")
        lua_pushinteger(self._l, ACCESS_EXEC)
        lua_setglobal(self._l, "ACCESS_EXEC")
        lua_pushinteger(self._l, ACCESS_DELETE)
        lua_setglobal(self._l, "ACCESS_DELETE")
        lua_pushinteger(self._l, ACCESS_ATRIB)
        lua_setglobal(self._l, "ACCESS_ATRIB")
        lua_pushinteger(self._l, ACCESS_PERM)
        lua_setglobal(self._l, "ACCESS_PERM")
        lua_pushinteger(self._l, ACCESS_ALL)
        lua_setglobal(self._l, "ACCESS_ALL")
        # Share Iterator
        lua_pushcfunction(self._l, l_net_shares)
        lua_setglobal(self._l, "net_shares")

        lua_pushcfunction(self._l, l_get_file_version_info)
        lua_setglobal(self._l, "get_file_version_info")

        lua_pushcfunction(self._l, l_sleep)
        lua_setglobal(self._l, "sleep")

        lua_pushcfunction(self._l, l_loword)
        lua_setglobal(self._l, "loword")

        lua_pushcfunction(self._l, l_hiword)
        lua_setglobal(self._l, "hiword")

        # map python functions to lua
        lua_pushcfunction(self._l, l_join_path)
        lua_setglobal(self._l, "join_path")

        lua_pushcfunction(self._l, l_isabs)
        lua_setglobal(self._l, "isabs")

        lua_pushcfunction(self._l, l_isdir)
        lua_setglobal(self._l, "isdir")

        lua_pushcfunction(self._l, l_isfile)
        lua_setglobal(self._l, "isfile")

        lua_pushcfunction(self._l, l_islink)
        lua_setglobal(self._l, "islink")

        lua_pushcfunction(self._l, l_getatime)
        lua_setglobal(self._l, "getatime")

        lua_pushcfunction(self._l, l_getmtime)
        lua_setglobal(self._l, "getmtime")

        lua_pushcfunction(self._l, l_getctime)
        lua_setglobal(self._l, "getctime")

        lua_pushcfunction(self._l, l_splitdrive)
        lua_setglobal(self._l, "splitdrive")

        lua_pushcfunction(self._l, l_startswith)
        lua_setglobal(self._l, "startswith")

        lua_pushcfunction(self._l, l_endswith)
        lua_setglobal(self._l, "endswith")

        lua_pushcfunction(self._l, l_split)
        lua_setglobal(self._l, "split")

        lua_pushcfunction(self._l, l_regex_does_match)
        lua_setglobal(self._l, "regex_does_match")

        lua_pushcfunction(self._l, l_regex_match)
        lua_setglobal(self._l, "regex_match")


        lua_push_winreg(self._l)


        lua_pushcfunction(self._l, l_set_installed)
        lua_setglobal(self._l, "set_installed")

        lua_pushcfunction(self._l, l_set_upgrade_available)
        lua_setglobal(self._l, "set_upgrade_available")

        lua_pushcfunction(self._l, l_set_install_cmds)
        lua_setglobal(self._l, "set_install_cmds")

        lua_pushcfunction(self._l, l_set_uninstall_cmds)
        lua_setglobal(self._l, "set_uninstall_cmds")

        lua_pushcfunction(self._l, l_set_upgrade_cmds)
        lua_setglobal(self._l, "set_upgrade_cmds")

        lua_pushcfunction(self._l, l_set_package_check_functions)
        lua_setglobal(self._l, "set_package_check_functions")

        lua_pushstring(self._l, c_arch)
        lua_setglobal(self._l, "arch")

        lua_push_logging(self._l)
        lua_push_domain_info(self._l)
        lua_push_get_computer_name_ex_functions(self._l)
        lua_push_is_array(self._l)
        lua_pushlightuserdata(self._l, <PyObject *>self)
        lua_setglobal(self._l, 'p_package_list')
        lua_pushlightuserdata(self._l, <PyObject *>self._connection_list)
        lua_setglobal(self._l, 'p_connection_list')
        lua_pushlightuserdata(self._l, <PyObject *>self._installed_list)
        lua_setglobal(self._l, 'p_installed_list')
        lua_sethook(self._l, lua_hook, LUA_MASKLINE, 0)
        # Load but don't run the Lua script 
        ret_code = luaL_loadfile(self._l, self._config_path)
        if ret_code:
            #print "%s: luaL_loadfile() failed!" % "PackageList"
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            if ret_code ==  LUA_ERRFILE:
                raise IOError(2, "File not found!", self._config_path)
            return False

        # Run the loaded Lua script
        ret_code = lua_pcall(self._l, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
        if ret_code != 0:
            #print "%s: lua_pcall() failed!" % "PackageList"
            return False
        for var_name in ("package_list", "packages"):
            lua_getglobal(self._l, var_name)
            if lua_isnil(self._l, -1):
                print >>lua_log_out, "no %s found" % var_name
            elif lua_istable(self._l, -1):
                print >>lua_log_out, "found %s found" % var_name
                break
        if lua_isnil(self._l, -1) or not lua_istable(self._l, -1):
            #print "No package_list found!"
            return False

        self._log.log_debug(u"[holdes_mondenkind] [package_list] Found table")
        if is_array(self._l, -1):
            self._log.log_debug(u"[holdes_mondenkind] [package_list] Table is an Array")
            """
            packages = {
                {   package_id = "7zip",
                    uninstall_cmds = 
                        {
                            {
                                cmd = [["file://%PROGRAMFILES(X86)%\\7-Zip\\uninstall.exe"]],
                                args = {
                                    {   parameter = [[/S]],
                                        values = {
                                            {
                                                "",
                                                false
                                            },
                                        }
                                    }
                                }
                            }
                        },
                    install_cmds = 
                        {
                            {
                                cmd = "http://www.7-zip.org/a/7z920.exe",
                                args = {
                                    {   parameter = "/S",
                                        values = {
                                            {
                                                "",
                                                false
                                            }
                                        }
                                    }
                                }
                            }
                        },
                    is_installed = 
                        function()
                            return is_in_installed_list([[^7-Zip\s9\.2]])
                        end,
                    is_upgrade_available = function()
                        return is_in_installed_list([[^7-Zip\s9\.2]])
                    end,
                    dependencies = {
                        {   package_id = "winrar",
                            installed = false,
                        } 
                    }
                }
            }
            """
            get_table_as_list(
                self._l, 
                -1, 
                package_list, 
                    (
                        {
                            DICT: (
                                None,
                                {   "package_id": {STRING: ""},
                                    "uninstall_cmds":
                                        {   ARRAY: ( 
                                                {   DICT: (
                                                        None,
                                                        {   "cmd": {STRING: ""},
                                                            "args": {
                                                                ARRAY: (
                                                                    {   DICT: (
                                                                            None,
                                                                            {   "parameter": {STRING: ""},
                                                                                "values": {
                                                                                    ARRAY: (
                                                                                        {   ARRAY: None
                                                                                        }, 
                                                                                        None
                                                                                    )
                                                                                }
                                                                            }
                                                                        )
                                                                    }
                                                                )
                                                            }
                                                        }
                                                    )
                                                },
                                                None
                                            )
                                        }
                                    ,
                                    "return_codes": 
                                        {   DICT: (
                                                {   DICT: None
                                                },
                                                {
                                                    "error_codes": {    DICT: None},
                                                    "success_codes": {    DICT: None},
                                                }
                                            )
                                        }
                                    ,
                                    "ret_codes": 
                                        {   DICT: (
                                                {   DICT: None
                                                },
                                                {
                                                    "error_codes": {    DICT: None},
                                                    "success_codes": {    DICT: None},
                                                }
                                            )
                                        }
                                    ,
                                    "dependencies":
                                        {   ARRAY: (
                                                {   DICT: (
                                                        None,
                                                        {   "package_id": { STRING: None},
                                                            "installed": { BOOLEAN: None}
                                                        }
                                                    )
                                                }, 
                                                None
                                            )
                                        }
                                }
                            )
                        }, 
                        None
                    )
            )
            #get_table_as_list(self._l, -1, package_list)
            self._log.log_debug(u"[holdes_mondenkind] [package_list] %s" % package_list)
            #print "PACKAGE LIST:", package_list
            for dict_package in package_list:
                # Skip package when package_id is missing
                if not u'package_id' in dict_package:
                    self._log.log_err(u"[holdes_mondenkind] [package_list] package_id is missing in %s" % self._config_path)
                    continue
                installed_function = None
                upgrade_available_function = None
                package_id = dict_package[u'package_id']
                name = dict_package.get(u'name', u'')
                version = dict_package.get(u'version', u'')
                rev = dict_package.get(u'rev', u'')
                ret_codes = dict_package.get(u'ret_codes', dict_package.get(u'return_codes', {}))
                install_cmds = dict_package.get(u'install_cmds', [])
                uninstall_cmds = dict_package.get(u'uninstall_cmds', [])
                upgrade_cmds = dict_package.get(u'upgrade_cmds', [])
                installed = dict_package.get(u'installed', dict_package.get(u'is_installed', False))
                upgrade_available = dict_package.get(u'upgrade_available', dict_package.get(u'is_upgrade_available', False))

                self._translate_ret_codes_for_api_1_0(ret_codes.get('success_codes', {}))
                self._translate_ret_codes_for_api_1_0(ret_codes.get('error_codes', {}))
                self._set_default_return_codes(install_cmds, ret_codes)
                self._set_default_return_codes(uninstall_cmds, ret_codes)
                self._set_default_return_codes(upgrade_cmds, ret_codes)

                icon = dict_package.get(u'icon', u"")
                icon_type = dict_package.get(u'icon_type', u"")

                description = dict_package.get(u'description', u'')
                keywords = dict_package.get(u'keywords', [])
                upgrade_available_function = dict_package.get(u'upgrade_available_function', dict_package.get(u'function_is_upgrade_available', None))
                installed_function = dict_package.get(u'installed_funcion', dict_package.get(u'function_is_installed', None))
                dependencies = dict_package.get(u'dependencies', [])
                #print "install_cmds:", unicode(install_cmds)
                #print "upgrade_cmds:", unicode(upgrade_cmds)
                #print "uninstall_cmds:", unicode(uninstall_cmds)
                if isinstance(installed, LuaCmd):
                    #print "Installed is LuaCmd"
                    installed_function = installed
                    installed = installed_function.execute()
                    p_func_installed = <cmd*>malloc(cmd_size)
                    p_func_installed.cmd.lua_cmd = <PyObject*>installed_function
                    p_func_installed.type = ct_lua_cmd
                    Py_INCREF(installed_function)
                if isinstance(upgrade_available, LuaCmd):
                    #print "upgrade available is LuaCmd"
                    upgrade_available_function = upgrade_available
                    upgrade_available = upgrade_available_function.execute()
                    p_func_upgrade_available = <cmd*>malloc(cmd_size)
                    p_func_upgrade_available.cmd.lua_cmd = <PyObject*>upgrade_available_function
                    p_func_upgrade_available.type = ct_lua_cmd
                    Py_INCREF(upgrade_available_function)
                self.__handle_cmds(install_cmds)
                self.__handle_cmds(uninstall_cmds)
                self.__handle_cmds(upgrade_cmds)

                self[package_id] = Package(package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, icon, icon_type, self, self._connection_list, dependencies, self._log, self._status_handler, <int>self._l, function_is_installed = <int>p_func_installed, function_is_upgrade_available = <int>p_func_upgrade_available)
                #self[package_id] = Package(package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, self._connection_list, dependencies, self._log, function_is_installed = installed_function, function_is_upgrade_available = upgrade_available_function)


    cdef dict __handle_cmd_codes(self, object cmd, unicode code_name):
        cdef:
            dict codes

        if code_name in cmd:
            if type(cmd[code_name]) is list:
                codes = {}
                for code in cmd[code_name]:
                    codes[code] = u""
            elif type(cmd[code_name]) is list:
                codes = cmd[code_name]
        else:
            codes = {}
        return codes

    cdef list __handle_cmd_parameters(self, object cmd):
        cdef:
            int i
            unicode argument
            dict parameter
            list parameters
        parameters = cmd.get(u'args', [])
        for i in range(0, len(parameters)):
            parameter = parameters[i]
            if "parameter" in parameter:
                argument = parameter["parameter"]
                parameter["argument"] = argument
        return parameters

    def __handle_cmds(self, list cmds):
        """
        values can be a dict, a list or a unicode string. If values is a list, then the second entry could be a boolean. 

        [
            {   u'cmd': u'"file://%PROGRAMFILES(X86)%\\7-Zip\\uninstall.exe"',
                u'args': [
                    {   u'parameter': u'/S', 
                        u'values': [[u'']]
                    }
                    {   u'parameter': u'/T', 
                        u'values': [[u'qwertz', False]]
                    }
                ]
            }
        ]

        ...

        [
            {   u'cmd': u'"file://%PROGRAMFILES(X86)%\\7-Zip\\uninstall.exe"',
                u'args': [
                    {   u'parameter': u'/S', 
                        u'values': [
                            {   u"value": u'test', 
                                u"allow_connection_handler": False
                            },
                            {   u"value": u'blub', 
                            },
                            {   u"value": u'http://unicom.ws/daten.csv', 
                                u"allow_connection_handler": True
                            },
                        ]
                    }
                ]
            }
        ]
        ...

        [
            {   u'cmd': u'"file://%PROGRAMFILES(X86)%\\7-Zip\\uninstall.exe"',
                u'args': [
                    {   u'parameter': u'/S', 
                        u'values': [
                            u"a",
                            u"b",
                            u"c"
                        ]
                    }
                ]
            }
        ]
        """
        cdef:
            object cmd
            unicode path
            list parameters
            #str md5 = ""
            #str hash
            #str hash_algorithm
            unicode md5 = u""
            unicode hash
            unicode hash_algorithm
            object cmd_obj
            dict success_codes
            dict error_codes
            int i
            bint break_on_md5_violation
            bint break_on_hash_violation

        for i in range(0, len(cmds)):
            cmd = cmds[i]
            if type(cmd) is LuaCmd:
                continue

            if not 'cmd' in cmd:
                del cmds[i]
                continue
            success_codes = self.__handle_cmd_codes(cmd, u'success_codes')
            error_codes = self.__handle_cmd_codes(cmd, u'error_codes')
            if isinstance(cmd[u'cmd'], unicode):
                path = cmd[u'cmd']
                parameters = self.__handle_cmd_parameters(cmd)
                md5 = cmd.get(u"md5", cmd.get(u"md5sum", u""))
                hash = cmd.get(u"hash", u"")
                hash_algorithm = cmd.get(u"hash_algorithm", u"")
                break_on_md5_violation = cmd.get(u"break_on_md5_violation", True)
                break_on_hash_violation = cmd.get(u"break_on_hash_violation", True)
                cmd_obj = Cmd(path, parameters, md5, hash, hash_algorithm, break_on_md5_violation, break_on_hash_violation, self._connection_list, success_codes, error_codes, self._status_handler)
            elif isinstance(cmd[u'cmd'], LuaCmd):
                cmd_obj = cmd[u'cmd']
                cmd_obj.success_codes = cmd.get(u"success_codes", {})
                cmd_obj.error_codes = cmd.get(u"success_codes", {})
            cmds[i] = cmd_obj

    def __len__(self):
        return len(self._packages)

    def uninstall(self, package_id):
        cdef:
            list cmd_list = []
            object package
            int status = 0
            bint package_installed =  False
        package = self._packages[package_id]
        package_installed = package.installed
        self._log.log_debug(u"[holdes_mondkind] [%d] package '%s' installed: %s" % (libs.common.get_current_line_nr(), package_id, package_installed))
        if package_installed:
            self._log.log_info(u"[holdes_mondenkind] [%d] uninstalling package '%s'..." % (libs.common.get_current_line_nr(), package_id))
            status, cmd_list = package.uninstall()
            self._installed_list.remove(package_id)
            self._installed_list.save()
        else:
            status = libs.handlers.config.RET_CODE_ALREADY_REMOVED
        return status, cmd_list

    def install(self, package_id):
        cdef:
            list cmd_list = []
            object package
            int status = 0
            bint package_installed = False

        package = self._packages[package_id]
        package_installed = package.installed
        self._log.log_debug(u"[holdes_mondenkind] [%d] package '%s' installed: %s" % (libs.common.get_current_line_nr(), package_id, package_installed))

        if not package_installed:
            self._log.log_info(u"[holdes_mondenkind] [%d] installing package '%s'..." % (libs.common.get_current_line_nr(), package.package_id))
            status, cmd_list = package.install()
            if status == libs.handlers.config.RET_CODE_SUCCESS:
                if package_id in self._installed_list:
                    self._log.log_info(u"[holdes_mondenkind] [%d] Installed File inconsistent. '%s' exists in File but was not installed!" % (libs.common.get_current_line_nr(), package.package_id))
                    self._installed_list.update(package.package_id, package.version, package.rev)
                else:
                    self._log.log_info(u"[holdes_mondenkind] [%d] '%s' added to Installed File!" % (libs.common.get_current_line_nr(), package.package_id))
                    self._installed_list.append(package.package_id, package.version, package.rev)
        else:
            status = libs.handlers.config.RET_CODE_ALREADY_INSTALLED
            if not package_id in self._installed_list:
                self._installed_list.append(package.package_id, package.version, package.rev)
        self._installed_list.save()
        return status, cmd_list

    def upgrade(self, package_id):
        cdef:
            list cmd_list = []
            object package
            int status = 0
            bint package_upgrade_available = False
        self._log.log_info(u"[holdes_mondenkind] [%d] upgrading package '%s' " % (libs.common.get_current_line_nr(), package_id))
        package = self._packages[package_id]
        package_upgrade_available = package.upgrade_available
        self._log.log_info(u"[holdes_mondenkind] [%d] package '%s' upgrade available: %s" % (libs.common.get_current_line_nr(), package_id, package_upgrade_available))
        if package_upgrade_available:
            self._log.log_info(u"[holdes_mondenkind] [%d] upgrading package '%s'..." % (libs.common.get_current_line_nr(), package.package_id))
            status, cmd_list = package.install()
            if package_id in self._installed_list:
                self._log.log_warn(u"[holdes_mondenkind] [%d] Installed File inconsistent. '%s' exists in File but was not installed!" % (libs.common.get_current_line_nr(), package.package_id))
                self._installed_list.update(package.package_id, package.version, package.rev)
            else:
                self._log.log_info(u"[holdes_mondenkind] [%d] '%s' added to Installed File!" % (libs.common.get_current_line_nr(), package.package_id))
                self._installed_list.append(package.package_id, package.version, package.rev)
        else:
            status = libs.handlers.config.RET_CODE_ALREADY_INSTALLED
            if not package_id in self._installed_list:
                self._installed_list.append(package.package_id, package.version, package.rev)
        self._installed_list.save()
        return status, cmd_list

    def __iter__(self):
        return iter(self._packages)

    def iteritems(self):
        return self._packages.iteritems()

    def next(self):
        if self._index == self._packages_count:
            raise StopIteration
        package_id = self._packages[self._index]
        self._index += 1
        return package_id

    def keys(self):
        return self._packages.keys()

    def values(self):
        return self._packages.values()

    def items(self):
        return self._packages.items()

    def __getitem__(self, package_id):
        return self._packages[package_id]

    def __setitem__(self, package_id, package):
        self._packages[package_id] = package


cdef class LogList(BaseLogList):

    cdef:
        lua_State *_l

    def __init__(self, log_handler_list_path, protocol_plugins):
        BaseLogList.__init__(self, log_handler_list_path, protocol_plugins) 
        self._lua()

    def _lua(self):
        cdef:
            object kwargs = {}
            unicode u_protocol = u""
            int ret_code = 0
            const char* err_msg = ""
        global lua_log_err
        # Create Lua state variable
        self._l = luaL_newstate()
        # Load Lua libraries 
        luaL_openlibs(self._l)
        lua_push_logging(self._l)

        # Load but don't run the Lua script 
        ret_code = luaL_loadfile(self._l, self._config_path)
        if ret_code:
            # Error out if file can't be read
            #bail(L, "luaL_loadfile() failed")
            #print "%s: luaL_loadfile() failed!" % "LogList"
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            if ret_code ==  LUA_ERRFILE:
                raise IOError(2, "File not found!", self._config_path)
            return False

        # Run the loaded Lua script
        ret_code = lua_pcall(self._l, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
        if ret_code != 0:
            #print "%s: lua_pcall() failed!" % "LogList"
            return False

        lua_getglobal(self._l, 'log')
        if not lua_istable(self._l, -1):
            print >>lua_log_err, "IS NOT A TABLE!"
            lua_getglobal(self._l, 'logs')
            if not lua_istable(self._l, -1):
                print >>lua_log_err, "IS NOT A TABLE!"
                return False

        # first key
        lua_pushnil(self._l)
        t = -2
        while lua_next(self._l, t) != 0:
            # uses 'key' (at index -2) and 'value' (at index -1)
            #print ("%s - %s" % (
            #    lua_typename(self._l, lua_type(self._l, -2)),
            #    lua_typename(self._l, lua_type(self._l, -1))))
            if lua_istable(self._l, -1):
                if lua_isstring(self._l, -2):
                    u_protocol = lua_string_to_python_unicode(self._l, -2)
                    kwargs = self._lua_handle_table()
                    log_target_handler = self.protocol_plugins[u_protocol](**kwargs)
                    self._logs.append(log_target_handler)
            # removes 'value'; keeps 'key' for next iteration
            lua_pop(self._l, 1)
        return True

    def _lua_handle_table(self):
        cdef:
            object kwargs = {}
            object value
            object key
            int t = -2
        global lua_log_err
        lua_pushnil(self._l)
        while lua_next(self._l, t) != 0:
            # uses 'key' (at index -2) and 'value' (at index -1)
            #print ("%s - %s" % (
            #    lua_typename(self._l, lua_type(self._l, -2)),
            #    lua_typename(self._l, lua_type(self._l, -1))))
            if lua_isstring(self._l, -2):
                key = lua_string_to_python_unicode(self._l, -2)
            elif lua_isnumber(self._l, -2):
                key = lua_tonumber(self._l, -2)
            elif lua_isinteger(self._l, -2):
                key = lua_tointeger(self._l, -2)
            else:
                print >>lua_log_err, "Error! Not allowed type!"
                continue
            if lua_isstring(self._l, -1):
                value = lua_string_to_python_unicode(self._l, -1)
            elif lua_isnumber(self._l, -1):
                value = lua_tonumber(self._l, -1)
            elif lua_isinteger(self._l, -1):
                value = lua_tointeger(self._l, -1)
            elif lua_isboolean(self._l, -1):
                value = lua_toboolean(self._l, -1)
            else:
                print >>lua_log_err, "Error! Not allowed type!"
                continue
            kwargs[key] = value
            if lua_istable(self._l, -2):
                self._lua_handle_table()
            # removes 'value'; keeps 'key' for next iteration
            lua_pop(self._l, 1)
        return kwargs

    def _handle_logs(self, logs_node):
        for node in logs_node.childNodes:
            if node.nodeType == node.ELEMENT_NODE and node.tagName == 'log':
                if node.hasAttribute('protocol'):
                    protocol = node.getAttribute('protocol')
                else:
                    #print >>sys.stderr, "Ignoring Log Handler: %s. Protocol attribute not found!" % node
                    continue
                kwargs = {}

                if node.attributes:
                    for i in range(node.attributes.length):
                        attr = node.attributes.item(i)
                        kwargs[attr.name] = attr.value
                log_target_handler = self.protocol_plugins[protocol](**kwargs)

                self._logs.append(log_target_handler)

        self._max = len(self._logs)

    def next(self):
        return self._logs.next()

    def __iter__(self):
        return self._logs.__iter__()

    def __len__(self):
        return self._logs.__len__()

    def __getitem__(self, key):
        return self._logs[key]


cdef bint lua_push_domain_info (lua_State *L):
    cdef:
        DSROLE_PRIMARY_DOMAIN_INFO_BASIC *info
        const char* domain_name_dns = ""
        const char* domain_forest_name = ""
    get_domain_info(&info)
    if info.DomainNameDns != NULL:
        domain_name_dns = <const char*>info.DomainNameDns
    if info.DomainForestName != NULL:
        domain_forest_name = <const char*>info.DomainForestName

    # Pushes the zero-terminated string pointed to by s onto the stack. Lua makes (or reuses) an internal copy of the given string, so the memory at s can be freed or reused immediately after the function returns. The string cannot contain embedded zeros; it is assumed to end at the first zero. 
    lua_pushstring(L, domain_name_dns)
    lua_setglobal(L, "domain_name_dns")
    lua_pushstring(L, <const char*>info.DomainNameFlat)
    lua_setglobal(L, "netbios_domain_name")
    lua_pushstring(L, domain_forest_name)
    lua_setglobal(L, "domain_forest_name")


    lua_pushcfunction(L, l_get_domain_name)
    lua_setglobal(L, "get_domain_name")

    lua_pushcfunction(L, l_get_forest_name)
    lua_setglobal(L, "get_forest_name")

    lua_pushcfunction(L, l_get_netbios_domain_name)
    lua_setglobal(L, "get_netbios_domain_name")

    return True


cdef class ProfileList(BaseProfileList):

    cdef:
        lua_State *_l
        public dict _profiles

    def __init__(self, profile_list_path, log):

        BaseProfileList.__init__(self, profile_list_path, log)
        """
        self._profiles = {
            "profile_id": {
                ["package_id", "action"]
            }
        }
        """
        self._profiles = {}
        self._lua()

    def _lua(self):
        cdef:
            list profile
            unicode profile_id
            list package_list
            list profile_list = []
            list action_entry
            unicode action
            str var_name
        global lua_log_err
        global lua_log_out
        # Create Lua state variable
        self._l = luaL_newstate()
        # Load Lua libraries 
        luaL_openlibs(self._l)
        #if not os.path.isfile(self._config_path):
        #    return False
        # Load but don't run the Lua script 
        ret_code = luaL_loadfile(self._l, self._config_path)
        if ret_code:
            # Error out if file can't be read  
            #print "%s: luaL_loadfile() failed!" % "HostList"
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            if ret_code ==  LUA_ERRFILE:
                raise IOError(2, "File not found!", self._config_path)
            return False
        # Run the loaded Lua script
        ret_code = lua_pcall(self._l, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
        if ret_code != 0:
            #print "%s: lua_pcall() failed!" % "HostList"
            return False
        for var_name in ("profile_list", "profiles"):
            #print var_name
            lua_getglobal(self._l, var_name)
            if lua_isnil(self._l, -1):
                print >>lua_log_out, "no %s found" % var_name
            elif lua_istable(self._l, -1):
                break
        if lua_isnil(self._l, -1) or not lua_istable(self._l, -1):
            return False

        self._log.log_debug(u"Found table")
        if is_array(self._l, -1):
            self._log.log_debug(u"Table is an Array")

            """
            profile_list = {
                profile_id = { 
                    {"install", {"7zip"}},
                    {"uninstall", {"7zip"}}
                }
            }
            """
            get_table_as_list(self._l, -1, profile_list)
            self._log.log_debug(unicode(profile_list))
            for profile_id, profile in profile_list.items():
                package_list = []
                for action_entry in profile:
                    if not len(action_entry) == 2:
                        continue
                    action = action_entry[0]
                    if not action in ("install", "remove", "uninstall", "upgrade"):
                        continue
                    for package_id in action_entry[1]:
                        package_list.append({'action': action, 'package_id': package_id})
                    self[profile_id] = Profile(profile_id, package_list, self)

    def __len__(self):
        return self._profiles.__len__()

    def __getitem__(self, unicode key):
        """
        key = "profile_id"
        return value = ["package_id", "action"]
        """
        return self._profiles[key]

    def __setitem__(self, unicode key, list value):
        """
        value = ["package_id", "action"]
        key = "profile_id"
        """
        if len(value) == 2:
            self._profile_list[key] = value

    def __iter__(self):
        return self._profiles.__iter__()

    def next(self):
        return self._profiles.next()


cdef class HostList(BaseHostList):

    cdef:
        lua_State *_l
        public object _hosts
        public list _packages

    def __init__(self, host_list_path, log):
        BaseHostList.__init__(self, host_list_path, log)
        self._hosts = []
        self._packages = []
        self._lua()

    def _lua(self):
        cdef:
            int ret_code
            const char* err_msg
            list host_list = []
            object rule
            object action_entry
            object action
            object package_id
            #str ipv4 = ""
            #str ipv6 = ""
            unicode ipv4 = u""
            unicode ipv6 = u""
            unicode hostname = u""
            unicode workgroup = u""
            unicode domain_name = u""
            unicode forest_name = u""
            object host
            list package_list
        global lua_log_err
        global lua_log_out
        # Create Lua state variable
        self._l = luaL_newstate()
        # Load Lua libraries 
        luaL_openlibs(self._l)
        lua_push_logging(self._l)
        lua_pushlightuserdata(self._l, <PyObject*>self)
        lua_setglobal(self._l, 'p_host_list')

        lua_pushcfunction(self._l, l_install)
        lua_setglobal(self._l, "install")

        lua_pushcfunction(self._l, l_uninstall)
        lua_setglobal(self._l, "uninstall") 

        lua_pushcfunction(self._l, l_upgrade)
        lua_setglobal(self._l, "upgrade")

        lua_push_domain_info(self._l)
        lua_push_get_computer_name_ex_functions(self._l)
        lua_push_is_array(self._l)

        # Load but don't run the Lua script 
        ret_code = luaL_loadfile(self._l, self._config_path)
        if ret_code:
            # Error out if file can't be read  
            #print "%s: luaL_loadfile() failed!" % "HostList"
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            if ret_code ==  LUA_ERRFILE:
                raise IOError(2, "File not found!", self._config_path)
            return False

        # Run the loaded Lua script
        ret_code = lua_pcall(self._l, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
        if ret_code != 0:
            #print "%s: lua_pcall() failed!" % "HostList"
            return False
        lua_getglobal(self._l, "host_list")
        if lua_isnil(self._l, -1):
             print >>lua_log_out, "no host_list found"
        elif lua_istable(self._l, -1):
            self._log.log_debug(u"Found table")
            if is_array(self._l, -1):
                self._log.log_debug(u"Table is an Array")

                """
                host_list = {
                    {   workgroup = "TEST", 
                        packages = { 
                            {"install", {"7zip"}},
                            {"uninstall", {"7zip"}}
                        },
                        profiles = {
                            "only_for_test"
                        }
                    },
                    {   hostname = "[.]*", 
                        packages = { 
                            {"install", {"7zip"}},
                            {"uninstall", {"7zip"}}
                        },
                        profiles = {
                            "default"
                        }
                    }
                }
                """
                get_table_as_list(self._l, -1, host_list)
                self._log.log_debug(unicode(host_list))
                for rule in host_list:
                    package_list = []
                    profile_list = []
                    #ipv4 = rule.get("ipv4",  rule.get("ipv", ""))
                    #ipv6 = rule.get("ipv6", "")
                    ipv4 = rule.get(u"ipv4",  rule.get(u"ipv", u""))
                    ipv6 = rule.get(u"ipv6", u"")
                    hostname = rule.get(u"hostname", u"")
                    workgroup = rule.get(u"workgroup", u"")
                    domain_name = rule.get(u"domainname", u"")
                    forest_name = rule.get(u"forestname", u"")
                    if u"packages" in rule:
                        for action_entry in rule[u'packages']:
                            if not len(action_entry) == 2:
                                continue
                            action = action_entry[0]
                            if not action in (u"install", u"remove", u"uninstall", u"upgrade"):
                                continue
                            for package_id in action_entry[1]:
                                package_list.append({'action': action, 'package_id': package_id})
                    if u"profiles" in rule:
                        profile_list = rule[u"profiles"]
                    host = Host(ipv4, ipv6, hostname, workgroup, domain_name, forest_name, package_list, profile_list)
                    self.append(host)

    def next(self):
        return self._hosts.next()

    def __iter__(self):
        return self._hosts.__iter__()

    def __len__(self):
        return self._hosts.__len__()

    def __getitem__(self, key):
        return self._hosts[key]

    def append(self, obj):
        #print "appending %s" % obj
        self._hosts.append(obj)


cdef class InstallList(BaseInstallList):

    cdef:
        lua_State *_l

    def __init__(self, install_list_path, connection_list, log):
        BaseInstallList.__init__(self, install_list_path, connection_list, log)
        """
        install_list = {
            packages = {
                {"install", {"7zip"}},
                {"uninstall", {"7zip"}}
            },
            profiles = {
                "default"
            }
        }
        """
        self._install_list = []
        self._lua()

    def _lua(self):
        cdef:
            int ret_code
            unicode action
            list install_list = []
            list action_entry
            unicode package_id
            const char* err_msg
            #list profiles
            list packages
        global lua_log_err
        # Create Lua state variable
        self._l = luaL_newstate()
        # Load Lua libraries 
        luaL_openlibs(self._l)
        lua_push_logging(self._l)

        # Load but don't run the Lua script 
        ret_code = luaL_loadfile(self._l, self._config_path)
        if ret_code:
            #print "%s: luaL_loadfile() failed!" % "InstallList"
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            if ret_code ==  LUA_ERRFILE:
                raise IOError(2, "File not found!", self._config_path)
            return False

        # Run the loaded Lua script
        ret_code = lua_pcall(self._l, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
        if ret_code != 0:
            #print "%s: lua_pcall() failed!" % "InstallList"
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            return False

        lua_getglobal(self._l, "install_list")
        if lua_isnil(self._l, -1):
             print >>lua_log_out, "no install_list found"
        elif lua_istable(self._l, -1):
            self._log.log_debug(u"Found table")
            if is_array(self._l, -1):
                self._log.log_debug(u"Table is an Array")
                """
                install_list = {
                    packages = {
                        {"install", {"7zip"}},
                        {"uninstall", {"7zip"}}
                    },
                    profiles = {
                        "default"
                    }
                }
                """
                get_table_as_list(
                    self._l,
                    -1,
                    install_list,
                    (
                        None,
                        {
                            "packages": 
                            {
                                DICT:
                                (
                                    {
                                        ARRAY:
                                        (
                                            None,
                                            {
                                                0: 
                                                {
                                                    STRING: ""
                                                },
                                                1: 
                                                {
                                                    ARRAY:
                                                    (
                                                        {
                                                            STRING: ""
                                                        },
                                                        {}
                                                    )
                                                }
                                            }
                                        )
                                    }
                                )
                            },
                            "profiles":
                            {   ARRAY:
                                (
                                    {
                                        STRING: ""
                                    }
                                )
                            }
                        }
                    )
                )
                self._log.log_debug(unicode(install_list))
                if u"profiles" in install_list:
                    self._profile_list = install_list[u"profiles"]
                if u"packages" in install_list:
                    packages = install_list[u"packages"]
                    for action_entry in packages:
                        if not len(action_entry) == 2:
                            continue
                        action = action_entry[0]
                        if not action in (u"install", u"remove", u"uninstall", u"upgrade"):
                            continue
                        for package_id in action_entry[1]:
                            self._install_list.append({'action': action, 'package_id': package_id})
    def next(self):
        return self._install_list.next()

    def __iter__(self):
        return self._install_list.__iter__()

    def __len__(self):
        return self._install_list.__len__()


cdef class ConnectionList(BaseConnectionList):

    cdef:
        lua_State *_l

    def __init__(self, connection_list_path, protocol_plugins, log, status_handler):
        BaseConnectionList.__init__(self, connection_list_path, protocol_plugins, log, status_handler)
        self._lua()

    def _lua(self):
        cdef:
            int ret_code
            const char* err_msg
        global lua_log_err
        # Create Lua state variable
        self._l = luaL_newstate()
        # Load Lua libraries 
        luaL_openlibs(self._l)
        lua_push_logging(self._l)
        #print self._config_path
        # Load but don't run the Lua script 
        ret_code = luaL_loadfile(self._l, self._config_path)
        if ret_code:
            # Error out if file can't be read  
            #bail(L, "luaL_loadfile() failed")
            #print "%s: luaL_loadfile() failed!" % "ConnectionList"
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
            if ret_code ==  LUA_ERRFILE:
                raise IOError(2, "File not found!", self._config_path)
            return False

        # Run the loaded Lua script
        ret_code = lua_pcall(self._l, 0, 0, 0)
        if ret_code == 2:
            err_msg = lua_tostring(self._l, -1)
            #print >>sys.stderr, err_msg
            print >>lua_log_err, err_msg
        if ret_code != 0:
            print >>lua_log_err, "%s: lua_pcall() failed!" % "ConnectionList"    
            return False
        self._lua_handle_table()

    def _lua_handle_connection_table(self):
        cdef:
            object kwargs = {}
            object value
            object key
            int t = -2
        global lua_log_err
        lua_pushnil(self._l)
        while lua_next(self._l, t) != 0:
            # uses 'key' (at index -2) and 'value' (at index -1)
            #print ("%s - %s" % (
            #    lua_typename(self._l, lua_type(self._l, -2)),
            #    lua_typename(self._l, lua_type(self._l, -1))))
            if lua_isstring(self._l, -2):
                key = lua_string_to_python_unicode(self._l, -2)
            elif lua_isnumber(self._l, -2):
                key = lua_tonumber(self._l, -2)
            elif lua_isinteger(self._l, -2):
                key = lua_tointeger(self._l, -2)
            else:
                print >>lua_log_err, "Error! Not allowed type!"
                continue
            if lua_isstring(self._l, -1):
                value = lua_string_to_python_unicode(self._l, -1)
            elif lua_isnumber(self._l, -1):
                value = lua_tonumber(self._l, -1)
            elif lua_isinteger(self._l, -1):
                value = lua_tointeger(self._l, -1)
            elif lua_isboolean(self._l, -1):
                value = lua_toboolean(self._l, -1)
            else:
                print >>lua_log_err, "Error! Not allowed type!"
                continue
            #print key, value
            kwargs[key] = value
            if lua_istable(self._l, -2):
                self._lua_handle_table()
            # removes 'value'; keeps 'key' for next iteration
            lua_pop(self._l, 1)
        return kwargs

    def _lua_handle_table(self):
        cdef:
            object kwargs = {}
            object value
            object key
            unicode username = u""
            unicode password = u""
            unicode url = u""
            unicode protocol = u""
            object r
            int t = -2
        global lua_log_err
        lua_getglobal(self._l, "connections")
        lua_pushnil(self._l)
        while lua_next(self._l, t) != 0:
            # uses 'key' (at index -2) and 'value' (at index -1)
            #print ("%s - %s" % (
            #    lua_typename(self._l, lua_type(self._l, -2)),
            #    lua_typename(self._l, lua_type(self._l, -1))))
            if lua_isinteger(self._l, -2):
                key = lua_tointeger(self._l, -2)
            else:
                print >>lua_log_err, "Error! Not allowed type!"
                continue
            if lua_istable(self._l, -1):
                kwargs = self._lua_handle_connection_table()
                if 'url' in kwargs:
                    url = kwargs['url']
                    if 'protocol' in kwargs:
                        protocol = kwargs['protocol']
                    else:
                        r = urlparse.urlsplit(url)
                        protocol = r[0]
                    protocol_handler = self.protocol_plugins[protocol](self._log, self._status_handler, **kwargs)
                    self._connections[url] = {'protocol': protocol, 'protocol_handler': protocol_handler, 'username': username, 'password': password}
            else:
                print >>lua_log_err, "Error! %s is not allowed as key!" % lua_typename(self._l, lua_type(self._l, -2))
                continue
            if lua_istable(self._l, -2):
                self._lua_handle_table()
            # removes 'value'; keeps 'key' for next iteration
            lua_pop(self._l, 1)

    def next(self):
        return self._connections.next()

    def keys(self):
        return self._connections.keys()

    def items(self):
        return self._connections.items()

    def values(self):
        return self._connections.values()

    def __iter__(self):
        return self._connections.__iter__()

    def __len__(self):
        return self._connections.__len__()

    def __getitem__(self, key):
        return self._connections[key]


class InstalledList(libs.handlers.config.InstalledList):

    def __init__(self, installed_list_path, log, **kwargs):
        libs.handlers.config.InstalledList.__init__(self, installed_list_path, log)
        db_path = kwargs.get("db_path", "installed_packages.db")
        self._conn = sqlite3.connect(db_path)
        # default sqlite cursor
        self._c = self._conn.cursor()
        # sqlite cursor for iteration
        self._i_c = self._conn.cursor()
        # Create table
        self._c.execute('''CREATE TABLE IF NOT EXISTS packages (package_id TEXT PRIMARY KEY, version TEXT, rev TEXT, date TEXT);''')

    def __iter__(self):
        query = """SELECT package_id FROM packages;""" 
        self._i_c.execute(query)
        return self

    def __len__(self):
        query = "SELECT Count(*) FROM packages;"
        self._c.execute(query)
        return self._c.fetchone()[0]

    def __getitem__(self, package_id):
        """returns (version, rev, date)"""
        query = """SELECT version, rev, date FROM packages WHERE package_id="%s";""" % package_id 
        self._c.execute(query)
        return self._c.fetchone()

    def next(self):
        """returns package_id"""
        row = self._i_c.fetchone()
        if row is None:
            raise StopIteration() 
        return row[0]

    def remove(self, package_id):
        query = """DELETE FROM packages WHERE package_id = "%s";""" % package_id
        try:
            self._c.execute(query)
        except sqlite3.OperationalError:
            return False
        return True

    def _insert_or_replace(self, package_id, version, rev = 0):
        date = ""
        query = """INSERT OR REPLACE INTO packages (package_id, version, rev, date) VALUES ("%s", "%s", "%s", "%s");""" % (package_id, version, rev, date)
        #print query
        try:
            self._c.execute(query)
        except sqlite3.OperationalError:
            return False
        return True

    def append(self, package_id, version, rev):
        return self._insert_or_replace(package_id, version, rev)

    def update(self, package_id, version, rev):
        return self._insert_or_replace(package_id, version, rev)

    def save(self):
        self._conn.commit()

    def __exit__(self, type, value, traceback):
        self.save()
        self._c.close()
        self._conn.close()



def register_handler(plugins):
    global lua_log_err
    global lua_log_out
    global lua_log_debug
    log_path = "log\\lua\\"
    if not os.path.exists(log_path):
        os.makedirs(log_path)
    lua_log_err = open('%slua.err' % log_path, 'a')
    lua_log_out = open('%slua.out' % log_path, 'a')
    lua_log_debug = open('%slua.debug' % log_path, 'a')
    print >>lua_log_out, "registering module"
    current_module = sys.modules[__name__]
    plugins[file_extension] = current_module
    #print "registering config plugin %s for %s config files" % (__name__, file_extension)
    return (file_extension, current_module)