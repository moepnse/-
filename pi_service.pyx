# -*- coding: utf-8 -*-

__author__ = 'Richard Lamboj'
__copyright__ = 'Copyright 2013, Unicom'
__credits__ = ['Richard Lamboj']
__license__ = 'Proprietary'
__version__ = '1.0'
__maintainer__ = 'Richard Lamboj'
__email__ = 'rlamboj@unicom.ws'
__status__ = 'Development'


# standard library imports
import os
import sys
import time
import codecs
import platform
import struct
import subprocess
import traceback

# third party imports


# application/library imports
from package_installer import get_application_path, get_config_plugins, installed_list_factory, settings_factory, package_list_factory, profile_list_factory, install_list_factory, connection_list_factory, log_list_factory, host_list_factory, Log, get_ph_plugins, get_log_plugins, get_settings_config_path, INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN, SEND_STATUS, SEND_INFO, SEND_INFO_SUCCESS, SEND_INFO_WARN, SEND_INFO_ERROR, SEND_DONE
from libs.handlers.config import RETURN_ID, RET_CODE_UNKNOWN, RET_CODE_SUCCESS, RET_CODE_ERROR, RET_CODE_ALREADY_INSTALLED, RET_CODE_ALREADY_REMOVED, RET_CODE_PACKAGE_NOT_FOUND, ChecksumViolation
from libs.handlers.protocol import FileNotFound, ConnectionError, AuthenticationError
import libs.win.commandline
import libs.win.winreg


# standard library cimports
from cpython.ref cimport PyObject
from libc.stdlib cimport malloc, free
from libc.string cimport memset

#from c_python cimport Py_intptr_t

# application/library cimports
from libs.handlers.config cimport StatusHandler as BaseStatusHandler, st__info, st__success, st__warn, st__error
from c_windows_data_types cimport DWORD, VOID, LPCWSTR, LPWSTR, size_t, LPCTSTR, wchar_t, PHANDLE, LPVOID, BOOL, PWSTR, LPCWSTR, PCWSTR, ULONG, PDWORD, PBYTE 
from c_winsock2 cimport time_t, NI_NUMERICHOST, AF_INET, AF_UNSPEC, WSADATA, WSAStartup, WSACleanup
from c_iptypes cimport GAA_FLAG_INCLUDE_PREFIX, PIP_ADAPTER_ADDRESSES_XP, PIP_ADAPTER_UNICAST_ADDRESS_XP, PIP_ADAPTER_ADDRESSES_LH, PIP_ADAPTER_UNICAST_ADDRESS_LH
from c_iphlpapi cimport GetAdaptersAddresses
from c_ws2tcpip cimport getnameinfo
from c_windows cimport SERVICE_ACCEPT_SHUTDOWN, SERVICE_ACCEPT_STOP, SERVICE_CONTROL_SHUTDOWN, SERVICE_CONTROL_STOP, SERVICE_RUNNING, SERVICE_START_PENDING, SERVICE_STATUS, SERVICE_STATUS_HANDLE, SERVICE_STOPPED, SERVICE_STOP_PENDING, SERVICE_TABLE_ENTRY, SERVICE_TABLE_ENTRYW, SERVICE_WIN32, SERVICE_WIN32_OWN_PROCESS, SERVICE_WIN32_SHARE_PROCESS, SERVICE_INTERACTIVE_PROCESS, SERVICE_TYPE_ALL, LPSERVICE_MAIN_FUNCTIONW, LPSERVICE_MAIN_FUNCTIONW, LPHANDLER_FUNCTION, GetLastError, SetServiceStatus, RegisterServiceCtrlHandlerW,  StartServiceCtrlDispatcherW, CreateNamedPipe, PIPE_ACCESS_DUPLEX, PIPE_ACCESS_OUTBOUND, PIPE_TYPE_MESSAGE, PIPE_READMODE_MESSAGE, PIPE_TYPE_BYTE, PIPE_WAIT, HANDLE, WriteFile, DisconnectNamedPipe, ConnectNamedPipe, WinExec, INVALID_HANDLE_VALUE, STARTF_USESTDHANDLES, STARTF_USESHOWWINDOW, SW_HIDE, CREATE_NEW_CONSOLE, CreateProcessW, CloseHandle, WaitForSingleObject, GetExitCodeProcess, PROCESS_INFORMATION, STARTUPINFOW, NETRESOURCE, INFINITE, wcscpy, wcslen, wcscpy_s, SecureZeroMemory, CREATE_UNICODE_ENVIRONMENT, WTSQueryUserToken, WTSGetActiveConsoleSessionId, CreateProcessAsUserW, GetVersion, LOBYTE, HIBYTE, LOWORD, HIWORD, CreateEnvironmentBlock, DuplicateTokenEx, TOKEN_ASSIGN_PRIMARY, TOKEN_ALL_ACCESS, _SECURITY_IMPERSONATION_LEVEL, WTS_SESSION_INFOW, WTSActive, WTSConnected, WTSConnectQuery, WTSShadow, WTSDisconnected, WTSIdle, WTSListen, WTSReset, WTSDown, WTSInit, WTS_CONNECTSTATE_CLASS, PWTS_SESSION_INFOW, WTSEnumerateSessionsW, WTS_CURRENT_SERVER_HANDLE, LPSECURITY_ATTRIBUTES, _WTS_CONNECTSTATE_CLASS, _SECURITY_IMPERSONATION_LEVEL, _TOKEN_TYPE, SecurityImpersonation, TokenPrimary, WTSQuerySessionInformationW, WTSFreeMemory, _wcsicmp, WTSUserName, WTSDomainName, ERROR_INVALID_PARAMETER, SetLastError, ERROR_INVALID_PARAMETER, GetUserProfileDirectoryW, DestroyEnvironmentBlock, MAX_PATH, SC_HANDLE, GetModuleFileNameW, OpenSCManagerW, CreateServiceW, SC_MANAGER_CONNECT, SC_MANAGER_CREATE_SERVICE, SERVICE_ERROR_NORMAL, SERVICE_QUERY_STATUS, SERVICE_STOP, DELETE, ControlService, CloseServiceHandle, QueryServiceStatus, DeleteService, Sleep, OpenServiceW, SERVICE_DEMAND_START, SERVICE_AUTO_START, GetModuleBaseNameW, EnumProcesses, EnumProcessModules, OpenProcess, PROCESS_QUERY_INFORMATION, PROCESS_VM_READ, HMODULE, TOKEN_QUERY, TOKEN_IMPERSONATE, TOKEN_DUPLICATE, OpenProcessToken, PROCESS_ALL_ACCESS, TOKEN_ADJUST_PRIVILEGES, TOKEN_QUERY, TOKEN_DUPLICATE, TOKEN_ASSIGN_PRIMARY, TOKEN_ADJUST_SESSIONID, TOKEN_READ, TOKEN_WRITE, TOKEN_PRIVILEGES, LUID, AdjustTokenPrivileges, DuplicateTokenEx, LookupPrivilegeValueW, SE_DEBUG_NAME, SE_PRIVILEGE_ENABLED, MAXIMUM_ALLOWED, SecurityIdentification,  SetTokenInformation, TokenSessionId, PTOKEN_PRIVILEGES, SetEvent, CreateEventW, OVERLAPPED, InitiateSystemShutdownW, AbortSystemShutdownW, GetCurrentProcess, SE_SHUTDOWN_NAME,  CTRL_SHUTDOWN_EVENT, CTRL_C_EVENT, SERVICE_CONTROL_PRESHUTDOWN, SERVICE_ACCEPT_PRESHUTDOWN, ShutdownBlockReasonCreate, QWORD, DSROLE_PRIMARY_DOMAIN_INFO_BASIC, DsRoleGetPrimaryDomainInformation, DsRolePrimaryDomainInfoBasic, ERROR_SUCCESS, BUFSIZ, MAKEWORD
#from c_windows cimport IsWindowsVistaOrGreater


cdef:
    object pi_service
    #str gpo_script_path = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts"
    str gpo_script_path = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\Scripts"

# supported api versions
api_versions = ["1.0"]


class FileHandler(object):

    def __init__(self, *args, **kwargs):
        self._fh = open(*args, **kwargs)
        #self._fh = codecs.open(*args, **kwargs)

    def __getattr__(self, name):
        return getattr(self._fh, name)

    def write(self, data):
        if isinstance(data, unicode):
            data = data.encode('utf-8')
        self._fh.write(data)
        self._fh.flush()


cdef:
    SERVICE_STATUS service_status
    SERVICE_STATUS_HANDLE h_status 

    #void  ServiceMain(int argc, char** argv)
    #void  ControlHandler(DWORD request)
    #int InitService()


cdef void init_service():
    cdef:
        SERVICE_TABLE_ENTRYW service_table[2]
        unicode u_service_name = u"pi_service"
        LPWSTR service_name = <LPWSTR>u_service_name

    #print >>sys.stdout, "pi_service"
    #print >>sys.stdout, "setting service name"
    service_table[0].lpServiceName = service_name
    #print >>sys.stdout, "setting service main function"

    service_table[0].lpServiceProc = <LPSERVICE_MAIN_FUNCTIONW>service_main

    service_table[1].lpServiceName = NULL
    service_table[1].lpServiceProc = NULL

    #print >>sys.stdout, "starting control dispatcher thread"

    # Start the control dispatcher thread for our service
    StartServiceCtrlDispatcherW(service_table)
    #ControlHandler(SERVICE_CONTROL_STOP)
    #ServiceMain(0, NULL)


cdef void service_main(int argc, char** argv):
    global pi_service
    global service_status
    global h_status
    cdef:
        int error
        unicode u_service_name = u"pi_service"
        LPCWSTR service_name = <LPWSTR>u_service_name

    #print >>sys.stdout, "service main"

    service_status.dwServiceType = SERVICE_WIN32_OWN_PROCESS | SERVICE_INTERACTIVE_PROCESS
    #service_status.dwServiceType = SERVICE_TYPE_ALL
    service_status.dwCurrentState = SERVICE_START_PENDING

    # SERVICE_CONTROL_PRESHUTDOWN
    # 0x0000000F
    #
    # Notifies a service that the system will be shutting down. Services that need additional time to perform cleanup tasks beyond the tight time restriction at system shutdown can use this notification. The service control manager sends this notification to applications that have registered for it before sending a SERVICE_CONTROL_SHUTDOWN notification to applications that have registered for that notification.
    #
    # A service that handles this notification blocks system shutdown until the service stops or the preshutdown time-out interval specified through SERVICE_PRESHUTDOWN_INFO expires. Because this affects the user experience, services should use this feature only if it is absolutely necessary to avoid data loss or significant recovery time at the next system start.
    #
    # Windows Server 2003 and Windows XP:  This value is not supported.
    #
    #
    # SERVICE_CONTROL_SHUTDOWN
    # 0x00000005
    #    
    # Notifies a service that the system is shutting down so the service can perform cleanup tasks. Note that services that register for SERVICE_CONTROL_PRESHUTDOWN notifications cannot receive this notification because they have already stopped.
    #
    # If a service accepts this control code, it must stop after it performs its cleanup tasks and return NO_ERROR. After the SCM sends this control code, it will not send other control codes to the service.

    #service_status.dwControlsAccepted = SERVICE_ACCEPT_STOP | SERVICE_ACCEPT_PRESHUTDOWN
    service_status.dwControlsAccepted = SERVICE_ACCEPT_STOP | SERVICE_ACCEPT_SHUTDOWN
    service_status.dwWin32ExitCode = 0
    service_status.dwServiceSpecificExitCode = 0 
    service_status.dwCheckPoint = 0
    service_status.dwWaitHint = 0 

    #print >>sys.stdout, "Registering Service Ctrl Handler"
    h_status = RegisterServiceCtrlHandlerW(service_name, <LPHANDLER_FUNCTION>service_control_handler)

    if h_status == <SERVICE_STATUS_HANDLE>0:
        # Registering Control Handler failed
        #print >>sys.stderr, "Registering Control Handler failed, with error: %d" % GetLastError()
        return

    #print >>sys.stdout, "Start pending..."
    SetServiceStatus(h_status, &service_status)

    # Initialize Service 
    #error = InitService() 
    #if error:
		# Initialization failed
        #service_status.dwCurrentState = SERVICE_STOPPED
        #service_status.dwWin32ExitCode = -1
        #SetServiceStatus(h_status, &service_status)
        #return

    #print >>sys.stdout, "Service is running."
    # We report the running status to SCM. 
    service_status.dwCurrentState = SERVICE_RUNNING
    SetServiceStatus(h_status, &service_status)

    pi_service = PIService()
    pi_service.run()

    # The worker loop of a service
    #while service_status.dwCurrentState == SERVICE_RUNNING:
    #    pass
    return


# Control handler function
cdef VOID service_control_handler(DWORD request):
    global pi_service
    global service_status
    global h_status
    if request == SERVICE_CONTROL_STOP: 
        service_status.dwWin32ExitCode = 0
        service_status.dwCurrentState = SERVICE_STOPPED 
        SetServiceStatus(h_status, &service_status)
        return

    elif request == SERVICE_CONTROL_SHUTDOWN: 
        service_status.dwWin32ExitCode = 0
        service_status.dwCurrentState = SERVICE_STOPPED
        SetServiceStatus(h_status, &service_status)
        return

    elif request in (CTRL_SHUTDOWN_EVENT, SERVICE_CONTROL_PRESHUTDOWN, SERVICE_CONTROL_SHUTDOWN):
        #print "got shutdown event"
        if pi_service.ignore_shutdown == False:
            pi_service.on_shutdown()
        service_status.dwWin32ExitCode = 0
        service_status.dwCurrentState = SERVICE_STOPPED
        SetServiceStatus(h_status, &service_status)
        return
    # Report current status
    SetServiceStatus(h_status, &service_status)

    return


cdef void install_service(PWSTR psz_service_name, PWSTR psz_display_name, DWORD dw_start_type, PWSTR psz_dependencies, PWSTR psz_account, PWSTR psz_password):
    cdef:
        #wchar_t sz_path[MAX_PATH]
        wchar_t sz_path[32768]
        SC_HANDLE sch_sc_manager = NULL
        SC_HANDLE sch_service = NULL
    # if GetModuleFileName(NULL, sz_path, ARRAYSIZE(sz_path)) == 0:
    if GetModuleFileNameW(NULL, sz_path, 32768 * sizeof(wchar_t)) == 0:
        print >>sys.stderr, "GetModuleFileName failed w/err %d" % GetLastError()
        return

    # Open the local default service control manager database
    sch_sc_manager = OpenSCManagerW(NULL, NULL, SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE)
    if sch_sc_manager == NULL:
        print >>sys.stderr, "OpenSCManagerW failed w/err %d" %GetLastError()
        return

    # Install the service into SCM by calling CreateService
    sch_service = CreateServiceW(
        sch_sc_manager,                 # SCManager database
        psz_service_name,               # Name of service
        psz_display_name,               # Name to display
        SERVICE_QUERY_STATUS,           # Desired access
        SERVICE_WIN32_OWN_PROCESS,      # Service type
        dw_start_type,                  # Service start type
        SERVICE_ERROR_NORMAL,           # Error control type
        sz_path,                        # Service's binary
        NULL,                           # No load ordering group
        NULL,                           # No tag identifier
        psz_dependencies,               # Dependencies
        psz_account,                    # Service running account
        psz_password                    # Password of the account
    )
    if sch_service == NULL:
        print >>sys.stderr, "CreateServiceW failed w/err %d" % GetLastError()
        CloseServiceHandle(sch_sc_manager)
        return
    print >>sys.stdout, "%s is installed." % psz_service_name

    # Cleanup for all allocated resources.
    if sch_sc_manager:
        CloseServiceHandle(sch_sc_manager)
        sch_sc_manager = NULL
    if sch_service:
        CloseServiceHandle(sch_service);
        sch_service = NULL


cdef void uninstall_service(PWSTR psz_service_name):
    cdef:
        SC_HANDLE sch_sc_manager = NULL
        SC_HANDLE sch_service = NULL
        SERVICE_STATUS ss_svc_status

    # Open the local default service control manager database
    sch_sc_manager = OpenSCManagerW(NULL, NULL, SC_MANAGER_CONNECT)
    if sch_sc_manager == NULL:
        print >>sys.stderr, "OpenSCManagerW failed w/err %s" % GetLastError()

    # Open the service with delete, stop, and query status permissions
    sch_service = OpenServiceW(sch_sc_manager, psz_service_name, SERVICE_STOP | SERVICE_QUERY_STATUS | DELETE)
    if sch_service == NULL:
        print >>sys.stderr, "OpenServiceW failed w/err %d" % GetLastError()

    # Try to stop the service
    if ControlService(sch_service, SERVICE_CONTROL_STOP, &ss_svc_status):
        print >>sys.stdout, "Stopping %s." % psz_service_name
        Sleep(1000)

        while QueryServiceStatus(sch_service, &ss_svc_status):
            if ss_svc_status.dwCurrentState == SERVICE_STOP_PENDING:
                print "."
                Sleep(1000)
            else:
                break

        if ss_svc_status.dwCurrentState == SERVICE_STOPPED:
            print >>sys.stdout, "\n%s is stopped." % psz_service_name
        else:
            print >>sys.stdout, "\n%s failed to stop." % psz_service_name

    # Now remove the service by calling DeleteService.
    if not DeleteService(sch_service):
        print >>sys.stderr, "DeleteService failed w/err %d" % GetLastError()
        CloseServiceHandle(sch_sc_manager)
        sch_sc_manager = NULL

    print >>sys.stdout, "%s is removed." % psz_service_name
    # Cleanup for all allocated resources.
    if sch_sc_manager:
        CloseServiceHandle(sch_sc_manager)
        sch_sc_manager = NULL

    if sch_service:
        CloseServiceHandle(sch_service)
        sch_service = NULL


cdef DWORD get_session_id_of_user(PCWSTR psz_username, PCWSTR psz_domain):
    cdef:
        DWORD dw_session_id = 0xFFFFFFFF
        PWTS_SESSION_INFOW *p_sessions_buffer = NULL
        DWORD dw_session_count = 0
        PWSTR psz_session_domain = NULL
        PWSTR psz_session_username = NULL
        DWORD dw_size
        DWORD sid
        DWORD i = 0

    if psz_username == NULL:
        # If the user name is not provided, try to get the session attached 
        # to the physical console. The physical console is the monitor, 
        # keyboard, and mouse.
        dw_session_id = WTSGetActiveConsoleSessionId()
    else:
        # If the user name is provided, get the session of the provided user. 
        # The same user could have more than one session, this sample just 
        # retrieves the first one found. You can add more sophisticated 
        # checks by requesting different types of information from 
        # WTSQuerySessionInformation.

        p_sessions_buffer = NULL
        dw_session_count = 0

        # Enumerate the sessions on the current server.
        if WTSEnumerateSessionsW(WTS_CURRENT_SERVER_HANDLE, 0, 1, p_sessions_buffer, &dw_session_count):
            while (dw_session_id == -1) and (i < dw_session_count):
                i = i+1
                sid = p_sessions_buffer[i].SessionId
                # Get the user name from the session ID.
                psz_session_username = NULL
                if WTSQuerySessionInformationW(WTS_CURRENT_SERVER_HANDLE, sid, WTSUserName, &psz_session_username, &dw_size):
                    # Compare with the provided user name (case insensitive).
                    if _wcsicmp(psz_username, psz_session_username) == 0:
                        # Get the domain from the session ID.
                        psz_session_domain = NULL
                        if WTSQuerySessionInformationW(WTS_CURRENT_SERVER_HANDLE, sid, WTSDomainName, &psz_session_domain, &dw_size):
                            # Compare with the provided domain (case insensitive).
                            if _wcsicmp(psz_domain, psz_session_domain) == 0:
                                # The session of the provided user is found.
                                dw_session_id = sid
                            WTSFreeMemory(psz_session_domain)
                    WTSFreeMemory(psz_session_username)

            WTSFreeMemory(p_sessions_buffer)
            p_sessions_buffer = NULL
            dw_session_count = 0

            # Cannot find the session of the provided user.
            if dw_session_id == 0xFFFFFFFF:
                SetLastError(ERROR_INVALID_PARAMETER)
    return dw_session_id


cdef bint get_domain_info(DSROLE_PRIMARY_DOMAIN_INFO_BASIC **info):
    cdef:
        DWORD dw

    dw = DsRoleGetPrimaryDomainInformation(NULL, DsRolePrimaryDomainInfoBasic, <PBYTE *>info)
    if dw != ERROR_SUCCESS:
        print >>sys.stderr, "DsRoleGetPrimaryDomainInformation() failed with error code: %d" % GetLastError
        return False
    return True


cdef bint get_ip_addresses(list ip4_addresses, list ip6_addresses):
    cdef:
        DWORD ret_val
        DWORD size
        PIP_ADAPTER_ADDRESSES_LH adapter_addresses
        PIP_ADAPTER_ADDRESSES_LH aa
        PIP_ADAPTER_UNICAST_ADDRESS_LH ua
        char buf[512]
        int family
        WSADATA d

    if WSAStartup(MAKEWORD(2, 2), &d) != 0:
        return False

    ret_val = GetAdaptersAddresses(AF_UNSPEC, GAA_FLAG_INCLUDE_PREFIX, NULL, NULL, &size)
    #if ret_val != ERROR_BUFFER_OVERFLOW:
    #    return False

    adapter_addresses = <PIP_ADAPTER_ADDRESSES_LH>malloc(size)

    ret_val = GetAdaptersAddresses(AF_UNSPEC, GAA_FLAG_INCLUDE_PREFIX, NULL, <PIP_ADAPTER_ADDRESSES_LH>adapter_addresses, &size)

    if ret_val != ERROR_SUCCESS:
        #fprintf(stderr, "GetAdaptersAddresses() failed...")
        free(adapter_addresses)
        return False

    aa = adapter_addresses
    while aa != NULL:
        #print_adapter(aa)
        ua = aa.FirstUnicastAddress
        while ua != NULL:
            #print_addr(ua);

            family = ua.Address.lpSockaddr.sa_family

            memset(buf, 0, BUFSIZ)
            getnameinfo(ua.Address.lpSockaddr, ua.Address.iSockaddrLength, buf, sizeof(buf), NULL, 0, NI_NUMERICHOST)

            if family == AF_INET:
                ip4_addresses.append(buf.decode("utf-8"))
            else:
                ip6_addresses.append(buf.decode("utf-8"))

            ua = ua.Next
        aa = aa.Next

    free(adapter_addresses)
    WSACleanup()


cdef class StatusHandler(BaseStatusHandler):

    cdef:
        PIService _pi_service

    def __init__(self, object pi_service):
        self._pi_service = pi_service

    def set_status(self, int source_id, int status_type, unicode status_source_name, int status_id, unicode description):
        status_id_count = BaseStatusHandler.set_status(self, source_id, status_type, status_source_name, status_id, description)
        if status_type == st__info:
            self._pi_service._send_info(description, SEND_INFO_SUCCESS)
        elif status_type == st__success:
            self._pi_service._send_info(description, SEND_INFO_SUCCESS)
        elif status_type == st__warn:
            self._pi_service._send_info(description, SEND_INFO_WARN)
        elif status_type == st__error:
            self._pi_service._send_info(description, SEND_INFO_ERROR)
        return status_id_count


cdef class PIService:

    cdef:
        HANDLE _ph
        public bint _status_gui
        public unsigned char _run
        public unsigned char _display_target
        public object _settings 
        public dict _plugins
        public object _log
        public object _status_handler
        public object _connection_list
        public object _installed_list
        public object _package_list
        public object _profile_list
        public object _install_list
        public object _host_list
        public unicode _local_hostname
        public object _host
        public object _packages
        public unsigned char _steps
        public bint ignore_shutdown
        int _version
        public object _fh_named_pipe_log
        str _pipe_name
        bint _send_cmd_full_path
        bint _send_cmd_infos
        OVERLAPPED _overlapped
        HANDLE _h_wait_stop
        DWORD _interval
        unicode _local_workgroup
        unicode _local_domain_name
        unicode _local_forest_name
        list _ip4_addresses
        list _ip6_addresses
        list _profiles
        dict _config_plugins
        list _api_versions
    cdef public void _send_info(self, unicode msg, unsigned char msg_type)

    def __cinit__(self):
        cdef:
            DSROLE_PRIMARY_DOMAIN_INFO_BASIC *info
        self._version = 1
        self._pipe_name = r'\\.\pipe\pi_status_gui'
        self._send_cmd_full_path = False
        self._send_cmd_infos = True
        self._overlapped.hEvent = CreateEventW(NULL, 0, 0, NULL)
        self._h_wait_stop = CreateEventW(NULL, 0, 0, NULL)
        self._interval = 32400000
        self.ignore_shutdown = True
        self._local_workgroup = u""
        self._local_domain_name = u""
        self._local_forest_name = u""
        self._ip4_addresses = []
        self._ip6_addresses = []

        get_domain_info(&info)
        get_ip_addresses(self._ip4_addresses, self._ip6_addresses)

        if info.DomainNameDns != NULL:
            self._local_domain_name = info.DomainNameDns

        if info.DomainForestName != NULL:
            self._local_forest_name = info.DomainForestName

        self._local_workgroup = info.DomainNameFlat

    def __init__(self):
        global api_versions
        self._api_versions = api_versions
        self._status_gui = False
        self._run = ON_START

        #win32serviceutil.ServiceFramework.__init__(self, args)
        #self.hWaitStop = win32event.CreateEvent(None, 0, 0, None)
        # We need to use overlapped IO for this, so we don't block when
        # waiting for a client to connect.  This is the only effective way
        # to handle either a client connection, or a service stop request.
        #self.overlapped = pywintypes.OVERLAPPED()
        # And create an event to be used in the OVERLAPPED object.

        self._fh_named_pipe_log = open('np_server.log', 'w')

    cdef void _create_named_pipe(self):
        self._log.log_debug(ur"[pi_service] Creating Named Pipe \\.\pipe\pi_status_gui")

        self._ph = CreateNamedPipe(self._pipe_name,
            PIPE_ACCESS_DUPLEX,
            PIPE_TYPE_BYTE | PIPE_WAIT,
            255, 65536, 65536, 3000, NULL)

        if self._ph == INVALID_HANDLE_VALUE:
            self._log.log_err(u"[pi_service] Could not create pipe: %s. Error Nr.: %d" % (self._pipe_name, GetLastError()))

    cdef void _connect_named_pipe(self):
        ConnectNamedPipe(self._ph, NULL)

    cdef void _send_data(self, bytes data):
        cdef:
            DWORD dw_bytes_to_write = 0
            DWORD dw_bytes_written = 0
            bint ret_val = 0
        try:
            if self._fh_named_pipe_log is not None:
                self._fh_named_pipe_log.write(data)
                self._fh_named_pipe_log.flush()
        except IOError, err:
            if err.errno == 28:
                print err.strerror
                self._fh_named_pipe_log = None
                self._send_info(u"%s %s" % (err.errno, err.strerror), SEND_INFO_ERROR)

        dw_bytes_to_write = <DWORD>len(data)
        result = WriteFile(self._ph, <char*>data, dw_bytes_to_write, &dw_bytes_written, NULL)
        #ret_val = WriteFile(self._ph, data, dw_bytes_to_write, NULL, NULL)
        if ret_val == 0:
            self._log.log_err(u"[pi_service] WriteFile Error: %d" % GetLastError())
        self._log.log_debug(u"[pi_service] Bytes to write: %d, bytes written: %d" % (dw_bytes_to_write, dw_bytes_written))

    cdef void _disconnect_named_pipe(self):
        DisconnectNamedPipe(self._ph)

    def _start(self):
        cdef:
            bint ret_val = 0

        if self._status_gui:
            self._create_named_pipe()
            self._log.log_info(u"[pi_service] [%d] Starting Status GUI(%s)" % (libs.common.get_current_line_nr(), self._settings.status_gui_cmd))
            #if IsWindowsVistaOrGreater():

            dw_version = GetVersion()

            dw_major_version = <DWORD>(LOBYTE(LOWORD(dw_version)))
            dw_minor_version = <DWORD>(HIBYTE(LOWORD(dw_version)))

            if dw_major_version >= 6 and dw_minor_version >= 0:
                ret_val =self._execute_as_user(self._settings.status_gui_cmd)
                if ret_val == False:
                    self._log.log_err(u"_execute_as_user failed, trying _execute...")
                    ret_val = self._execute(self._settings.status_gui_cmd)
            else:
                ret_val = self._execute(self._settings.status_gui_cmd)
            #ret_value = WinExec(self._settings.status_gui_cmd, 1)
            #if ret_value < 32:
            #    print "Error: %d" % ret_value
            args = libs.win.commandline.parse(self._settings.status_gui_cmd)
            #time.sleep(10)
            self._log.log_info(unicode(args))
            #self._p = subprocess.Popen(args,
            #         stdout = subprocess.PIPE,
            #         stdin = subprocess.PIPE, shell=True)
            if ret_val:
                self._connect_named_pipe()
                self._send_proto_version()
                self._send_step_count()
            else:
                self._log.log_err(u"Could not start status gui; running without!")
                self._status_gui = False
        self._install()
        if self._status_gui:
            self._send_done()
            time.sleep(10)
            self._disconnect_named_pipe()

    def end(self):
        if self._fh_named_pipe_log is not None:
            self._fh_named_pipe_log.close()

    def run(self):
        #self._report_service_status(win32service.SERVICE_START_PENDING)
        self._initiate()
        self._log.log_debug(u"Mode: %s" % self._settings._u_run)
        self._log.log_debug(u"Mode: %d" % self._run)
        self._log.log_info(u"local hostname: %s" % self._local_hostname)
        self._log.log_info(u"local workgroup: %s" % self._local_workgroup)
        self._log.log_info(u"local forest name: %s" % self._local_forest_name)
        self._log.log_info(u"local domain name: %s" % self._local_domain_name)

        if self._run == ON_START:
            self._run_on_start()
        elif self._run == ON_SHUTDOWN:
            self._run_on_shutdown()
        elif self._run == REPEATEDLY:
            self._run_repeatedly()

        #self._report_service_status(win32service.SERVICE_STOPPED)

    cdef void stop(self):
        #self._report_service_status(win32service.SERVICE_STOP_PENDING)
        #win32event.SetEvent(self.hWaitStop)
        SetEvent(self._h_wait_stop)

    def shutdown(self):
        if self._run == ON_SHUTDOWN:
            pass

    def _run_on_start(self):
        self._log.log_debug(u"_run_on_start")
        self._start()
        self.end()
        #win32event.WaitForSingleObject(self.hWaitStop, win32event.INFINITE)

    def _run_repeatedly(self):
        self._log.log_debug(u"_run_repeatedly")
        while True:
            self._start()
            self._log.log_debug(u"next round in %d" % self._interval)
            Sleep(self._interval)
        self.end()

    def _run_on_shutdown(self):
        self._log.log_debug(u"Waiting for stop event...")
        WaitForSingleObject(self._h_wait_stop, INFINITE)

    cdef bint on_shutdown(self):
        cdef:
            HANDLE h_token             # handle to process token 
            TOKEN_PRIVILEGES tkp       # pointer to token structure 

        self._log.log_debug(u"on_shutdown")

        if self.ignore_shutdown:

            # Get the current process token handle  so we can get shutdown 
            # privilege. 
            if not OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &h_token):
                self._log.log_err(u"OpenProcessToken failed with error %d" % GetLastError())

            # Get the LUID for shutdown privilege. 
            LookupPrivilegeValueW(NULL, SE_SHUTDOWN_NAME, &tkp.Privileges[0].Luid) 

            tkp.PrivilegeCount = 1  # one privilege to set    
            tkp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED

            # Get shutdown privilege for this process. 
            if not AdjustTokenPrivileges(h_token, False, &tkp, 0, <PTOKEN_PRIVILEGES>NULL, <PDWORD>0):
                self._log.log_err(u"AdjustTokenPrivileges failed with error %d" % GetLastError())

            if not AbortSystemShutdownW(NULL):
                self._log.log_err(u"AbortSystemShutdownW failed with error %d" % GetLastError())

            self.ignore_shutdown = False
            self._start()
            if not InitiateSystemShutdownW( 
                      NULL,    # shut down local computer 
                      NULL,    # message for user
                      30,      # time-out period, in seconds 
                      False,   # ask user to close apps 
                      False):   # reboot after shutdown 
                self._log.log_err(u"InitiateSystemShutdownW failed with error %d" % GetLastError())
        self.end()
        return True

    cdef wchar_t* _get_process_name(self, pid):
        cdef:
            HANDLE h_process = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, False, pid)
            HANDLE h_pt
            HMODULE h_mod
            DWORD dw_bytes
            #wchar_t process_name[MAX_PATH] = <bytes>u"<unknown>"
            wchar_t process_name[32768]

        process_name = <bytes>u"<unknown>"
        # Get the process name.
        if (NULL != h_process ):
            if EnumProcessModules(h_process, &h_mod, sizeof(h_mod), &dw_bytes):
                GetModuleBaseNameW(h_process, h_mod, process_name, sizeof(process_name) / sizeof(wchar_t))

                #if not OpenProcessToken(h_process, DWORD DesiredAccess, &h_pt):
                #    self._log.log_err(u"OpenProcessToken failed with error %d" % GetLastError())
        CloseHandle(h_process)
        return process_name


    cdef WinSession _get_session_from_winlogon_exe(self):
        cdef:
            DWORD processes[1024]
            DWORD dw_bytes = 0
            DWORD dw_process_count = 0
            DWORD dw_session_id = 0
            unsigned int i = 0
            HANDLE h_process = NULL
            HANDLE h_pt = NULL
            HANDLE h_user_token_dup = NULL
            HMODULE h_mod = NULL
            DWORD pid = 0
            #wchar_t process_name[MAX_PATH] = <bytes>u"<unknown>"
            wchar_t process_name[32768]
            WinSession win_session
            TOKEN_PRIVILEGES tp
            LUID luid
        win_session.dw_session_id = 0
        win_session.h_token = h_pt
        if not EnumProcesses(processes, sizeof(processes), &dw_bytes):
            return win_session

        # Calculate how many process identifiers were returned.
        dw_process_count = dw_bytes / sizeof(DWORD);
        self._log.log_debug(u"found %d processes" % dw_process_count)
        for i in range(0, dw_process_count):
            self._log.log_debug(u"found process with pid %d" % processes[i])
            if processes[i] != 0:
                #h_process = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, False, processes[i])
                h_process = OpenProcess(MAXIMUM_ALLOWED, False, processes[i])

                #process_name = <bytes>u"<unknown>"
                # Get the process name.
                if h_process == NULL:
                    self._log.log_err(u"OpenProcess: pid: %d, error: %d" % (processes[i], GetLastError()))
                else:
                    if EnumProcessModules(h_process, &h_mod, sizeof(h_mod), &dw_bytes) or GetLastError() == 299:
                        GetModuleBaseNameW(h_process, h_mod, process_name, sizeof(process_name) / sizeof(wchar_t))
                        self._log.log_debug(u"found %s" % process_name)
                        if process_name == <bytes>u"winlogon.exe":
                            if OpenProcessToken(h_process, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY | TOKEN_DUPLICATE | TOKEN_ASSIGN_PRIMARY | TOKEN_ADJUST_SESSIONID | TOKEN_READ | TOKEN_WRITE, &h_pt):
                                self._log.log_debug(u"found winlogon process (%d)" % processes[i])
                                if not LookupPrivilegeValueW(NULL, SE_DEBUG_NAME, &luid):
                                    self._log.log_err(u"LookupPrivilegeValueW failed with error: %d" % GetLastError())

                                tp.PrivilegeCount = 1
                                tp.Privileges[0].Luid = luid
                                tp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED

                                DuplicateTokenEx(h_pt, MAXIMUM_ALLOWED, NULL, SecurityIdentification, TokenPrimary, &h_user_token_dup);

                                # Adjust Token privilege
                                SetTokenInformation(h_user_token_dup, TokenSessionId, <void*>dw_session_id, sizeof(DWORD))

                                if not AdjustTokenPrivileges(h_user_token_dup, False, &tp, sizeof(TOKEN_PRIVILEGES), <PTOKEN_PRIVILEGES>NULL, NULL):
                                    self._log.log_err(u"AdjustTokenPrivileges failed with error: %d", GetLastError())

                                win_session.dw_session_id = 0
                                win_session.h_token = h_pt
                                return win_session
                            else:
                                self._log.log_err(u"OpenProcessToken failed with error %d" % GetLastError())
                    else:
                        self._log.log_err(u"EnumProcessModules failed with error %d" % GetLastError())
                CloseHandle(h_process)
        self._log.log_err(u"Could not found winlogon.exe")
        return win_session

    cdef WinSession _get_current_session(self):
        cdef:
            HANDLE current_token = NULL
            HANDLE primary_token = NULL
            ULONG dw_session_id = 0
            #LPWSTR win_station_name = ""
            HANDLE h_user_token = NULL
            HANDLE h_token_dup = NULL
            PWTS_SESSION_INFOW p_session_info = NULL
            DWORD dw_count = 0
            DWORD i = 0
            WTS_SESSION_INFOW si
            BOOL b_ret = False
            WinSession win_session
            #int data_size = sizeof(WTS_SESSION_INFOW)
            dict WTS_STATE_MAPPING = {
                WTSActive: "A user is logged on to the WinStation.",
                WTSConnected: "The WinStation is connected to the client.",
                WTSConnectQuery: "The WinStation is in the process of connecting to the client.",
                WTSShadow: "The WinStation is shadowing another WinStation.",
                WTSDisconnected: "The WinStation is active but the client is disconnected.",
                WTSIdle: "The WinStation is waiting for a client to connect.",
                WTSListen: "The WinStation is listening for a connection. A listener session waits for requests for new client connections. No user is logged on a listener session. A listener session cannot be reset, shadowed, or changed to a regular client session.",
                WTSReset: "The WinStation is being reset.",
                WTSDown: "The WinStation is down due to an error.",
                WTSInit: "The WinStation is initializing."
            },
            list states = [WTSActive, WTSConnected, WTSDisconnected],
            bint found_session = False
            DWORD state = 0

        # set struct default values
        win_session.dw_session_id = 0
        win_session.h_token = <HANDLE>0
        # Get the list of all terminal sessions
        WTSEnumerateSessionsW(WTS_CURRENT_SERVER_HANDLE, 0, 1, &p_session_info, &dw_count)
        self._log.log_debug(u"Session Count: %d" % (dw_count))
        # look over obtained list in search of the active session
        for state in states:
            for i in range(0, dw_count):
                si = p_session_info[i]
                self._log.log_debug(u"Session ID: %d, State: %d (%s)" % (si.SessionId, si.State, WTS_STATE_MAPPING[si.State]))
                # Specifies the connection state of a Remote Desktop Services session.
                # ====================================================================
                # WTSActive
                #    A user is logged on to the WinStation.
                # WTSConnected
                #   The WinStation is connected to the client.
                # WTSConnectQuery
                #    The WinStation is in the process of connecting to the client.
                # WTSShadow
                #    The WinStation is shadowing another WinStation.
                # WTSDisconnected
                #    The WinStation is active but the client is disconnected.
                # WTSIdle
                #    The WinStation is waiting for a client to connect.
                # WTSListen
                #    The WinStation is listening for a connection. A listener session waits for requests for new client connections. No user is logged on a listener session. A listener session cannot be reset, shadowed, or changed to a regular client session.
                # WTSReset
                #    The WinStation is being reset.
                # WTSDown
                #    The WinStation is down due to an error.
                # WTSInit
                #    The WinStation is initializing.
                if state == si.State:
                    # If the current session is active – store its ID
                    dw_session_id = si.SessionId
                    #win_station_name = si.pWinStationName
                    self._log.log_debug(u"[pi_service] Session ID: %d, State: %d" % (dw_session_id, si.State))
                    # Get token of the logged in user by the active session ID
                    b_ret = WTSQueryUserToken(dw_session_id, &current_token)
                    if b_ret == False:
                        self._log.log_err(u"[pi_service] WTSQueryUserToken: %d" % GetLastError())
                        continue
                    #self._log.log_debug("[pi_service] current_token: %d" % current_token)
                    b_ret = DuplicateTokenEx(current_token, TOKEN_ASSIGN_PRIMARY | TOKEN_ALL_ACCESS, <LPSECURITY_ATTRIBUTES>0, SecurityImpersonation, TokenPrimary, &primary_token)
                    if b_ret == False:
                        self._log.log_err(u"[pi_service] Cannot duplicate Token!")
                        self._log.log_err(u"[pi_service] DuplicateTokenEx: %d" % GetLastError())
                        continue
                    win_session.dw_session_id = dw_session_id
                    win_session.h_token = primary_token
                    return win_session
                    found_session = True
                    break
            if found_session:
                break
        #dw_session_id = WTSGetActiveConsoleSessionId()
        self._log.log_debug(u"[pi_service] Session ID: %d" % dw_session_id)
        #self._log.log_debug(u"[pi_service] WinStation: %s" % win_station_name)

        # Get token of the logged in user by the active session ID
        b_ret = WTSQueryUserToken(dw_session_id, &current_token)
        if b_ret == False:
            self._log.log_err(u"[pi_service] WTSQueryUserToken: %d" % GetLastError())
            return win_session
        #self._log.log_debug(u"[pi_service] current_token: %d" % current_token)
        b_ret = DuplicateTokenEx(current_token, TOKEN_ASSIGN_PRIMARY | TOKEN_ALL_ACCESS, <LPSECURITY_ATTRIBUTES>0, SecurityImpersonation, TokenPrimary, &primary_token)
        if b_ret == False:
            self._log.log_err(u"[pi_service] Cannot duplicate Token!")
            self._log.log_err(u"[pi_service] DuplicateTokenEx: %d" % GetLastError())
            return win_session
        win_session.dw_session_id = dw_session_id
        win_session.h_token = primary_token
        return win_session

    cdef int _execute_as_user(self, unicode cmd):
        cdef:
            STARTUPINFOW si
            PROCESS_INFORMATION pi
            bint ret_val = False
            DWORD create_flags = 0
            size_t length = len(cmd)
            wchar_t* w_cmd = <wchar_t*>malloc(32768)
            str key = ""
            HANDLE h_token = NULL
            LPVOID lp_environment = NULL
            #wchar_t sz_user_profile_dir[MAX_PATH]
            wchar_t sz_user_profile_dir[32768]
            #DWORD cch_user_profile_dir = ARRAYSIZE(sz_user_profile_dir)
            DWORD cch_user_profile_dir = 32768 / sizeof(wchar_t)
            WinSession session
        #if WTSQueryUserToken(WTSGetActiveConsoleSessionId(), h_token) == 0:
        #    self._log.log_err(u"[pi_service] Error calling WTSQueryUserToken. Error Nr.: %d" % (GetLastError()))
        #    return False
        if self._display_target == CURRENT_USER:
            session = self._get_current_session()
            #session = self._get_session_from_winlogon_exe()
            h_token = session.h_token
            if h_token == <HANDLE>0:
                session = self._get_session_from_winlogon_exe()
                h_token = session.h_token
                if h_token == <HANDLE>0:
                    self._log.log_err(u"[pi_service] Invalid Token!")
                    return False
        else:
            session = self._get_session_from_winlogon_exe()
            h_token = session.h_token
            if h_token == <HANDLE>0:
                self._log.log_err(u"[pi_service] Invalid Token!")
                return False

        CreateEnvironmentBlock(&lp_environment, h_token, True)
        for key in os.environ:
            cmd = cmd.replace(u"%%%s%%" % key.decode("utf-8"), os.environ[key].decode("utf-8"))
        self._log.log_debug(u"[pi_service] _execute_as_user: %s" % (cmd))
        wcscpy_s(w_cmd, length * sizeof(wchar_t), <wchar_t*>cmd)
        SecureZeroMemory(&pi, sizeof(pi))
        SecureZeroMemory(&si, sizeof(si))
        #si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW
        if session.dw_session_id == 0:
            si.lpDesktop = <bytes>u"winsta0\\winlogon"
        else:
            si.lpDesktop = <bytes>u"winsta0\\default"
        si.cb = sizeof(si)
        #create_flags = CREATE_NEW_CONSOLE | CREATE_UNICODE_ENVIRONMENT
        create_flags = CREATE_UNICODE_ENVIRONMENT
        # Retrieve the path to the root directory of the user's profile.
        if not GetUserProfileDirectoryW(h_token, sz_user_profile_dir, &cch_user_profile_dir):
            self._log.log_err(u"[pi_service] GetUserProfileDirectoryW: %d." % GetLastError())
            free(w_cmd)
            return False
        #sz_user_profile_dir = <bytes>u"C:\\pi_cython\\"
        self._log.log_debug(u"[pi_service] User Profile Directory: %s" % sz_user_profile_dir)
        self._log.log_debug(u"[pi_service] CreateProcessAsUserW: %s" % cmd)
        ret_val = CreateProcessAsUserW(
            h_token,
            NULL,                       # No module name (use command line)
            w_cmd,                      # Command line
            NULL,                       # Process handle not inheritable
            NULL,                       # Thread handle not inheritable
            False,                      # Set handle inheritance to FALSE
            create_flags,               # creation flags
            lp_environment,             # environment block
            <bytes>u"c:\\pi_cython",    # starting directory 
            &si,                        # Pointer to STARTUPINFOW structure
            &pi)                        # Pointer to PROCESS_INFORMATION structure
        if ret_val == False:
            self._log.log_err(u"[pi_service] CreateProcessAsUserW failed (%d)." % (GetLastError()))
            free(w_cmd)
            return False
        # Close process and thread handles. 
        CloseHandle(pi.hProcess)
        CloseHandle(pi.hThread)
        free(w_cmd)
        return True

    cdef int _execute(self, unicode cmd):
        cdef:
            STARTUPINFOW si
            PROCESS_INFORMATION pi
            bint ret_val = False
            DWORD create_flags = 0
            # ExitCode
            size_t length = len(cmd)
            wchar_t* w_cmd = <wchar_t*>malloc(32768)
            str key = ""
            unicode u_desktop = u'Default'
        for key in os.environ:
            cmd = cmd.replace(u"%%%s%%" % key.decode("utf-8"), os.environ[key].decode("utf-8"))
        self._log.log_debug(u"[pi_service _execute: %s" % (cmd))
        wcscpy_s(w_cmd, length * sizeof(wchar_t), <wchar_t*>cmd)
        SecureZeroMemory(&pi, sizeof(pi))
        SecureZeroMemory(&si, sizeof(si))
        si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW
        si.lpDesktop = <LPWSTR>u_desktop
        si.cb = sizeof(si)
        create_flags = CREATE_NEW_CONSOLE | CREATE_UNICODE_ENVIRONMENT
        ret_val = CreateProcessW(
            NULL,           # No module name (use command line)
            w_cmd,          # Command line
            NULL,           # Process handle not inheritable
            NULL,           # Thread handle not inheritable
            False,          # Set handle inheritance to FALSE
            create_flags,   # creation flags
            NULL,           # Use parent's environment block
            NULL,           # Use parent's starting directory 
            &si,            # Pointer to STARTUPINFOW structure
            &pi)            # Pointer to PROCESS_INFORMATION structure
        if ret_val == False:
            self._log.log_err(u"[pi_service] CreateProcess failed (%d)." % (GetLastError()))
            return False

        # Close process and thread handles. 
        CloseHandle(pi.hProcess)
        CloseHandle(pi.hThread)

        free(w_cmd)
        return True

    def _get_config_plugin(self, config_path):
        """
        returns None, if the plugin API-Version is incompatible or no plugin is cabable to handle the file extension.
        """
        file_name, file_extension = os.path.splitext(config_path)
        file_extension = file_extension[1:]
        config_plugin = self._config_plugins.get(file_extension, None)
        if config_plugin is None:
            return None
        highest_api_version = self._get_highest_supported_api_version(config_plugin.api_versions)
        if highest_api_version is None:
            return None
        return config_plugin

    def _connection_list_factory(self):
        """
        returns a ConnetionList instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        config_plugin = self._get_config_plugin(self._settings.connection_list)
        if config_plugin is None:
            return None
        return config_plugin.ConnectionList(self._settings.connection_list, self._plugins, self._log, self._status_handler)

    def _log_list_factory(self):
        """
        returns a LogList instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        config_plugin = self._get_config_plugin(self._settings.log_list)
        if config_plugin is None:
            return None
        log_plugins = get_log_plugins()
        return config_plugin.LogList(self._settings.log_list, log_plugins)

    def _host_list_factory(self):
        """
        returns a HostList instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        config_plugin = self._get_config_plugin(self._settings.host_list)
        if config_plugin is None:
            return None
        return config_plugin.HostList(self._settings.host_list, self._log)

    def _package_list_factory(self):
        """
        returns a PackageList instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        config_plugin = self._get_config_plugin(self._settings.package_list)
        if config_plugin is None:
            return None
        return config_plugin.PackageList(self._settings.package_list, self._connection_list, self._installed_list, self._log, self._status_handler)

    def _profile_list_factory(self):
        """
        returns a ProfileList instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        config_plugin = self._get_config_plugin(self._settings.profile_list)
        if config_plugin is None:
            return None
        return config_plugin.ProfileList(self._settings.profile_list, self._log)

    def _installed_list_factory(self):
        """
        returns a InstalledList instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        config_plugin = self._get_config_plugin(self._settings.installed_list)
        if config_plugin is None:
            return None
        return config_plugin.InstalledList(self._settings.installed_list, self._log)

    def _install_list_factory(self):
        """
        returns a InstallList instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        config_plugin = self._get_config_plugin(self._settings.install_list)
        if config_plugin is None:
            return None
        return config_plugin.InstallList(self._settings.install_list, self._connection_list, self._log)

    def _settings_factory(self, config_path=""):
        """
        returns a Settings instance, or None if the API-Version is incompatible, or no plugin is available to hanle toe file extension.
        """
        if config_path == "":
            config_path = os.path.abspath(get_settings_config_path())
        #print "Configuration path: %s" % config_path
        sys.stdout.flush()
        config_plugin = self._get_config_plugin(config_path)
        if config_plugin is None:
            return None
        return config_plugin.Settings(config_path)

    def _get_highest_supported_api_version(self, api_versions):
        """
        returns the highest supported API-Version, or None if  no API-Version is compatible.
        """
        highest_api_version = None
        for api_version in self._api_versions:
            if api_version in api_versions and api_version > highest_api_version:
                highest_api_version = api_version
        return highest_api_version

    def _initiate(self):
        cdef:
            int ret_value = 0
            DWORD dw_version = 0; 
            DWORD dw_major_version = 0
            DWORD dw_minor_version = 0
            DWORD dw_build = 0

        self._config_plugins = get_config_plugins()
        for file_extension, config_plugin in self._config_plugins.items():
            if not hasattr(config_plugin, "api_versions"):
                print "Error: api_versions is missing in %s" % config_plugin.__file__
                del self._config_plugins[file_extension]
                continue
            compatible = False
            for version in api_versions:
                if version in config_plugin.api_versions:
                    compatible = True
                    break
            if compatible == False:
                print "Error: plugin '%s' is incompatible!" % file_extension
                del self._config_plugins[file_extension]
        settings_path = os.path.join(get_application_path(), 'settings.path')
        self._settings = settings_factory(get_settings_config_path(settings_path))
        self._plugins = get_ph_plugins()

        log_targets = self._log_list_factory()
        log = Log(log_targets)
        self._log = log
        self._status_handler = StatusHandler(self)
        self._connection_list = self._connection_list_factory()
        self._installed_list = self._installed_list_factory()
        self._package_list = self._package_list_factory()
        self._profile_list = self._profile_list_factory()
        if self._settings.target_source == 'install_list':
            self._install_list = self._install_list_factory()
        elif self._settings.target_source == 'host_list':
            self._host_list = self._host_list_factory()
        if self._host_list is None and self._install_list is None:
            self._log.log_err("Either a host list nor a install list was found!")
            sys.exit(1)
        self._local_hostname = platform.node().decode("utf-8")
        #print self._settings.status_gui_cmd
        if self._settings.status_gui_cmd != '':
            self._status_gui = True
        self._interval = <DWORD>self._settings.interval

        #self._report_service_status(win32service.SERVICE_RUNNING)
        self._run = self._settings.run
        self._display_target = self._settings.display_target

        self._collate()

        #sys.exit(0)

    def _collate(self):
        if self._settings.target_source == 'host_list':
            self._get_packages_and_profiles()
        self._get_steps()

    cdef _send_proto_version(self):
        cdef bytes data = b""
        data = struct.pack('!B', self._version)
        self._send_data(data)

    cdef void _send_step_count(self):
        cdef bytes data = b""
        data = struct.pack('!B', self._steps)
        self._send_data(data)

    cdef public void _send_info(self, unicode msg, unsigned char msg_type):
        cdef:
            bytes b_msg = msg.encode("UTF-8")
            unsigned int text_length = <unsigned int>len(b_msg)
            bytes data = b""
        self._log.log_debug(u"Message: %s (%d)" % (msg, text_length))
        data = struct.pack('!BBI%ds' % text_length, SEND_INFO, msg_type, text_length, b_msg)
        self._log.log_debug(u"data length: %d" % len(data))
        self._send_data(data)

    cdef void _send_done(self):
        cdef bytes data = b""
        data = struct.pack('!B', SEND_DONE)
        self._send_data(data)

    def _send_status(self, unsigned char status, unicode package_id):
        cdef:
            size_t package_id_length = 0
            size_t package_name_length = 0
            unicode package_name = u''
            bytes b_package_id = package_id.encode('utf-8')
            bytes b_package_name = b''
            bytes data = b''

        if self._status_gui == False:
            self._log.log_debug(u"[pi_service] No status gui defined")
            return True
        #msg = msg.encode('ascii')
        self._log.log_info(u"[pi_service] [%d] sending '%d:%s' to status gui" % (libs.common.get_current_line_nr(), status, package_id))
        package_id_length = len(b_package_id)
        if package_id_length > 255:
            self._log.log_warn("[pi_service] package id to long!")
            package_id = package_id[:255]
        try:
            package_name = self._package_list[package_id].name
        except KeyError:
            pass
        b_package_name = package_name.encode('utf-8')
        package_name_length = len(b_package_name)
        if package_name_length > 255:
            self._log.log_warn("[pi_service] package name to long!")
            package_name = package_name[:255]
        self._log.log_err(u"[pi_service] %d package_id: %s(%d) package_name: %s(%d)" % (status, package_id, package_id_length, package_name, package_name_length))
        data = struct.pack('!BBB%dsB%ds' % (<unsigned char>package_id_length,  <unsigned char>package_name_length), SEND_STATUS, status, <unsigned char>package_id_length, b_package_id, package_name_length, b_package_name)
        #stdout_data, stderr_data = self._p.communicate(data)
        self._send_data(data)
        #self._p.stdin.write(data)
        #self._p.stdin.flush()

    def _handle_dependencies(self, package_id, action_list):
        """
        action_list = {
            [
                {   package_id:"winrar",
                    installed: False,
                }
            ]
        }
        """
        cdef:
            object package
            dict dependency
            unicode dep_package_id
        if package_id in self._package_list:
            package = self._package_list[package_id]
            for dependency in package.dependencies:
                if not "package_id" in dependency:
                    self._log.log_err(u"Error: package_id attribute is missing in dependency!")
                    continue
                if not "installed" in dependency:
                    self._log.log_err(u"Error: installed attribute is missing in dependency!")
                    continue
                dep_package_id = dependency["package_id"]
                self._handle_dependencies(dep_package_id, action_list)
                if dependency['installed'] == False:
                    dep_action = u"uninstall"
                elif dependency['installed'] == True:
                    dep_action = u"install"
                self._remove_packages_with_conflicting_dependencies(dep_package_id, dep_action, action_list)
                action_list.append({"package_id": dep_package_id, "action": dep_action})

    #def _remove_packages_with_broken_dependencies(self, package_id):
    def _remove_packages_with_conflicting_dependencies(self, unicode package_id, unicode action, action_list):
        cdef:
            dict dict_package
            object package
            dict dependency
            int index
            dict a_entry
        for dict_package in action_list:
            package = self._package_list[dict_package['package_id']]
            for dependency in package.dependencies:
                if package_id == dependency['package_id'] and dependency["installed"] == {u"install": False, u"uninstall": True}[action]:
                    for index in range(0, len(action_list)):
                        a_entry = action_list[index]
                        if a_entry["package_id"] == dependency["package_id"] and a_entry["action"]  == {True: u"install", False: u"uninstall"}[dependency["installed"]]:
                            del action_list[index]
                            index = index -1

    def add_dependencies_to_action_list(self, action_list):
        pass


    cdef bint _ip_in(self, list ip_list, host, ip_func):
        for ip in ip_list:
            #if ip_func(host, ip):
            if ip_func(ip):
                return True
        return False

    def _get_packages_and_profiles(self):
        self._packages = []
        self._profiles = []
        for host in self._host_list:
            if not self._ip_in(self._ip4_addresses, host, host.ipv4_is) and not self._ip_in(self._ip6_addresses, host, host.ipv6_is) and not host.hostname_is(self._local_hostname) and not host.workgroup_is(self._local_workgroup) and not host.domain_name_is(self._local_domain_name) and not host.forest_name_is(self._local_forest_name):
                continue
            for package in host.get_packages():
                #package = {'action': u'install', 'package_id': u'7zip'}
                self._handle_dependencies(package['package_id'], self._packages)
                self._packages.append(package)
            for profile in host.get_profiles():
                self._profiles.append(profile)

    def _get_steps(self):
        """
        step 1: launch the silent installer
        step 2: silent installer is done
        """
        cdef:
            object profile

        self._steps = <unsigned char>len(self._packages) * 2
        for profile in self._profiles:
            self._steps += <unsigned char>len(profile)

    def _install_packages(self, object packages):
        cdef:
            unsigned char status = 0
            unsigned long ret_code = 0
            object package
            object action
            object package_id
            object cmd_list
            unicode cmd = u""
            unicode file = u""
            unicode path = u""
            unicode cmd_info = u""

        for package in packages:
            package_id = package['package_id']
            action = package['action']
            self._log.log_debug(u"[pi_service] %s, %s" % (action, package_id))
            cmd_list = []
            try:
                #package_id = package['package_id']
                #action = package['action']
                self._log.log_info(u"[pi_service] [%d] %s %s" % (libs.common.get_current_line_nr(), package_id, action))
                if package_id in self._package_list.keys():
                    if action == 'install':
                        if self._status_gui:
                            self._send_status(INSTALLING, package_id)
                        ret_code, cmd_list = self._package_list.install(package_id)
                        self._log.log_info(u"[pi_service] [%d] %s - status %s" % (libs.common.get_current_line_nr(), package_id, ret_code))
                        if ret_code in (RET_CODE_SUCCESS, RET_CODE_ALREADY_INSTALLED):
                            status = INSTALLED
                        elif ret_code == RET_CODE_UNKNOWN:
                            status = UNKNOWN
                        else:
                            status = FAILED
                    elif action == 'upgrade':
                        if self._status_gui:
                            self._send_status(UPGRADING, package_id)
                        ret_code, cmd_list = self._package_list.upgrade(package_id)
                        self._log.log_info(u"[pi_service] [%d] %s - status %s" % (libs.common.get_current_line_nr(), package_id, ret_code))
                        if ret_code in (RET_CODE_SUCCESS, RET_CODE_ALREADY_INSTALLED):
                            status = UPGRADED
                        elif ret_code == RET_CODE_UNKNOWN:
                            status = UNKNOWN
                        else:
                            status = FAILED

                    elif action == 'remove' or action == 'uninstall':
                        if self._status_gui:
                            self._send_status(REMOVING, package_id)
                        ret_code, cmd_list = self._package_list.uninstall(package_id)
                        self._log.log_info(u"[pi_service] [%d] %s - status %s" % (libs.common.get_current_line_nr(), package_id, ret_code))
                        if ret_code in (RET_CODE_SUCCESS, RET_CODE_ALREADY_REMOVED):
                            status = REMOVED
                        elif ret_code == RET_CODE_UNKNOWN:
                            status = UNKNOWN
                        else:
                            status = FAILED
                    else:
                        self._log.log_err(u"[pi_service] [%d] Unknown action %s!" % (libs.common.get_current_line_nr(), action))
                        status = FAILED
                else:
                    self._log.log_err(u"[pi_service] [%d] Could not found package %s!" % (libs.common.get_current_line_nr(), package_id))
                    status = FAILED
                    ret_code = RET_CODE_PACKAGE_NOT_FOUND
                #print status, package_id
                if self._status_gui:
                    if ret_code != RET_CODE_PACKAGE_NOT_FOUND:
                        self._send_status(status, package_id)
                    if ret_code == RET_CODE_ALREADY_INSTALLED:
                        self._send_info(u"Already installed!", SEND_INFO_SUCCESS)
                    elif ret_code == RET_CODE_ALREADY_REMOVED:
                        self._send_info(u"Already removed!", SEND_INFO_SUCCESS)
                    elif ret_code == RET_CODE_PACKAGE_NOT_FOUND:
                        self._send_info(u"Package with id: %s not found!" % package_id, SEND_INFO_ERROR)
                    else:
                        self._send_info(u'Status Code: %d' % ret_code, SEND_INFO_ERROR)

                    if self._send_cmd_infos:
                        for entry in cmd_list:
                            cmd = entry[0]
                            exit_code = entry[1]
                            if self._send_cmd_full_path or cmd == "":
                                cmd_info = cmd
                            else:
                                path, file = os.path.split(libs.win.commandline.parse(cmd)[0])
                                cmd_info = file
                            self._send_info(u'%s: %d' % (cmd_info, exit_code), SEND_INFO_SUCCESS)
            #except ChecksumViolation, e:
                #if self._status_gui:
                    #self._send_status(FAILED, package_id)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: Checksum violation!"
            #except FileNotFound, e:
                #if self._status_gui:
                    #self._send_status(FAILED, package_id)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: ", e
            #except ConnectionError, e:
                #if self._status_gui:
                    #self._send_status(FAILED, package_id)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: ", e
            except (AuthenticationError, ConnectionError, FileNotFound, ChecksumViolation), e:
                if self._status_gui:
                    self._send_status(FAILED, package_id)
                    #self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)
                #print >>stderr, "Error: ", e
            except Exception as e:
                print str(e)
                print traceback.format_exc()
                if self._status_gui:
                    self._send_status(FAILED, package_id)
                    self._send_info(u"%s %s" % (package_id, str(e)), SEND_INFO_ERROR)

    def _install(self):
        cdef:
            object profile
            object action
            object package_id

        self._log.log_info(u"[pi_service] [%d] Target Source: %s" % (libs.common.get_current_line_nr(), self._settings.target_source))
        self._log.log_debug(u"[pi_service] target source: %s" % self._settings.target_source)
        # since version 0.2
        #if self._settings.target_source == 'host_list' and self._host is not None:
        if self._settings.target_source == 'host_list':
            self._install_packages(self._packages)
        # since version 0.1
        elif self._settings.target_source == 'install_list':
            self._install_packages(self._install_list)
        for profile_id in self._profiles:
            profile = self._profile_list[profile_id]
            self._send_info(u"Handling Profile: %s" % profile.id, SEND_INFO_SUCCESS)
            self._install_packages(profile.packages)

cdef bint execute(unicode cmd):
    cdef:
        STARTUPINFOW si
        PROCESS_INFORMATION pi
        bint ret_val = False
        DWORD create_flags = 0
        # ExitCode
        size_t length = len(cmd)
        wchar_t* w_cmd = <wchar_t*>malloc(32768)
        str key = ""
        unicode u_desktop = u'Default'

    wcscpy_s(w_cmd, length * sizeof(wchar_t), <wchar_t*>cmd)
    SecureZeroMemory(&pi, sizeof(pi))
    SecureZeroMemory(&si, sizeof(si))
    si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW
    si.lpDesktop = <LPWSTR>u_desktop
    si.cb = sizeof(si)
    create_flags = CREATE_NEW_CONSOLE | CREATE_UNICODE_ENVIRONMENT
    ret_val = CreateProcessW(
        NULL,           # No module name (use command line)
        w_cmd,          # Command line
        NULL,           # Process handle not inheritable
        NULL,           # Thread handle not inheritable
        False,          # Set handle inheritance to FALSE
        create_flags,   # creation flags
        NULL,           # Use parent's environment block
        NULL,           # Use parent's starting directory 
        &si,            # Pointer to STARTUPINFOW structure
        &pi)            # Pointer to PROCESS_INFORMATION structure
    if ret_val == False:
        print >>sys.stderr, u"CreateProcess failed (%d)." % (GetLastError())
        return False

    # Close process and thread handles. 
    CloseHandle(pi.hProcess)
    CloseHandle(pi.hThread)

    free(w_cmd)
    return True


def register_start_on(start_on):
    cdef:
        object local_statup_scripts_key
        object key_count
        object gen_keys
        object key
        int entry_number = 0
        int highest_entry = 0
        unsigned long long exec_time = 0x00000000
        object bin_path = os.path.join(get_application_path(), 'pi_service.exe')
        object parameters = "tues"

    global gpo_script_path

    if not libs.win.winreg.sub_key_exists("HKLM", gpo_script_path):
        cmd_reg_import = u'reg import "%s"' % os.path.join(get_application_path(), 'gpo_machine_scripts_skeleton.reg')
        print u"executing: %s" % cmd_reg_import
        execute(cmd_reg_import)
    local_statup_scripts_key = libs.win.winreg.Key("HKLM", r"%s\%s" % (gpo_script_path, start_on), "0")
    key_count = local_statup_scripts_key.get_key_count()
    gen_keys = local_statup_scripts_key.get_keys()

    if key_count > 0:
        for key in gen_keys:
            if 'Script' in key and key['Script'] == bin_path:
                return False
            entry_number = <int>int(key.name)
            if entry_number > highest_entry:
                highest_entry = key.name
        key = local_statup_scripts_key.create_key(str(entry_number))
    else:
        key = local_statup_scripts_key.create_key(entry_number)
    key.set_value("Script", libs.win.winreg.REG_SZ, bin_path)
    key.set_value("Parameters", libs.win.winreg.REG_SZ, parameters)
    key.set_value("ExecTime", libs.win.winreg.REG_QWORD, struct.pack("q", exec_time))
    return True


def register_start_onstartup():
    return register_start_on("Startup")


def register_start_onshutdown():
    return register_start_on("Shutdown")


def unregister_start_on(start_on):
    cdef:
        object local_statup_scripts_key
        object key_count
        object gen_keys
        object key
        object bin_path = os.path.join(get_application_path(), 'pi_service.exe')
        object script_path = os.path.join(get_application_path(), 'run.bat')

    global gpo_script_path

    if not libs.win.winreg.sub_key_exists("HKLM", gpo_script_path):
        print "nothing to do!"
        return True
    local_statup_scripts_key = libs.win.winreg.Key("HKLM", r"%s\%s" % (gpo_script_path, start_on), "0")
    key_count = local_statup_scripts_key.get_key_count()
    gen_keys = local_statup_scripts_key.get_keys()

    if key_count > 0:
        for key in gen_keys:
            print key.get_name()
            print key['Script'].data, script_path, bin_path
            print "Script" in key
            if 'Script' in key and key['Script'].is_value() and (key['Script'].data == bin_path or key['Script'].data == script_path):
                print "deleting key: %s" % key.get_name()
                del local_statup_scripts_key[key.get_name()]
                return True
    print "nothing to do!"
    return True


def unregister_start_onstartup():
    return unregister_start_on("Startup")


def unregister_start_onshutdown():
    return unregister_start_on("Shutdown")


def test():
    pi_service = PIService()
    pi_service.run()
    print "Done! :-D"
    sys.exit(0)


cdef main():
    cdef:
        PWSTR SERVICE_NAME = <LPWSTR>u"pi_service"

        # Displayed name of the service
        PWSTR SERVICE_DISPLAY_NAME = <LPWSTR>u"Package Installing Service"

        # Service start options.
        # =======================
        # SERVICE_AUTO_START
        # 0x00000002
        # A service started automatically by the service control manager during system startup. For more information, see Automatically Starting Services.
        #
        # SERVICE_BOOT_START
        # 0x00000000
        # A device driver started by the system loader. This value is valid only for driver services.
        #
        # SERVICE_DEMAND_START
        # 0x00000003
        # A service started by the service control manager when a process calls the StartService function. For more information, see Starting Services on Demand.
        #
        # SERVICE_DISABLED
        # 0x00000004
        # A service that cannot be started. Attempts to start the service result in the error code ERROR_SERVICE_DISABLED.
        #
        # SERVICE_SYSTEM_START
        # 0x00000001
        # A device driver started by the IoInitSystem function. This value is valid only for driver services.
        DWORD SERVICE_START_TYPE = SERVICE_AUTO_START

        # List of service dependencies - "dep1\0dep2\0\0"
        PWSTR SERVICE_DEPENDENCIES = u""

        # The name of the account under which the service should run. If this 
        # parameter is NULL, the service runs as the LocalSystem account. If the 
        # service wants to create an interactive process in a user session, the 
        # service must run in the LocalSystem account.
        PWSTR SERVICE_ACCOUNT = NULL

        # The password to the service account name
        PWSTR SERVICE_PASSWORD = NULL

    #sys.stdout = FileHandler(r"C:\pi_cython\log.out", 'w', encoding='utf-8')
    #sys.stderr = FileHandler(r"C:\pi_cython\log.err", 'w', encoding='utf-8')

    if len(sys.argv) > 1:
        if sys.argv[1] in ('test', 'tues'):
            test()
        elif sys.argv[1] == "install":
            if len(sys.argv) > 2:
                if sys.argv[2] == "shutdown":
                    register_start_onshutdown()
                elif sys.argv[2] == "startup":
                    register_start_onstartup()
            else:
                install_service(SERVICE_NAME, SERVICE_DISPLAY_NAME, SERVICE_START_TYPE, SERVICE_DEPENDENCIES, SERVICE_ACCOUNT, SERVICE_PASSWORD)
        elif sys.argv[1] == "uninstall":
            if len(sys.argv) > 2:
                if sys.argv[2] == "shutdown":
                    unregister_start_onshutdown()
                elif sys.argv[2] == "startup":
                    unregister_start_onstartup()
            else:
                uninstall_service(SERVICE_NAME)
    else:
        sys.stdout = FileHandler(r"C:\pi_cython\pi_service.out", 'w')
        sys.stderr = FileHandler(r"C:\pi_cython\pi_service.err", 'w')
        init_service()

    #sys.stdout = open(r"C:\alice.pi.log", "w")
    #sys.stdout = EventLog()
    #sys.stderr = EventLog(servicemanager.EVENTLOG_ERROR_TYPE)

    #sys.stdout = open(r"C:\pi.log.out", "a")
    #sys.stderr = open(r"C:\pi.log.err", "a")


if __name__ == '__main__':
    main()