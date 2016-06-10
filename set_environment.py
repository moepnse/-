# -*- coding: utf-8 -*-

"""
modified version of win_add2path.py
"""

import os
import sys
import _winreg as winreg


HKLM = winreg.HKEY_LOCAL_MACHINE
ENV = "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"


def modify_env(key, variable_name, envpaths):
        try:
            envpath = winreg.QueryValueEx(key, variable_name)[0]
        except WindowsError:
            #envpath = u"%%%s%%" % variable_name
            envpath = u""

        paths = [envpath]
        for path in envpaths:
            if path and path not in envpath and os.path.isdir(path):
                paths.append(path)

        envpath = os.pathsep.join(paths)
        winreg.SetValueEx(key, variable_name, 0, winreg.REG_EXPAND_SZ, envpath)
        return paths, envpath


def main():
    python_path = os.path.dirname(os.path.normpath(sys.executable))
    scripts = os.path.join(python_path, "Scripts")
    with winreg.CreateKey(HKLM, ENV) as key:

        for variable_name in ("PATH", "PYTHONPATH"):
            paths, envpath = modify_env(key, variable_name, (python_path, scripts))
            if len(paths) > 1:
                print "Path(s) added:"
                print '\n'.join(paths[1:])
            else:
                print "No path was added"
            print "\n%s is now:\n%s\n" % (variable_name, envpath)
            print "Expanded:"
            print winreg.ExpandEnvironmentStrings(envpath)
        
        print "PYTHONHOME: %s" % python_path
        winreg.SetValueEx(key, "PYTHONHOME", 0, winreg.REG_EXPAND_SZ, python_path)


if __name__ == '__main__':
    main()
