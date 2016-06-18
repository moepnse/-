# -*- coding: utf-8 -*-

# standard library imports
import hashlib
import time
import re

# third party imports

# application/library imports
import libs.common

# standard library cimports

# third party cimports

# application/library cimports
from c_windows_data_types cimport WORD, DWORD
from c_windows cimport HIWORD, LOWORD


RETURN_PACKAGE = 0
RETURN_ID = 1

# Return Code Types
RET_CODE_UNKNOWN = 0
RET_CODE_SUCCESS = 1
RET_CODE_ERROR = 2
RET_CODE_ALREADY_INSTALLED = 3
RET_CODE_ALREADY_REMOVED = 4
RET_CODE_PACKAGE_NOT_FOUND = 5


class ChecksumViolation(Exception):
    def __init__(self, path):
        self._path = path


cdef class StatusHandler:

    def __cinit__(self):
        self._status_id_count = 0

    def __init__(self):
        pass

    #def unsigned int set_status(self, unsigned int source_id, unsigned char status_type, unsigned int status_id, unicode description):
    def set_status(self, int source_id, int status_type, unicode status_source_name, int status_id, unicode description):
        self._status_id_count += 1
        return self._status_id_count

    #def update_status(self, unsigned int status_id, unsigned char status_type, unsigned int status_id, unicode description):
    def update_status(self, int old_status_id, int status_type, int status_id, unicode description):
        pass


cdef class BaseCmd:
    #def __init__(self, str md5sum, str hash, str hash_algorithm, object status_handler):
    def __init__(self, unicode md5sum, unicode hash, unicode hash_algorithm, bint break_on_md5_violation, bint break_on_hash_violation, object status_handler):

        self._md5sum = md5sum
        self._hash = hash
        self._hash_algorithm = hash_algorithm
        self._status_handler = status_handler
        self.break_on_md5_violation
        self.break_on_hash_violation

    def open(self, path, mode):
        self._get_connection_handler()
        return self._connection_handler.open(path, mode)

    def check_hash(self):
        hash_algorithm = hashlib.new(self._hash_algorithm)
        f = self.open(self._path, 'rb')
        while True:
            data = f.read(hash_algorithm.block_size)
            if not data:
                break
            hash_algorithm.update(data)
        return self._hash == hash_algorithm.hexdigest()

    def hash_available(self):
        return self._hash != "" and self._hash is not None and self._hash_algorithm in hashlib.algorithms

    # legacy
    def check_md5(self):
        md5 = hashlib.md5()
        f = self.open(self._path, 'rb')
        while True:
            data = f.read(md5.block_size)
            if not data:
                break
            md5.update(data)
        print self._md5sum, md5.hexdigest()
        return self._md5sum == md5.hexdigest()

    def md5_available(self):
        return self._md5sum != "" and self._md5sum is not None

    def _get_connection_handler(self, unicode path=None):
        cdef:
            object url = u""
        if self._connection_handler is not None:
            return True
        for url in self._connection_handlers:
            connection_handler = self._connection_handlers[url]['protocol_handler']
            if path is None:
                path = self._path
            if connection_handler.is_responsible(path):
                self._connection_handler = connection_handler
                return True
        if self._status_handler is not None:
            self._status_handler.set_status(ss__cmd, st__warn, u"cmd_parameter_value", 0, u"No Connection Handler available!")
        return False

    property path:

        "A doc string can go here."

        def __get__(self):
            cdef:
                unicode path = u""
            self._get_connection_handler()
            path = self._connection_handler.get_path(self._path)
            return (u'"%s"' if ' ' in path else u'%s') % path

        def __set__(self, path):
            self._path = path


class CmdParameterValue(BaseCmd):

    #def __init__(self, unicode value, str md5sum, str hash, str hash_algorithm, bint allow_connection_handler, object connection_handlers, object status_handler):
    def __init__(self, unicode value, unicode md5sum, unicode hash, unicode hash_algorithm, bint break_on_md5_violation, bint break_on_hash_violation, bint allow_connection_handler, object connection_handlers, object status_handler):

        BaseCmd.__init__(self, md5sum, hash, hash_algorithm, break_on_md5_violation, break_on_hash_violation, status_handler)
        self._connection_handlers = connection_handlers
        self._allow_connection_handler = allow_connection_handler 
        self.value = value

    @property
    def value(self):
        cdef:
            unicode value = u""
        if self._allow_connection_handler:
            self._get_connection_handler(self._value)
            value = self._connection_handler.get_path(self._value)
        else:
            value = self._value
        return (u'"%s"' if ' ' in value else u'%s') % value

    @value.setter
    def value(self, unicode value):
        self._value = value
        #if self._allow_connection_handler:
        #    self._get_connection_handler()

    def __repr__(self):
        return self._value

    def __unicode__(self):
        return self.value


class CmdParameter(object):

    def __init__(self, unicode argument, object values, object connection_handlers, object status_handler):
        """
        u"values": [
            {   u"value": "test", 
                u"allow_connection_handler": False
            }
        ],
        """
        cdef:
            object value
            str md5sum
            str hash,
            str hash_algorithm
            bint break_on_md5_violation
            bint break_on_hash_violation,


        self._argument = argument
        self._values = []
        self._connection_handlers = connection_handlers
        self._status_handler = status_handler
        for value in values:
            #self._values.append(CmdParameterValue(value.value, value.allow_connection_handler, connection_handlers))
            if isinstance(value, dict):
                if not 'value' in value:
                    #print "Error: key 'value' is missing!"
                    continue
                if not 'allow_connection_handler' in value:
                    #print "Error: key 'allow_connection_handler' is missing!"
                    continue
                md5sum = value.get("md5sum", values.get("md5sum", ""))
                hash = value.get("hash", "")
                hash_algorithm = value.get("hash_algorithm", "")
                break_on_md5_violation = value.get("break_on_md5_violation", True)
                break_on_hash_violation = value.get("break_on_hash_violation", True)
                self._values.append(CmdParameterValue(value['value'], value['allow_connection_handler'], md5sum, hash, hash_algorithm,  break_on_md5_violation, break_on_hash_violation, connection_handlers, status_handler))
            elif isinstance(value, list):
                if len(value) == 1:
                    # appending allow_connection_handler boolean value"
                    value.append(False)
                if len(value) == 2:
                    self._values.append(CmdParameterValue(value[0], u"", u"", u"", True, True, value[1], connection_handlers, status_handler))
                elif len(value) == 5:
                    self._values.append(CmdParameterValue(value[0], value[1], value[2], value[3], True, True, value[4], connection_handlers, status_handler))
                elif len(value) == 7:
                    self._values.append(CmdParameterValue(value[0], value[1], value[2], value[3], value[4], value[5], value[6], connection_handlers, status_handler))
                else:
                    #print "Error!"
                    continue
            elif isinstance(value, unicode):
                self._values.append(CmdParameterValue(value, md5sum, hash, hash_algorithm, False, connection_handlers, status_handler))
            else:
                pass
                #print type(value)

    def __repr__(self):
        cdef:
            unicode u_values
            object values
        u_values =  u' '.join([repr(value) for value in self._values])
        if self._argument == '':
            return u_values
        else:
            if self._argument.endswith("="):
                return "%s%s" % (self._argument, u_values)
            else:
                return "%s %s"  % (self._argument, u_values)

    def __unicode__(self):
        cdef:
            unicode u_values
            object values
        u_values =  u' '.join([unicode(value) for value in self._values])
        if self._argument == '':
            return u_values
        else:
            if self._argument.endswith("="):
                return "%s%s" % (self._argument, u_values)
            else:
                return "%s %s"  % (self._argument, u_values)
        #return  u' '.join([unicode(value) for value in self._values]) if self._argument == '' else u'%s %s' % (self._argument, u' '.join([unicode(value) for value in self._values]))


cdef class Cmd(BaseCmd):

    def __init__(self, path, parameters, md5sum, hash, hash_algorithm, bint break_on_md5_violation, bint break_on_hash_violation, connection_handlers, success_codes, error_codes, status_handler):
        """
        parameters = [
            {   u"argument": u"/S",
                u"values": [
                    {   u"value": "test", 
                        u"allow_connection_handler": False
                    }
                ],
                u"allow_connection_handler": False
            }
        ]
        """
        BaseCmd.__init__(self, md5sum, hash, hash_algorithm, break_on_md5_violation, break_on_hash_violation, status_handler)
        path = path.strip(' ')
        if path.startswith('"') and path.endswith('"'):
            path = path.strip('"')
        self._path = path
        self._parameters = []
        self._connection_handlers = connection_handlers
        self._connection_handler = None
        """
        success_codes = {
            0: "The operation completed successfully."
        }
        """
        self._success_codes = success_codes
        """
        error_codes = {
            1: "Incorrect function.",
            2:  "The system cannot find the file specified."
            3: "The system cannot find the path specified."
        }
        """
        self._error_codes = error_codes
        self._ret_code_type = RET_CODE_UNKNOWN

        for parameter in parameters:
            if not 'argument' in parameter:
                #print "argument is missing!"
                continue
            if not 'values' in parameter:
                #print "values are missing!"
                continue
            self._parameters.append(CmdParameter(parameter['argument'], parameter['values'], connection_handlers, status_handler))

    @property
    def ret_code_type(self):
        return self._ret_code_type

    @ret_code_type.setter
    def ret_code_type(self, ret_code_type):
        self._ret_code_type = ret_code_type
        #self._ret_code_description =  '' if ret_code_type == RET_CODE_UNKNOWN else (self._success_codes if ret_code_type == RET_CODE_SUCCESS else self._error_codes)[self.ret_code]

    @property
    def ret_code_description(self):
        return self._ret_code_description

    @property
    def ret_code(self):
        return self._ret_code

    # WON'T WORK IN CDEF CLASSES:    
    #@property
    #def success_codes(self):
    #    return self._success_codes

    #@success_codes.setter
    #def success_codes(self, success_codes):
    #    self._success_codes = success_codes

    property success_codes:

        "A doc string can go here."

        def __get__(self):
            return self._success_codes

        def __set__(self, success_codes):
            self._success_codes = success_codes

    # WON'T WORK IN CDEF CLASSES:    
    #@property
    #def error_codes(self):
    #    return self._error_codes

    #@error_codes.setter
    #def error_codes(self, error_codes):
    #    self._error_codes = error_codes

    property error_codes:

        "A doc string can go here."

        def __get__(self):
            return self._error_codes

        def __set__(self, error_codes):
            self._error_codes = error_codes

    def _get_cmd(self, path, parameters=[]):
        cdef:
            unicode placeholder = u'"%s" %s'
        parameters = self._parameters + parameters
        if path.startswith('"') and path.endswith('"'):
            placeholder = u'%s %s'
        return placeholder % (path, ' '.join([str(parameter) for parameter in parameters]))

    cdef unsigned long _execute(self, object parameters=[]):
        cdef:
            unsigned long ret_code = 0
        self._get_connection_handler()
        if self._connection_handler is None:
            #print "NO CONNECTION HANDLER"
            return RET_CODE_ERROR
        ret_code = self._connection_handler.execute(self._get_cmd(self._path, parameters))
        if ret_code in self._error_codes:
            self._ret_code_type = RET_CODE_ERROR
            self._ret_code_description = self._error_codes[ret_code]
        elif ret_code in self._success_codes:
            self._ret_code_type = RET_CODE_SUCCESS
            self._ret_code_description = self._success_codes[ret_code]
        else:
            self._ret_code_type = RET_CODE_UNKNOWN
            self._ret_code_description = ''
        return ret_code

    def execute(self, object parameters=[]):
        return self._execute(parameters)

    def __iter__(self):
        return self._parameters

    def remove(self, value):
        self._parameters.remove(value)

    def __repr__(self):
        cdef:
            unicode placeholder = u'"%s" %s'
        if self._path.startswith('"') and self._path.endswith('"'):
            placeholder = u'%s %s'
        return placeholder % (self._path, ' '.join([repr(parameter) for parameter in self._parameters]))

    def __unicode__(self):
        self._get_connection_handler()
        return self._get_cmd(self._connection_handler.get_path(self._path))


class RetCodes(object):

    def __init__(self):
        pass


cdef class BaseVersion:

    def __init__(self):
        self._config_version = 1
        self._api_version = 1

    cdef list _get_version(self, WORD version):
        return (HIWORD(version), LOWORD(version))

    def get_config_version(self):
        return self._get_version(self._config_version)

    def get_api_version(self):
        return self._get_version(self._api_version)

    cdef bint _get_flag(self, unsigned char offset):
        return (1 << offset) & self._flags != 0


cdef class Base(BaseVersion):

    def __init__(self, config_path, connection_list=None, log=None):
        self._log = log
        self._connection_list = connection_list
        if connection_list is not None:
            for url in self._connection_list:
                connection = self._connection_list[url]
                protocol_handler = connection['protocol_handler']
                if protocol_handler.is_responsible(config_path):
                    config_path = protocol_handler.get_path(config_path)
                    break
        self._config_path = config_path



cdef class Package(BaseVersion):

    def __init__(self, package_id, name, version, rev, installed, install_cmds, upgrade_available, upgrade_cmds, uninstall_cmds, description, keywords, icon, icon_type, connection_list, dependencies_list, log, object status_handler):
        self.package_id = package_id
        self.name = name
        self.version = version
        self.rev = rev
        self._installed = installed
        self.install_cmds = install_cmds
        self._upgrade_available = upgrade_available
        self.upgrade_cmds = upgrade_cmds
        self.uninstall_cmds = uninstall_cmds
        self._description = description
        self._keywords = keywords
        self._icon = icon
        self._icon_type = icon_type
        self._connection_list = connection_list
        self.dependencies_list = dependencies_list
        self._log = log
        self._status_handler = status_handler

    def _execute(self, unicode cmd):
        cdef:
            object url
            object connection
            object protocol_handler
        for url in self._connection_list:
            connection = self._connection_list[url]
            protocol_handler = connection['protocol_handler']
            if protocol_handler.is_responsible(cmd):
                self._log.log_debug(u'[base] [%d] %s - protocol handler %s is resposible for cmd: %s' % (libs.common.get_current_line_nr(), self.name, protocol_handler._url_prefix, cmd))
                return protocol_handler.execute(cmd)
        print "NO CONNECTION_HANDLER"   

    def _execute_cmds(self, cmds):
        cdef:
            int status = RET_CODE_SUCCESS
            unsigned long cmd_ret_code = 0
            unicode cmd_ret_code_description
            unsigned long cmd_status_code = 0
            unicode cmd_status_code_description
            list cmd_list = []
            object cmd
            bint b_execute
        for cmd in cmds:
            b_execute = True
            #cmd_ret_code = self._execute(cmd)
            if cmd.md5_available():
                if not cmd.check_md5():
                    self._log.log_err(u'[base] [%d] Checksum violation!' % (libs.common.get_current_line_nr()))
                    if not self._status_handler is None:
                        status_id = self._status_handler.set_status(ss__connection_handler, st__error, u"Package", 1, u"MD5-Violation \"%s\"." % (cmd))
                    if cmd.break_on_md5_violation:
                        raise ChecksumViolation(cmd.path)
                    status = RET_CODE_ERROR
                    b_execute = False
            if cmd.hash_available():
                if not cmd.check_hash():
                    if not self._status_handler is None:
                        status_id = self._status_handler.set_status(ss__connection_handler, st__error, u"Package", 1, u"Hash-Violation \"%s\"." % (cmd))
                    self._log.log_err(u'[base] [%d] Checksum violation!' % (libs.common.get_current_line_nr()))
                    if cmd.break_on_hash_violation:
                        raise ChecksumViolation(cmd.path)
                    status = RET_CODE_ERROR
                    b_execute = False
            if b_execute:
                try:
                    cmd_ret_code = cmd.execute()
                except libs.handlers.protocol.FileNotFound, e:
                    self._log.log_err(u'[base] [%d] File not found: %s' % (libs.common.get_current_line_nr(), e))
                    status = RET_CODE_ERROR
                #except:
                #    status = RET_CODE_ERROR
                #    continue
                ret_code_type = cmd.ret_code_type
                if ret_code_type == RET_CODE_SUCCESS and cmd_ret_code in cmd.success_codes:
                    cmd_ret_code_description = cmd.success_codes[cmd_ret_code]
                elif ret_code_type == RET_CODE_ERROR and cmd_ret_code in cmd.error_codes:
                    cmd_ret_code_description = cmd.error_codes[cmd_ret_code]
                else:
                    cmd_ret_code_description = u""
                cmd_list.append((unicode(cmd), cmd_ret_code, cmd_ret_code_description))
                ret_code_type = cmd.ret_code_type
                self._log.log_debug(u'[base] [%d] %s - cmd %s status: %s, return code: %s' % (libs.common.get_current_line_nr(), self.name, cmd, status, cmd_ret_code))
                if status in (RET_CODE_ERROR, RET_CODE_UNKNOWN):
                    continue
                status = ret_code_type
        return status, cmd_list

    def install(self, force=False):
        return self._execute_cmds(self.install_cmds)

    def upgrade(self):
        return self._execute_cmds(self.upgrade_cmds)

    def uninstall(self):
        return self._execute_cmds(self.uninstall_cmds)

    @property
    def installed(self):
        return self._installed

    @installed.setter
    def installed(self, value):
        self._installed = value

    @property
    def upgrade_available(self):
        return self._upgrade_available

    @upgrade_available.setter
    def upgrade_available(self, value):
        self._upgrade_available = value

    @property
    def dependencies(self):
        return self.dependencies_list

    @property
    def description(self):
        return self._description

    @property
    def keywords(self):
        return self._keywords

    @property
    def icon(self):
        return self._icon

    @property
    def icon_type(self):
        return self._icon_type


cdef class Settings(Base):

    def __init__(self, settings_path):
        self._settings_path = settings_path

    @property
    def path(self):
        return self._settings_path

    @property
    def installed_list(self):
        return self._installed_list

    @installed_list.setter
    def installed_list(self, value):
        self._installed_list = value

    @property
    def install_list(self):
        return self._install_list

    @install_list.setter
    def install_list(self, value):
        self._install_list = value

    @property
    def package_list(self):
        return self._package_list

    @package_list.setter
    def package_list(self, value):
        self._package_list = value

    @property
    def package_lists(self):
        return self._package_lists

    @package_lists.setter
    def package_lists(self, value):
        self._package_lists = value

    @property
    def profile_list(self):
        return self._profile_list

    @profile_list.setter
    def profile_list(self, value):
        self._profile_list = value

    @property
    def connection_list(self):
        return self._connection_list

    @connection_list.setter
    def connection_list(self, value):
        self._connection_list = value

    @property
    def host_list(self):
        return self._host_list

    @host_list.setter
    def host_list(self, value):
        self._host_list = value

    @property
    def log_list(self):
        return self._log_list

    @log_list.setter
    def log_list(self, value):
        self._log_list = value

    @property
    def target_source(self):
        return self._target_source

    @target_source.setter
    def target_source(self, value):
        self._target_source = value

    @property
    def status_gui_cmd(self):
        return self._status_gui_cmd

    @status_gui_cmd.setter
    def status_gui_cmd(self, value):
        self._status_gui_cmd = value

    @property
    def interval(self):
        return self._interval

    @property
    def run(self):
        return self._run

    @property
    def display_target(self):
        return self._display_target

    def save(self):
        pass


class InstalledList(Base):

    def __init__(self, installed_path, log):
        Base.__init__(self, installed_path, log=log)
        # for legacy reason
        self._installed_list_path = self._config_path


cdef class Host(BaseVersion):

    #def __init__(self, str ip4, str ipv6, unicode hostname, unicode workgroup, unicode domain_name, unicode forest_name, list packages, list profiles):
    def __init__(self, unicode ip4, unicode ipv6, unicode hostname, unicode workgroup, unicode domain_name, unicode forest_name, list packages, list profiles):
        self._ipv4 = ip4
        self._ipv6 = ipv6
        self._hostname = hostname
        self._workgroup = workgroup
        self._domain_name = domain_name
        self._forest_name = forest_name
        """
        self._packages = [
            {   "package_id": "ff_esr",
                "action": "install"
            }
        ]
        """
        self._packages = packages
        self._profiles = profiles

    #cpdef bint ipv4_is(self, str ip):
    cpdef bint ipv4_is(self, unicode ip):
        """ip parameter could be a string, or a regex pattern"""
        #result = re.match(pattern, string)
        if not ip or not self._ipv4:
            return False
        return False if re.match(self._ipv4,ip) is None else True

    #cpdef bint ipv6_is(self, str ip):
    cpdef bint ipv6_is(self, unicode ip):
        """ip parameter could be a string, or a regex pattern"""
        #result = re.match(pattern, string)
        if not ip or not self._ipv6:
            return False
        return False if re.match(self._ipv6, ip) is None else True

    cpdef bint hostname_is(self, unicode hostname):
        """hostname parameter could be a unicode string, or a regex pattern"""
        #result = re.match(pattern, string)
        if not hostname or not self._hostname:
            return False
        return False if re.match(self._hostname, hostname) is None else True

    cpdef bint workgroup_is(self, unicode workgroup):
        """workgroup parameter could be a unicode string, or a regex pattern"""
        if not workgroup or not self._workgroup:
            return False
        return False if re.match(self._workgroup, workgroup) is None else True

    cpdef bint domain_name_is(self, unicode domain_name):
        """domain_name parameter could be a unicode string, or a regex pattern"""
        if not domain_name or not self._domain_name:
            return False
        return False if re.match(self._domain_name, domain_name) is None else True

    cpdef bint forest_name_is(self, unicode forest_name):
        """forest_name parameter could be a unicode string, or a regex pattern"""
        if not forest_name or not self._forest_name:
            return False
        return False if re.match(self._forest_name, forest_name) is None else True

    def next(self):
        return self._all_packages.next()

    def __iter__(self):
        self._all_packages = []
        for package in self._packages:
            self._all_packages.append(package)
        for profile in self._profiles:
            for package in profile:
                self._all_packages.append(package)
        self._len = len(self._all_packages)
        return iter(self._all_packages)

    def __len__(self):
        return self._len

    def __getitem__(self, key):
        return self._packages[key]

    def append(self, obj):
        self._packages.append(obj)

    cpdef get_packages(self):
        return self._packages

    cpdef get_profiles(self):
        return self._profiles

    @property
    def packages(self):
        return self._packages

    @property
    def profiles(self):
        return self._profiles


cdef class HostList(Base):

    def __init__(self, host_list_path, log):
        Base.__init__(self, host_list_path, log=log)
        # for legacy reason
        self._host_list_path = self._config_path


cdef class Profile(BaseVersion):

    def __init__(self, unicode id, list packages, object profile_list):
        self._id = id
        self._packages = packages
        self._profile_list = profile_list

    @property
    def packages(self):
        return self._packages

    @packages.setter
    def packages(self, value):
        self._packages = value

    @property
    def id(self):
        return self._id

    @id.setter
    def packages(self, value):
        self._id = value

    def __len__(self):
        return self._packages.__len__()

    def __iter__(self):
        return self._packages.__iter__()

    def next(self):
        return self._packages.next()


cdef class ProfileList(Base):

    def __init__(self, profile_list_path, log):
        Base.__init__(self, profile_list_path, log=log)
        # for legacy reason
        self._profile_list_path = self._config_path
        self._profiles = {}

    def __getitem__(self, key):
        return self._profiles[key]


cdef class InstallList(Base):

    def __init__(self, install_list_path, connection_list, log):
        Base.__init__(self, install_list_path, connection_list, log)
        # for legacy reason
        self._install_list_path = self._config_path

    cpdef get_packages(self):
        return self._packages

    cpdef get_profiles(self):
        return self._profiles

    @property
    def packages(self):
        return self._packages

    @property
    def profiles(self):
        return self._profiles


cdef class PackageList(Base):

    def __init__(self, package_list_path, connection_list, installed_list, log, status_handler):
        Base.__init__(self, package_list_path, connection_list, log)
        self._installed_list = installed_list
        # for legacy reason
        self._package_list_path = self._config_path
        self._status_handler = status_handler


cdef class ConnectionList:

    def __init__(self, connection_list_path, protocol_plugins, log, status_handler):
        self._log = log
        self._connection_list_path = connection_list_path
        self._config_path = connection_list_path
        self._connections = {}
        self.protocol_plugins = protocol_plugins
        self._status_handler = status_handler


cdef class LogList(BaseVersion):

    def __init__(self, _log_list_path, protocol_plugins):
        self._log_list_path = _log_list_path
        self._config_path = _log_list_path
        self._logs = []
        self.protocol_plugins = protocol_plugins