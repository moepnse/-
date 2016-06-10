from c_windows_data_types cimport *
    
cdef extern from "nldef.h":
    ctypedef enum NL_PREFIX_ORIGIN:
        #
        # These values are from iptypes.h.
        # They need to fit in a 4 bit field.
        #
        IpPrefixOriginOther = 0,
        IpPrefixOriginManual,
        IpPrefixOriginWellKnown,
        IpPrefixOriginDhcp,
        IpPrefixOriginRouterAdvertisement,
        IpPrefixOriginUnchanged = 1 << 4
    
    ctypedef enum NL_SUFFIX_ORIGIN:
        #
        # TODO: Remove the Nlso* definitions.
        #
        NlsoOther = 0,
        NlsoManual,
        NlsoWellKnown,
        NlsoDhcp,
        NlsoLinkLayerAddress,
        NlsoRandom,

        #
        # These values are from in iptypes.h.
        # They need to fit in a 4 bit field.
        #
        IpSuffixOriginOther = 0,
        IpSuffixOriginManual,
        IpSuffixOriginWellKnown,
        IpSuffixOriginDhcp,
        IpSuffixOriginLinkLayerAddress,
        IpSuffixOriginRandom,
        IpSuffixOriginUnchanged = 1 << 4

    ctypedef enum NL_DAD_STATE:
        #
        # TODO: Remove the Nlds* definitions.
        #
        NldsInvalid,
        NldsTentative,
        NldsDuplicate,
        NldsDeprecated,
        NldsPreferred,

        #
        # These values are from in iptypes.h.
        #
        IpDadStateInvalid  = 0,
        IpDadStateTentative,
        IpDadStateDuplicate,
        IpDadStateDeprecated,
        IpDadStatePreferred,