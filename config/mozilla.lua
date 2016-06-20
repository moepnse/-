
do
    MFFESR_IN = [[smb://\\10.0.19.10\software\mffesr.ini]]
    MFFESR_EXE = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/38.2.0esr/win32/de/Firefox%20Setup%2038.2.0esr.exe"
    UNINSTALL_EXE = [["%PROGRAMFILES%\Mozilla Firefox\uninstall\helper.exe"]]
    UNINSTALL_EXE = [[file://"%PROGRAMFILES(X86)%\Mozilla Firefox\uninstall\helper.exe"]]
    UNINSTALL_SILENT = "/S"
    KILL_FF = "taskkill /F /IM firefox.exe"

    --install_cmds = {KILL_FF, MFFESR_EXE .. ' '.. MFFESR_IN}
    --upgrade_cmds = {KILL_FF, MFFESR_EXE .. ' '.. MFFESR_IN}
    --uninstall_cmds = {KILL_FF, UNINSTALL_EXE .. " " .. UNINSTALL_SILENT}

    KILL_FF_CMD = 
    {
        cmd = "file://taskkill",
        args = {
            {   parameter = [[/F]],
                values = {
                    {
                        "",
                        false
                    }
                }
            },
            {   parameter = [[/IM]],
                values = {
                    {
                        "firefox.exe",
                        false
                    }
                }
            }
        }
    }

    UNINSTALL_CMD = 
    {
        cmd = UNINSTALL_EXE,
        args = {
            {   parameter = [[/S]],
                values = {
                    {
                        "",
                        false
                    }
                }
            }
        }
    }

    INSTALL_CMD = 
    {
        cmd = MFFESR_EXE,
        args = {
            {   parameter = "/INI=",
                values = {
                    {
                        MFFESR_IN,
                        true
                    }
                }
            }
        }
    }

    install_cmds = {KILL_FF_CMD, INSTALL_CMD}
    upgrade_cmds = {KILL_FF_CMD, INSTALL_CMD}
    uninstall_cmds = {KILL_FF_CMD, UNINSTALL_CMD}

    register_package('firefox_esr', [[Mozilla Firefox]], "38.2.0", "1", is_in_software_list([[Mozilla Firefox [0-9\.]+]]), is_in_software_list([[Mozilla Firefox [0-9\.]+]]), install_cmds, upgrade_cmds, uninstall_cmds, "", {})
end

function firefox_esr_is_installed ()
    return is_in_software_list([[Mozilla Firefox [0-9\.]+]])
end

function firefox_esr_is_upgrade_avalaible ()
    return is_in_software_list([[Mozilla Firefox [0-9\.]+]])
end

set_package_check_functions('firefox_esr', 'firefox_esr_is_installed', 'firefox_esr_is_upgrade_avalaible')