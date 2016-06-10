# -*- coding: utf-8 -*-

import uuid

import winreg

POLICIES_SYSTEM_PATH = "SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system"
POLICIES_EXPLORER_PATH = "SOFTWARE\Microsoft\Windows\CurrentVersion\policies\explorer"

# Constants for set_no_drive_type_auto_run
UNKNOWN_DRIVES = 1
REMOVABLE_DRIVES = 4
FIXED_DRIVERS = 8
NETWORK_DRIVES = 16
CD_ROM_DRIVES = 32
RAM_DISKS = 64
ALL_TYPES_OF_DRIVES = 255

# Constants for set_no_drive_auto_run
ALL_DRIVES = 67108863

PREFETCH_DISABLED = 0
PREFETCH_FOR_APPLICATIONS = 1
PREFETCH_FOR_BOOT = 2
PREFETCH_FOR_ALL = 3

BOOT_OPTIMIZE_ENABLE = "Y"
BOOT_OPTIMIZE_DISABLE = "N"

CLASSIC_MODE = 0
WELCOME_SCREEN = 1

UNRESTRICTED = 40000
DISALLOWED = 0

NO_ENFORCMENT = 0
SKIP_DLLS = 1
ALL_FILES = 2

ALL_USERS = 0
SKIP_ADMINISTRATORS = 1

def set_dont_display_last_username(value=1):
    winreg.set_value("HKEY_LOCAL_MACHINE", POLICIES_SYSTEM_PATH, "dontdisplaylastusername", winreg.REG_DWORD, value)

def set_hide_startup_scripts(value=1):
    winreg.set_value("HKEY_LOCAL_MACHINE", POLICIES_SYSTEM_PATH, "HideStartupScripts", winreg.REG_DWORD, value)

def set_hide_shutdown_scripts(value=1):
    winreg.set_value("HKEY_LOCAL_MACHINE", POLICIES_SYSTEM_PATH, "HideShutdownScripts", winreg.REG_DWORD, value)

def set_no_autorun(value=True):
    if vlaue == True:
        set_no_drive_type_auto_run(ALL_TYPES_OF_DRIVES)
        set_no_drive_auto_run(ALL_DRIVES)
    else:
        set_no_drive_type_auto_run(0)
        set_no_drive_auto_run(147)

def set_no_drive_type_auto_run(value=ALL_TYPES_OF_DRIVES):
    # 000000ff == 255
    winreg.set_value("HKEY_LOCAL_MACHINE", POLICIES_EXPLORER_PATH, "NoDriveTypeAutoRun", winreg.REG_DWORD, value)

def set_no_drive_auto_run(value=ALL_DRIVES):
    # 03ffffff == 67108863
    winreg.set_value("HKEY_LOCAL_MACHINE", POLICIES_EXPLORER_PATH, "NoDriveAutoRun", winreg.REG_DWORD, value)

def set_allow_rdp(value=0):
    winreg.set_value("HKEY_LOCAL_MACHINE", "SYSTEM\CurrentControlSet\Control\Terminal Server", "fDenyTSConnections", winreg.REG_DWORD, value)

def set_prefetch(value=PREFETCH_FOR_BOOT):
    """
    0 - Funktion ist abgestellt
    1 - Prefetch nur für Anwendungen
    2 - Nur für den Boot-Vorgang
    3 - Prefetching für beide
    """
    winreg.set_value("HKEY_LOCAL_MACHINE", r"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management", "Prefetch Parameters", winreg.REG_DWORD, value)

def set_boot_optimize(value=BOOT_OPTIMIZE_ENABLE):
    winreg.set_value("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction", "Enable", winreg.REG_SZ, value)


"""
 - {GUID}. This is uniquely generated for each Rule defined.
    - Description (REG_SZ). This is an administrator defined description of the rule.
    - ItemData (REG_EXPAND_SZ Or REG_SZ). This is the path to be used for this rule. Note that if the data provided for this value includes any environment variables that must be expanded the value type will be REG_EXPAND_SZ otherwise it will be REG_SZ.
    - LastModified (REG_QWORD). This is the date and time down to seconds of when this entry was last updated. Several utilities exits to extract this name into a readable format however just as the ItemSize data was reversed so should this value.
    - SaferFlags (REG_DWORD). This is not used and will always be set to zero.
"""

class SoftwareRestriction(object):

    def __init__(self, default_level=None):
        if default_level == None:
            default_level = 262144
        self._default_level = default_level

    def set_default_level(self, level):
        winreg.set_value("HKEY_LOCAL_MACHINE", "SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers", "DefaultLevel", winreg.REG_DWORD, level)

    def transparent_enabled(self, value=NO_ENFORCMENT):
        winreg.set_value("HKEY_LOCAL_MACHINE", "SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers", "TransparentEnabled", winreg.REG_DWORD, value)

    def set_policy_scope(self, scope=SKIP_ADMINISTRATORS):
        # HKLM only
        winreg.set_value("HKEY_LOCAL_MACHINE", "SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers", "PolicyScope", winreg.REG_DWORD, scope)

    def get_policies(self):
        for policy in winreg.get_keys(r"HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\%s\paths" % self._default_level):
            print policy.name
            print policy.ItemData.data

    def add_policy(self, path, description=""):
        for policy in winreg.get_keys(r"HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\%s\paths" % self._default_level):
            if path == policy.ItemData.data:
                return False
        new_uuid = "{%s}" % uuid.uuid1()
        key = r"SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers\%s\paths\%s" % (self._default_level, new_uuid)
        winreg.set_value(r"HKEY_LOCAL_MACHINE", key, "ItemData", winreg.REG_EXPAND_SZ, path)
        winreg.set_value(r"HKEY_LOCAL_MACHINE", key, "Description", winreg.REG_SZ, description)
        winreg.set_value(r"HKEY_LOCAL_MACHINE", key, "SaferFlags", winreg.REG_DWORD, 0)
        winreg.set_value(r"HKEY_LOCAL_MACHINE", key, "LastModified", winreg.REG_QWORD, "0")

        return True

    def add_policies(self, policies=[]):
        for policy in policies:
            path = policy["path"]
            description = policy["description"]
            self.add_policy(path, description)

    def load_policies_from_file(self, path):
        if not os.path.isfile(path):
            return False
        fh = open(path, 'r')
        for line in fh:
            self.add_policy(line)