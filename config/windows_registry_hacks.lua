do
    local _packages = {
        {   package_id = "disable_autorun",
            version = "1",
            rev = 0,
            is_installed =
                function()
                    error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE, [[SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDriveAutoRun")
                    if error_code == 0 and value == 255 then
                        return true
                    else
                        return false
                    end
                end,
            install_cmds = {
                function()
                    return winreg_set_value(HKEY_LOCAL_MACHINE, [[SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDriveAutoRun",  REG_DWORD, 255)
                end
            }
        },
        {   package_id = "hide_drives_a_and_e",
            version = "1",
            rev = 0,
            is_installed =
                function()
                    error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE, [[Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDrives")
                    if error_code == 0 and value == 17 then
                        return true
                    else
                        return false
                    end
                end,
            install_cmds = {
                function()
                    return winreg_set_value(HKEY_LOCAL_MACHINE, [[Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDrives",  REG_DWORD, 17)
                end
            }
        },
        {   package_id = "add_encryption_to_context_menu",
            version = "1",
            rev = 0,
            is_installed =
                function()
                    error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE, [[Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]], "EncryptionContextMenu")
                    if error_code == 0 and value == 1 then
                        return true
                    else
                        return false
                    end
                end,
            install_cmds = {
                function()
                    return winreg_set_value(HKEY_LOCAL_MACHINE, [[Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]], "EncryptionContextMenu",  REG_DWORD, 1)
                end
            },
            ret_codes = windows_error_codes
        },
        {   package_id = "jump_directly_to_select_a_program_from_a_list_of_installed_programs",
            version = "1",
            rev = 0,
            is_installed =
                function()
                    error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoInternetOpenWith")
                    if error_code == 0 and value == 1 then
                        return true
                    else
                        return false
                    end
                end,
            install_cmds = {
                function()
                    return winreg_set_value(HKEY_LOCAL_MACHINE, [[SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoInternetOpenWith",  REG_DWORD, 1)
                end
            },
            ret_codes = windows_error_codes
        },
        {   package_id = "disable_autoreboot_after_update",
            version = "1",
            rev = 0,
            is_installed =
                function()
                    error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE, [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAutoRebootWithLoggedOnUsers")
                    print(tostring(error_code) .. " " .. tostring(value_type) .. " " .. tostring(value))
                    if error_code == 0 and value == 1 then
                        return true
                    else
                        return false
                    end
                end,
            install_cmds = {
                function()
                    return winreg_set_value(HKEY_LOCAL_MACHINE, [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAutoRebootWithLoggedOnUsers",  REG_DWORD, 1)
                end
            },
            ret_codes = windows_error_codes
        },
        {   package_id = "disable_default_shutdown_option_when_update_aviable",
            version = "1",
            rev = 0,
            is_installed =
                function()
                    error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE, [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAUAsDefaultShutdownOption")
                    if error_code == 0 and value == 1 then
                        return true
                    else
                        return false
                    end
                end,
            install_cmds = {
                function()
                    return winreg_set_value(HKEY_LOCAL_MACHINE, [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAUAsDefaultShutdownOption",  REG_DWORD, 1)
                end
            },
            ret_codes = windows_error_codes
        }
    }
    for k,v in ipairs(_packages) do
      table.insert(packages, v)
    end
end