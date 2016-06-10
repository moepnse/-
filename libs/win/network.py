# -*- coding: utf-8 -*-

import winreg

TCPIP_PARAMETERS_PATH = "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
AFD_PARAMETERS_PATH = "SYSTEM\CurrentControlSet\Services\Afd\Parameters"

def set_tcp_window_size(value=65535):
    winreg.set_value("HKEY_LOCAL_MACHINE", TCPIP_PARAMETERS_PATH, "TcpWindowSize", winreg.REG_DWORD, value)

def set_default_receive_window(value=65535):
    winreg.set_value("HKEY_LOCAL_MACHINE",AFD_PARAMETERS_PATH, "DefaultReceiveWindow", winreg.REG_DWORD, value)

def set_default_send_window(value=65535):
    winreg.set_value("HKEY_LOCAL_MACHINE",AFD_PARAMETERS_PATH, "DefaultSendWindow", winreg.REG_DWORD, value)

def set_tcp_1323_opts(value=3):
    winreg.set_value("HKEY_LOCAL_MACHINE", TCPIP_PARAMETERS_PATH, "Tcp1323Opts", winreg.REG_DWORD, value)

def set_enable_pmtu_discovery(value=1):
    winreg.set_value("HKEY_LOCAL_MACHINE", TCPIP_PARAMETERS_PATH, "EnablePMTUDiscovery", winreg.REG_DWORD, value)

def set_enable_pmtubh_detect(value=1):
    winreg.set_value("HKEY_LOCAL_MACHINE", TCPIP_PARAMETERS_PATH, "EnablePMTUBHDetect", winreg.REG_DWORD, value)

def set_tcp_num_connections(value=10000):
    winreg.set_value("HKEY_LOCAL_MACHINE", TCPIP_PARAMETERS_PATH, "TcpNumConnections", winreg.REG_DWORD, value)


class NetworkCard(object):
    def __init__(self, card_nr, description, guid):
        self.card_nr = card_nr
        self.description = description
        self.guid = guid

        if winreg.sub_key_exists("HKEY_LOCAL_MACHINE", "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%s" % guid) == False:
            raise winreg.KeyNotFound("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%s" % guid)

            self._key = Key("HKEY_LOCAL_MACHINE",  "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces", guid)

    def _set_tcp_ack_frequency(self, value):
        winreg.set_value("HKEY_LOCAL_MACHINE", "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%s" % self.guid, "TcpAckFrequency", winreg.REG_DWORD, value)

    def __getitem__(self, name):
            'Return the Value'
            return self._key[name]


def get_network_cards():
    for network_card in winreg.get_keys("HKEY_LOCAL_MACHINE", "SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards"):
        card_nr = network_card.name
        description = network_card.Description.data
        guid = network_card.ServiceName.data

        yield NetworkCard(card_nr, description, guid)
