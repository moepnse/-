from c_windows_data_types cimport *
from c_winsock2 cimport SOCKADDR
from c_iptypes cimport PIP_ADAPTER_ADDRESSES, PIP_ADAPTER_ADDRESSES_LH, PIP_ADAPTER_ADDRESSES_XP

cdef extern from "iphlpapi.h":

    #
    # The following functions require Winsock2.
    #

    ULONG GetAdaptersAddresses(
        ULONG Family,
        ULONG Flags,
        PVOID Reserved,
        PIP_ADAPTER_ADDRESSES_LH AdapterAddresses, 
        PULONG SizePointer
    ) nogil