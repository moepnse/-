# -*- coding: utf-8 -*-

import winreg

BROWSER_SERVICE_PATH = "SYSTEM\CurrentControlSet\Services\Browser\Parameters"

def set_is_domain_master(value="FALSE"):
    winreg.set_value("HKEY_LOCAL_MACHINE", BROWSER_SERVICE_PATH, "IsDomainMaster", winreg.REG_SZ, value.upper())

def set_maintain_service_list(value="FALSE"):
    winreg.set_value("HKEY_LOCAL_MACHINE", BROWSER_SERVICE_PATH, "MaintainServerList", winreg.REG_SZ, value.upper())