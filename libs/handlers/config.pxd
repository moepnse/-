from c_windows_data_types cimport WORD, DWORD


cdef:
    enum CMD_STATUS_CODES:
        cs__file_not_found,
        cs__md5_violation,
        cs__hash_violation

    enum STATUS_SOURCE:
        ss__cmd,
        ss__connection_handler,
        ss__protocol

    enum STATUS_TYPES:
        st__info,
        st__success,
        st__warn
        st__error

    enum Flags:
        install_list_supported
        host_list_supported


cdef class StatusHandler:
    cdef:
        public unsigned int _status_id_count


cdef class BaseCmd:
    cdef:
        #public str md5sum
        #public str hash
        #public str hash_algorithm
        public unicode _md5sum
        public unicode _hash
        public unicode _hash_algorithm
        public object _status_handler
        public bint break_on_md5_violation
        public bint break_on_hash_violation


cdef class Cmd(BaseCmd):
    cdef: 
        public object _path
        public object _parameters
        public object _connection_handlers
        public object _connection_handler
        public object _success_codes
        public object _error_codes
        public object _ret_code_type
        public object _ret_code_description

    cdef long long _execute(self, object parameters=*) except *


cdef class BaseVersion:
    cdef:
        WORD _config_version
        WORD _api_version
        DWORD _flags

    cdef list _get_version(self, WORD version)

    cdef bint _get_flag(self, unsigned char offset)


cdef class Base(BaseVersion):
    cdef:
        public object _log
        public object _connection_list
        public object _config_path


cdef class PackageList(Base):
    cdef:
        public object _installed_list
        public object _package_list_path
        public object _status_handler
        #public list _packages
        public object _packages
        public int _index


cdef class Package(BaseVersion):
    cdef:
        public object package_id
        public unicode name
        public object version
        public object rev
        public object _installed
        public object install_cmds
        public object _upgrade_available
        public object upgrade_cmds
        public object uninstall_cmds
        public object _package_list
        public object _connection_list
        public object dependencies_list
        public object _log
        public unicode _description
        public list _keywords
        public object _icon
        public object _icon_type
        public object _status_handler


cdef class Settings(Base):
    cdef:
        public object _settings_path
        public object _installed_list
        public object _install_list
        public object _package_list
        public object _package_lists
        public object _profile_list
        public object _host_list
        public object _log_list
        public object _target_source
        public object _status_gui_cmd
        public unicode _u_run
        public unsigned char _run
        public unicode _u_display_target
        public unsigned char _display_target
        public unsigned long _interval


cdef class LogList(BaseVersion):
    cdef:
        public object _log_list_path
        public object _logs
        public object protocol_plugins
        public object _config_path


cdef class Host(BaseVersion):
    cdef:
        #public str _ipv4
        #public str _ipv6
        public unicode _ipv4
        public unicode _ipv6
        public unicode _hostname
        public unicode _workgroup
        public unicode _domain_name
        public unicode _forest_name
        public list _packages
        public list _profiles
        public list _all_packages
        public Py_ssize_t _len

    #cpdef bint ipv4_is(self, str ip)

    #cpdef bint ipv6_is(self, str ip)

    cpdef bint ipv4_is(self, unicode ip)

    cpdef bint ipv6_is(self, unicode ip)

    cpdef bint hostname_is(self, unicode hostname)

    cpdef bint workgroup_is(self, unicode workgroup)

    cpdef bint domain_name_is(self, unicode domain_name)

    cpdef bint forest_name_is(self, unicode forest_name)

    cpdef get_packages(self)

    cpdef get_profiles(self)


cdef class Profile(BaseVersion):
    cdef:
        public unicode _id
        public list _packages
        public object _profile_list


cdef class HostList(Base):
    cdef public object _host_list_path


cdef class ProfileList(Base):
    cdef:
        public object _profile_list_path


cdef class InstallList(Base):
    cdef:
        public object _install_list_path
        public list _install_list
        public list _packages
        public list _profiles

    cpdef get_packages(self)

    cpdef get_profiles(self)


cdef class ConnectionList(Base):
    cdef:
        public object _connection_list_path
        #public object _config_path
        public object _connections
        public object protocol_plugins
        public object _status_handler
        public object _window_handle