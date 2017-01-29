
function firefox_esr_is_installed ()
    return is_in_software_list([[Mozilla Firefox [0-9\.]+ ESR]])
end

function firefox_esr_is_upgrade_avalaible ()
    for installed_software in software_list2() do
        if startswith(installed_software['display_name'], [[Mozilla Firefox]]) then
            tmp = split(installed_software['display_name'], " ")
            if tmp[3] == "ESR" then
                tmp2 = split(tmp[2], ".")
                version_major = tonumber(tmp2[0])
                version_minor = tonumber(tmp2[1])
                version = tonumber(tmp2[2])
                if version_major < 45 or (version_major == 45 and version_minor < 2) or (version_major == 45 and version_minor == 2 and version < 0) then
                    return true
                end
            end
        end
    end
    return false
end

do
    --MFFESR_IN = [[smb://\\10.0.19.10\software\mffesr.ini]]
    MFFESR_IN = [[http://packages.unicom.ws/arch/noarch/mffesr.ini]]
    MFFESR_EXE = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/45.2.0esr/win32/en-US/Firefox%20Setup%2045.2.0esr.exe"
    UNINSTALL_EXE = [["%PROGRAMFILES%\Mozilla Firefox\uninstall\helper.exe"]]
    UNINSTALL_EXE = [["file://%PROGRAMFILES(X86)%\Mozilla Firefox\uninstall\helper.exe"]]
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
            },
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

    install_cmds = {KILL_FF_CMD, INSTALL_CMD}
    upgrade_cmds = {KILL_FF_CMD, INSTALL_CMD}
    uninstall_cmds = {KILL_FF_CMD, UNINSTALL_CMD}

    register_package('firefox_esr', [[Mozilla Firefox]], "45.2.0", "1", firefox_esr_is_installed(), firefox_esr_is_upgrade_avalaible(), install_cmds, upgrade_cmds, uninstall_cmds, "", {}, "", "", {{package_id = "firefox", installed = false}})
end

set_package_check_functions('firefox_esr', 'firefox_esr_is_installed', 'firefox_esr_is_upgrade_avalaible')

function firefox_is_installed ()
    return is_in_software_list([[Mozilla Firefox [0-9\.]+]])
end

function firefox_is_upgrade_avalaible ()
    for installed_software in software_list2() do
        if startswith(installed_software['display_name'], [[Mozilla Firefox]]) then
            tmp = split(installed_software['display_name'], " ")
            tmp2 = split(tmp[2], ".")
            version_major = tonumber(tmp2[0])
            version_minor = tonumber(tmp2[1])
            version = tonumber(tmp2[2])
            if version_major < 50 then
                return true
            end
        end
    end
    return false
end

do
    --MFFESR_IN = [[smb://\\10.0.19.10\software\mffesr.ini]]
    MFF_INI = [[http://packages.unicom.ws/arch/noarch/mffesr.ini]]
    MFF_EXE = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/50.0/win32/en-US/Firefox%20Setup%2050.0.exe"
    UNINSTALL_EXE = [["%PROGRAMFILES%\Mozilla Firefox\uninstall\helper.exe"]]
    UNINSTALL_EXE = [["file://%PROGRAMFILES(X86)%\Mozilla Firefox\uninstall\helper.exe"]]
    UNINSTALL_SILENT = "/S"
    KILL_FF = "taskkill /F /IM firefox.exe"

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
        cmd = MFF_EXE,
        args = {
            {   parameter = "/INI=",
                values = {
                    {
                        MFF_INI,
                        true
                    }
                }
            },
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

    install_cmds = {KILL_FF_CMD, INSTALL_CMD}
    upgrade_cmds = {KILL_FF_CMD, INSTALL_CMD}
    uninstall_cmds = {KILL_FF_CMD, UNINSTALL_CMD}

    register_package('firefox', [[Mozilla Firefox]], "50.0.0", "1", firefox_is_installed(), firefox_is_upgrade_avalaible(), install_cmds, upgrade_cmds, uninstall_cmds, "", {}, "", "", {{package_id = "firefox_esr", installed = false}})
end

set_package_check_functions('firefox', 'firefox_is_installed', 'firefox_is_upgrade_avalaible')

do
    local _packages = {
        {   package_id = "thunderbird",
            name = "Thunderbird",
            version = "45.7.0",
            rev = 0,
            uninstall_cmds = 
                {
                    {
                        cmd = [["file://%PROGRAMFILES(X86)%\Mozilla Thunderbird\uninstall\helper.exe"]],
                        args = {
                            {   parameter = "/S",
                                values = {
                                    {
                                        "",
                                        false
                                    }
                                }
                            }
                        }
                    }
                },
            install_cmds = 
                {
                    {
                        cmd = "https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/45.7.0/win32/de/Thunderbird%20Setup%2045.7.0.exe",
                        args = {
                            {   parameter = "/ms",
                                values = {
                                    {
                                        "",
                                        false
                                    }
                                }
                            }
                        }
                    }
                },
            is_installed = 
                function()
                    return is_in_software_list([[^Thunderbird]])
                end,
            is_upgrade_available = function()
                local installed, version, rev = is_in_installed_list("thunderbird")
                if installed and (version < "45.7.0" or (version == "45.7.8" and rev < "0")) then
                    return true
                end
                return false
            end,
            dependencies = {
            },
            keywords = {
                "mail", "e-mail"
            },
            description = "Mozilla Thunderbird is a free,open source, cross-platform email, news, RSS, and chat client.",
            ret_codes = windows_error_codes
        },
    }
    for k,v in ipairs(_packages) do
      table.insert(packages, v)
    end
end