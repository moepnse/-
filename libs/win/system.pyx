# -*- coding: utf-8 -*-

# standard library imports

# third party imports

# application/library imports
import winreg

# application/library cimports
from c_windows_data_types cimport PBYTE, PDWORD, DWORD, wchar_t
from c_windows cimport ComputerNameNetBIOS, ComputerNameDnsHostname, ComputerNameDnsDomain, ComputerNameDnsFullyQualified, ComputerNamePhysicalNetBIOS, ComputerNamePhysicalDnsHostname, ComputerNamePhysicalDnsDomain, ComputerNamePhysicalDnsFullyQualified, GetComputerNameW, GetComputerNameExW, DSROLE_PRIMARY_DOMAIN_INFO_BASIC, DsRoleGetPrimaryDomainInformation, DsRoleGetPrimaryDomainInformation, DsRolePrimaryDomainInfoBasic, GetLastError, ERROR_SUCCESS, COMPUTER_NAME_FORMAT


def get_arch():
    IF UNAME_SYSNAME == "Windows":
        value = winreg.get_value("HKEY_LOCAL_MACHINE", r"SYSTEM\CurrentControlSet\Control\Session Manager\Environment", "PROCESSOR_ARCHITECTURE")
        return value.data
    return ""


IF UNAME_SYSNAME == "Windows":
    cdef bint _get_domain_info(DSROLE_PRIMARY_DOMAIN_INFO_BASIC **info):
        cdef:
            DWORD dw

        dw = DsRoleGetPrimaryDomainInformation(NULL, DsRolePrimaryDomainInfoBasic, <PBYTE *>info)
        if dw != ERROR_SUCCESS:
            #print >>sys.stderr, "DsRoleGetPrimaryDomainInformation() failed with error code: %d" % GetLastError())
            return False
        return True


def get_domain_info():
    cdef:
        IF UNAME_SYSNAME == "Windows":
            DSROLE_PRIMARY_DOMAIN_INFO_BASIC *info
        unicode workgroup = u""
        unicode domain_name = u""
        unicode forest_name = u""

    IF UNAME_SYSNAME == "Windows":
        _get_domain_info(&info)

        if info.DomainNameDns != NULL:
            domain_name = <unicode>info.DomainNameDns

        if info.DomainForestName != NULL:
            forest_name = <unicode>info.DomainForestName

        workgroup = <unicode>info.DomainNameFlat
    return workgroup, domain_name, forest_name


def get_computer_name():
    cdef:
        IF UNAME_SYSNAME == "Windows":
            #wchar_t w_computer_name[MAX_COMPUTERNAME_LENGTH + 1]
            #DWORD dw_size = MAX_COMPUTERNAME_LENGTH
            wchar_t w_computer_name[32]
            DWORD dw_size = 31
        unicode computer_name = u""
    IF UNAME_SYSNAME == "Windows":
        GetComputerNameW(w_computer_name, &dw_size)
    return computer_name


def get_computer_name_ex():
    cdef:
        #wchar_t w_computer_name[MAX_COMPUTERNAME_LENGTH + 1]
        #DWORD dw_size = MAX_COMPUTERNAME_LENGTH
        wchar_t w_buffer[256]
        DWORD dw_size = sizeof(w_buffer)
        # does not work since cython 0.23:
        #dict formats = {
        #    ComputerNameNetBIOS: "computer_name_net_bios",
        #    ComputerNameDnsHostname: "computer_name_dns_hostname",
        #    ComputerNameDnsDomain: "computer_name_dns_domain",
        #    ComputerNameDnsFullyQualified: "computer_name_dns_fully_qualified",
        #    ComputerNamePhysicalNetBIOS: "computer_name_physical_net_bios",
        #    ComputerNamePhysicalDnsHostname: "computer_name_physical_dns_hostname",
        #    ComputerNamePhysicalDnsDomain: "computer_name_physical_dns_Domain",
        #    ComputerNamePhysicalDnsFullyQualified: "computer_name_physical_dns_fully_qualified"
        #},
        # workaround:
        dict formats = {
            0: "computer_name_net_bios",
            1: "computer_name_dns_hostname",
            2: "computer_name_dns_domain",
            3: "computer_name_dns_fully_qualified",
            4: "computer_name_physical_net_bios",
            5: "computer_name_physical_dns_hostname",
            6: "computer_name_physical_dns_Domain",
            7: "computer_name_physical_dns_fully_qualified"
        },
        int format,
        dict return_value = {}
    """
    BOOL WINAPI GetComputerNameEx(
      _In_    COMPUTER_NAME_FORMAT NameType,
      _Out_   LPTSTR               lpBuffer,
      _Inout_ LPDWORD              lpnSize
    );

    ComputerNameDnsDomain:
    The name of the DNS domain assigned to the local computer. If the local computer is a node in a cluster, lpBuffer receives the DNS domain name of the cluster virtual server.


    ComputerNameDnsFullyQualified:
    The fully qualified DNS name that uniquely identifies the local computer. This name is a combination of the DNS host name and the DNS domain name, using the form HostName.DomainName. If the local computer is a node in a cluster, lpBuffer receives the fully qualified DNS name of the cluster virtual server.


    ComputerNameDnsHostname:
    The DNS host name of the local computer. If the local computer is a node in a cluster, lpBuffer receives the DNS host name of the cluster virtual server.


    ComputerNameNetBIOS:
    The NetBIOS name of the local computer. If the local computer is a node in a cluster, lpBuffer receives the NetBIOS name of the cluster virtual server.


    ComputerNamePhysicalDnsDomain:
    The name of the DNS domain assigned to the local computer. If the local computer is a node in a cluster, lpBuffer receives the DNS domain name of the local computer, not the name of the cluster virtual server.


    ComputerNamePhysicalDnsFullyQualified:
    The fully qualified DNS name that uniquely identifies the computer. If the local computer is a node in a cluster, lpBuffer receives the fully qualified DNS name of the local computer, not the name of the cluster virtual server.

    The fully qualified DNS name is a combination of the DNS host name and the DNS domain name, using the form HostName.DomainName.


    ComputerNamePhysicalDnsHostname:
    The DNS host name of the local computer. If the local computer is a node in a cluster, lpBuffer receives the DNS host name of the local computer, not the name of the cluster virtual server.


    ComputerNamePhysicalNetBIOS:
    The NetBIOS name of the local computer. If the local computer is a node in a cluster, lpBuffer receives the NetBIOS name of the local computer, not the name of the cluster virtual server.    
    """

    IF UNAME_SYSNAME == "Windows":
        for format in formats:
            GetComputerNameExW(<COMPUTER_NAME_FORMAT>format, w_buffer, &dw_size)
            return_value[formats[format]] = unicode(w_buffer)

    return return_value


if __name__ == '__main__':
    print get_arch() 
