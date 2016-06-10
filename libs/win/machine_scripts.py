# -*- coding: utf-8 -*-

import winreg
#from numpy import int64
import ConfigParser

"""
class ShutdownScripts(object):
    def __init__(self, list=[]):
        self._list = list
        self._key = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown", "0")

        for sub_key in self._key:
            if isinstance(sub_key, winreg.Key):
                self._list.append(int(sub_key.get_name()))

        self._list.sort()
    def add_script(self, script="blah"):
        self._list.append(self._list[-1]+1)
"""

def create_local_gpo():
    #key = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State", "Machine")
    key = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System", "Scripts")
    #if not winreg.sub_key_exists("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts"):
    if not winreg.sub_key_exists("HKEY_LOCAL_MACHINE", "SOFTWARE\Policies\Microsoft\Windows\System\Scripts"):
        key1 = key.create_key("Scripts")
    else:
        #key1 = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine", "Scripts")
        key1 = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System", "Scripts")

    #if not winreg.sub_key_exists("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown"):
    if not winreg.sub_key_exists("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System\Scripts\Shutdown"):
        key2 = key1.create_key("Shutdown")
    else:
        #key2 = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts", "Shutdown")
        key2 = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System\Scripts", "Shutdown")

    #if not winreg.sub_key_exists("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown\0"):
    if not winreg.sub_key_exists("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System\Scripts\Shutdown\0"):
        key3 = key2.create_key("Shutdown")

        key3.create_value("GPO-ID", winreg.REG_SZ, "LocalGPO")
        key3.create_value("SOM-ID", winreg.REG_SZ, "Local")
        key3.create_value("FileSysPath", winreg.REG_SZ, "C:\\WINDOWS\\System32\\GroupPolicy\\Machine")
        key3.create_value("DisplayName", winreg.REG_SZ, "Richtlinien der lokalen Gruppe")
        key3.create_value("DisplayName", winreg.REG_SZ, "Richtlinien der lokalen Gruppe")
    else:
        #key3 = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown", "0")
        key3 = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System\Scripts\Shutdown", "0")

class ShutdownScript(object):
    def __init__(self, nr, script, parameters, exec_time=chr(0)*16):
        self._nr = nr
        self._script = script
        self._parameters = parameters
        self._exec_time = exec_time


class ShutdownScriptsFromRegistry(object):
    def __init__(self):
        self._scripts = []
        self._index = -1

        create_local_gpo()

        #self._key = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown", "0")
        self._key = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System\Scripts\Shutdown", "0")

        self._next_script_nr = 0
        for sub_key in self._key:
            if isinstance(sub_key, winreg.Key):

                key_nr = int(sub_key.get_name())

                if self._next_script_nr < key_nr:
                    self._next_script_nr = key_nr

                script = sub_key["Script"].data
                parameters = sub_key["Parameters"].data
                exec_time = sub_key["ExecTime"].data
                self._scripts.append(ShutdownScript(key_nr, script, parameters, exec_time))

    def add_script(self, script, parameters="", exec_time=chr(0)*16):
        key = self._key.create_key(str(self._next_script_nr))
        key.set_value("Script", winreg.REG_SZ, script)
        key.set_value("Parameters", winreg.REG_SZ, parameters)
        key.set_value("ExecTime", winreg.REG_QWORD, exec_time)

        self._next_script_nr += 1

        return ShutdownScript(key, script, parameters, exec_time)

    def remove_script(self, script_name):
        for script in self:
            if script == script_name:
                self._key.delete_key(str(script._nr))

    def __iter__(self):
        self._index = -1
        return self

    def next(self):
        self._index += 1
        if not self._index < len(self._scripts):
            raise StopIteration
        return self._scripts[self._index]


class ShutdownScriptsFromINI(object):

    _scripts = []

    def __init__(self):
        fp = open(r'C:\WINDOWS\system32\GroupPolicy\Machine\Scripts\scripts.ini', 'rb')
        fp.readline()

        self._config = ConfigParser.ConfigParser()
        try:
            self._config.readfp(fp)
        except, ConfigParser.MissingSectionHeaderError: 
            self._config.add_section('Shutdown')

        #print config.get("Shutdown", "0CmdLine")
        next_nr = 0
        for item in self._config.items("Shutdown"):
            number = ""
            key = ""
            find_number = True
            for char in item[0]:
                if find_number == True:
                    if char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]:
                        number += char
                    else:
                        find_number = False
                        key = char
                else:
                    key += char

                if key.lower() == "script":
                    script = item[1]
                elif key.lower() == "parameters":
                    parameters = item[1]

            nr = int(puffer)
            if nr > next_nr:
                next_nr = nr

            self._scripts.append(ShutdownScript(key_nr, script, parameters))

        #print next_nr
        fp.close()

    def add_script(self, script, parameters=""):
        self._config.set('Shutdown', 'script', script)
        self._config.set('Shutdown', 'parameters', parameters)

    def remove_script(self, script_path):
        for script inself.:
            if script._script == script_path
                try:
                    self._config.remove_option("Shutdown", "%sscript" % script._nr)
                    self._config.remove_option("Shutdown", "%sparameters" % script._nr)
                except:
                    pass

    def __del__(self)
        fp = open(r'C:\WINDOWS\system32\GroupPolicy\Machine\Scripts\scripts.ini', 'wb')
        self._config.write(fp)
        fp.close()

    def __iter__(self):
        self._index = -1
        return self

    def next(self):

        self._index += 1
        if not self._index < len(self._scripts):
            raise StopIteration

        return self._scripts[self._index]

class ShutdownScripts(object):
    def __init__(self):

        self._scripts = []
        self._index = -1

        create_local_gpo()

        #self._key = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown", "0")
        self._key = winreg.Key("HKEY_LOCAL_MACHINE", r"SOFTWARE\Policies\Microsoft\Windows\System\Scripts\Shutdown", "0")

        self._next_script_nr = 0
        for sub_key in self._key:
            if isinstance(sub_key, winreg.Key):

                key_nr = int(sub_key.get_name())

                if self._next_script_nr < key_nr:
                    self._next_script_nr = key_nr

                script = sub_key["Script"].data
                parameters = sub_key["Parameters"].data
                exec_time = sub_key["ExecTime"].data
                self._scripts.append(ShutdownScript(self._key, key_nr, script, parameters, exec_time))

    def add_script(self, script, parameters="", exec_time=chr(0)*16):
        key = self._key.create_key(str(self._next_script_nr))
        key.set_value("Script", winreg.REG_SZ, script)
        key.set_value("Parameters", winreg.REG_SZ, parameters)
        key.set_value("ExecTime", winreg.REG_QWORD, exec_time)

        self._next_script_nr += 1

        return ShutdownScript(key, script, parameters, exec_time)

    def remove_script(self, script_name):
        for script in self:
            if script == script_name:
                self._key.delete_key(str(script._nr))

    def __iter__(self):
        self._index = -1
        return self

    def next(self):

        self._index += 1
        if not self._index < len(self._scripts):
            raise StopIteration

        return self._scripts[self._index]

if __name__ == "__main__":
    #for char in winreg.get_value("HKEY_LOCAL_MACHINE", r"SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine\Scripts\Shutdown\0\0", "ExecTime").data:
    #    print ord(char)
    shutdown_scripts = ShutdownScripts()
    #shutdown_script.add_script(r"c:\test.bat")

    for script in shutdown_scripts:
        print script._script