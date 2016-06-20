
include([[C:\pi\config\error_codes.lua]])

firefox_esr = {}

firefox_esr.MFFESR_IN = [[smb://\\10.0.19.10\software\mffesr.ini]]
firefox_esr.MFFESR_EXE = "http://download-installer.cdn.mozilla.net/pub/firefox/releases/24.2.0esr/win32/de/Firefox%20Setup%2024.2.0esr.exe"
firefox_esr.UNINSTALL_EXE = [[%PROGRAMFILES%\Mozilla Firefox\uninstall\helper.exe]]
firefox_esr.UNINSTALL_SILENT = "/S"
firefox_esr.KILL_FF = "taskkill /F /IM firefox.exe"

firefox_esr.install = function(l)
    install_cmds = {KILL_FF, MFFESR_EXE .. ' '.. MFFESR_IN}
    upgrade_cmds = {}
    uninstall_cmds = {}
    register_package('package_installer', install_cmds, upgrade_cmds, uninstall_cmds)
end


do
    local ms_office_return_codes = {
        success_codes = {
            [0] = { id = "ERROR_SUCCESS",
                    description = "Action completed successfully."
            },
            [3010] = {
                id = "ERROR_SUCCESS_REBOOT_REQUIRED",
                description = "A restart is required to complete the install. This does not include installs where the ForceReboot action is run. Note that this error will not be available until future version of the installer."
            },
            [1641] = {
                id = "ERROR_SUCCESS_REBOOT_INITIATED",
                description = "The installer has started a reboot. This error code not available on Windows Installer version 1.0."
            }
        },
        error_codes = {
            [13] = {
                id = "ERROR_INVALID_DATA",
                description = "The data is invalid."
            },
            [87] = {
                id = "ERROR_INVALID_PARAMETER",
                description = "One of the parameters was invalid."
            },
            [1601] = {
                id = "ERROR_INVALID_PARAMETER",
                description = "The Windows Installer service could not be accessed. Contact your support personnel to verify that the Windows Installer service is properly registered."
            },
            [1602] = {
                id = "ERROR_INSTALL_USEREXIT",
                description = "User cancel installation."
            },
            [1603] = {
                id = "ERROR_INSTALL_FAILURE",
                description = "Fatal error during installation."
            },
            [1604] = {
                id = "ERROR_INSTALL_SUSPEND",
                description = "Installation suspended, incomplete."
            },
            [1605] = {
                id = "ERROR_UNKNOWN_PRODUCT",
                description = "This action is only valid for products that are currently installed."
            },
            [1606] = {
                id = "ERROR_UNKNOWN_FEATURE",
                description = "Feature ID not registered."
            },
            [1607] = {
                id = "ERROR_UNKNOWN_COMPONENT",
                description = "Component ID not registered."
            },
            [1608] = {
                id = "ERROR_UNKNOWN_PROPERTY",
                description = "Unknown property"
            },
            [1609] = {
                id = "ERROR_INVALID_HANDLE_STATE",
                description = "Handle is in an invalid state."
            },
            [1610] = {
                id = "ERROR_BAD_CONFIGURATION",
                description = "The configuration data for this product is corrupted. Contact your support personnel."
            },
            [1611] = {
                id = "Component qualifier not present",
                description = "Handle is in an invalid state."
            },
            [1609] = {
                id = "ERROR_INVALID_HANDLE_STATE",
                description = "Handle is in an invalid state."
            },
            [1612] = {
                id = "ERROR_INSTALL_SOURCE_ABSENT",
                description = "The installation source for this product \nis not available. Verify that the source \nexists and that you can access it."
            },

            [1613] = {
                id = "ERROR_INSTALL_PACKAGE_VERSION",
                description = "This installation package cannot be \ninstalled by the Windows Installer \nservice. You must install a Windows \nservice pack that contains a newer version \nof the Windows Installer service."
            },

            [1614] = {
                id = "ERROR_PRODUCT_UNINSTALLED",
                description = "Product is uninstalled."
            },

            [1615] = {
                id = "ERROR_BAD_QUERY_SYNTAX",
                description = "SQL query syntax invalid or unsupported."
            },

            [1616] = {
                id = "ERROR_INVALID_FIELD",
                description = "Record field does not exist."
            },

            [1618] = {
                id = "ERROR_INSTALL_ALREADY_RUNNING",
                description = "Another installation is already in \nprogress. Complete that installation \nbefore proceeding with this install."
            },

            [1619] = {
                id = "ERROR_INSTALL_PACKAGE_OPEN_FAILED",
                description = "This installation package could not be \nopened. Verify that the package exists and \nthat you can access it, or contact the \napplication vendor to verify that this is \na valid Windows Installer package."
            },

            [1620] = {
                id = "ERROR_INSTALL_PACKAGE_INVALID",
                description = "This installation package could not be \nopened. Contact the application vendor to \nverify that this is a valid Windows \nInstaller package."
            },

            [1621] = {
                id = "ERROR_INSTALL_UI_FAILURE",
                description = "There was an error starting the Windows \nInstaller service user interface. Contact \nyour support personnel."
            },

            [1622] = {
                id = "ERROR_INSTALL_LOG_FAILURE",
                description = "Error opening installation log file. \nVerify that the specified log file \nlocation exists and is writable."
            },

            [1623] = {
                id = "ERROR_INSTALL_LANGUAGE_ UNSUPPORTED",
                description = "This language of this installation package \nis not supported by your system."
            },

            [1624] = {
                id = "ERROR_INSTALL_TRANSFORM_FAILURE",
                description = "Error applying transforms. Verify that\nthe specified transform paths are valid."
            },

            [1625] = {
                id = "ERROR_INSTALL_PACKAGE_REJECTED",
                description = "This installation is forbidden by system \npolicy. Contact your system administrator."
            },

            [1626] = {
                id = "ERROR_FUNCTION_NOT_CALLED",
                description = "Function could not be executed."
            },

            [627] = {
                id = "ERROR_FUNCTION_FAILED",
                description = "Function failed during execution."
            },

            [1628] = {
                id = "ERROR_INVALID_TABLE",
                description = "Invalid or unknown table specified."
            },

            [1629] = {
                id = "ERROR_DATATYPE_MISMATCH",
                description = "Data supplied is of wrong type."
            },

            [1630] = {
                id = "ERROR_UNSUPPORTED_TYPE",
                description = "Data of this type is not supported."
            },

            [1631] = {
                id = "ERROR_CREATE_FAILED",
                description = "The Windows Installer service failed to \nstart. Contact your support personnel."
            },

            [1632] = {
                id = "ERROR_INSTALL_TEMP_UNWRITABLE",
                description = "The temp folder is either full or \ninaccessible. Verify that the temp folder \nexists and that you can write to it."
            },

            [1633] = {
                id = "ERROR_INSTALL_PLATFORM_UNSUPPORTED",
                description = "This installation package is not supported \non this platform. Contact your application \nvendor."
            },

            [1634] = {
                id = "ERROR_INSTALL_NOTUSED",
                description = "Component not used on this computer."
            },

            [1635] = {
                id = "ERROR_PATCH_PACKAGE_OPEN_FAILED",
                description = "This patch package could not be opened. \nVerify that the patch package exists and \nthat you can access it, or contact the \napplication vendor to verify that this is \na valid Windows Installer patch package."
            },

            [1636] = {
                id = "ERROR_PATCH_PACKAGE_INVALID",
                description = "This patch package could not be opened. \nContact the application vendor to verify \nthat this is a valid Windows Installer \npatch package."
            },

            [1637] = {
                id = "ERROR_PATCH_PACKAGE_UNSUPPORTED",
                description = "This patch package cannot be processed by \nthe Windows Installer service. You must \ninstall a Windows service pack that \ncontains a newer version of the Windows \nInstaller service."
            },

            [1638] = {
                id = "ERROR_PRODUCT_VERSION",
                description = "Another version of this product is already \ninstalled. Installation of this version \ncannot continue. To configure or remove \nthe existing version of this product, use \nAdd/Remove Programs in Control Panel."
            },

            [1639] = {
                id = "ERROR_INVALID_COMMAND_LINE",
                description = "Invalid command line argument. Consult the \nWindows Installer SDK for detailed command \nline help."
            },

            [164] = {
                id = "ERROR_INSTALL_REMOTE_DISALLOWED",
                description = "Installation from a Terminal Server\nclient session not permitted for \ncurrent user."
            },

            [1642] = {
                id = "ERROR_PATCH_TARGET_NOT_FOUND",
                description = "The installer cannot install the\nupgrade patch because the program\nbeing upgraded may be missing, or the\nupgrade patch updates a different\nversion of the program. Verify that \nthe program to be upgraded exists on\nyour computer and that you have the \ncorrect upgrade patch.\nThis error code is not available on\nWindows Installer version 1.0."
            },

            [30066] = {
                id = "PREREQUISITE_CHECK_FAILED",
                description = "Please check %TEMP%/SetupExe(...).log for more Information!"
            }
        }
    }

    local SETUP_PATH = [[smb://\\10.0.19.10\software\office2013_x86_de\setup\setup.exe]]
    local UNINSTALL_CMD = 
    {
        cmd = SETUP_PATH,
        args = {
            {   parameter = [[/uninstall]],
                values = {
                    {
                        "ProPlus",
                        false
                    },
                }
            },
            {   parameter = [[/config]],
                values = {
                    {
                        [[smb://\\10.0.19.10\software\msoffice2013pp_uninstall.xml]],
                        true
                    }
                }
            }
        },
        ret_codes = ms_office_return_codes
    }
    local INSTALL_CMD = 
    {
        cmd = SETUP_PATH,
        args = {
            {   parameter = "/ADMINFILE",
                values = {
                    {
                        [[smb://\\10.0.19.10\software\msoffice2013pp_adminfile.msp]],
                        true
                    }
                }
            }
        },
        ret_codes = ms_office_return_codes
    }
    --install_cmds = {SETUP_PATH .. [[ smb://\\10.0.19.10\software\msoffice2013pp_adminfile.msp]]}
    local install_cmds = {INSTALL_CMD}
    local upgrade_cmds = {}
    --uninstall_cmds = {SETUP_PATH .. [[ /config smb://\\10.0.19.10\software\msoffice2013pp_uninstall.xml /uninstall ProPlus]]}
    local uninstall_cmds = {UNINSTALL_CMD}
    register_package('msofficepp2013', [[Microsoft Office Professional Plus 2013]], "2013", "1", is_in_software_list([[Microsoft Office Professional Plus 2013]]), false, install_cmds, upgrade_cmds, uninstall_cmds, "", {})
end

do
    local UNINSTALL_CMD = 
    {
        cmd = [["file://%PROGRAMFILES(X86)%\7-Zip\uninstall.exe"]],
        args = {
            {   parameter = [[/S]],
                values = {
                    {
                        "",
                        false
                    },
                }
            }
        }
    }
    local INSTALL_CMD = 
    {
        cmd = "http://www.7-zip.org/a/7z920.exe",
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
    function test123 ()
        --print("OLA")
        execute("cmd.exe", false, {}, {}, {})
    end
    local install_cmds = {INSTALL_CMD}
    local upgrade_cmds = {}
    local uninstall_cmds = {UNINSTALL_CMD, test123}
    register_package("7zip", "7zip", "9.20", "1", is_in_software_list([[^7-Zip\s9\.2]]), false, install_cmds, upgrade_cmds, uninstall_cmds, "", {})
end

function firefox_esr_is_installed ()
    return is_in_software_list([[Mozilla Firefox [0-9\.]+]])
end

function firefox_esr_is_upgrade_avalaible ()
    return is_in_software_list([[Mozilla Firefox [0-9\.]+]])
end

set_package_check_functions('firefox_esr', 'firefox_esr_is_installed', 'firefox_esr_is_upgrade_avalaible')

function msofficepp2013_is_installed ()
    return is_in_software_list([[Microsoft Office Professional Plus 2013]])
end

function msofficepp2013_is_upgrade_avalaible ()
    return is_in_software_list([[Microsoft Office Professional Plus 2013]])
end

set_package_check_functions('msofficepp2013', 'msofficepp2013_is_installed', 'msofficepp2013_is_upgrade_avalaible')

function sevenzip_is_installed ()
    return is_in_software_list([[^7-Zip\s9\.2]])
end

function sevenzip_is_upgrade_avalaible ()
    return is_in_software_list([[^7-Zip\s9\.2]])
end

set_package_check_functions('7zip', 'sevenzip_is_installed', 'sevenzip_is_upgrade_avalaible')

function print_products()
    for product_name in software_list() do
    --print(startswith(product_name, [[Microsoft Office Professional Plus 2013]]))
    end
end

local status, err = pcall(print_products)
--print(err.code)  -->  121

for share in net_shares("SAMBA") do
    local t_stype = {
        --STYPE_DISKTREE = "DISK",
        --STYPE_PRINTQ = "PRINT",
        --STYPE_DEVICE = "DEVICE",
        --STYPE_IPC = "IPC",
        --STYPE_SPECIAL = "SPECIAL",
        --STYPE_TEMPORARY = "TEMPORARY"
    }
    t_stype[STYPE_DISKTREE] = "DISK"
    t_stype[STYPE_PRINTQ] = "PRINT"
    t_stype[STYPE_DEVICE] = "DEVICE"
    t_stype[STYPE_IPC] = "IPC"
    t_stype[STYPE_SPECIAL] = "SPECIAL"
    t_stype[STYPE_TEMPORARY] = "TEMPORARY"
    local t_access = {
        --ACCESS_READ = "READ",
        --ACCESS_WRITE = "WRITE",
        --ACCESS_CREATE = "CREATE",
        --ACCESS_EXEC = "EXEC",
        --ACCESS_DELETE = "DELETE",
        --ACCESS_ATRIB = "ATRIB",
        --ACCESS_PERM = "PERM",
        --ACCESS_ALL = "ALL"
    }
    local share_types = ""
    for key, value in pairs(t_stype) do
        -- lua 5.2
        --if(bit32.band(share["type"], key) == key) then
        -- lua 5.3
        if (share["type"] & key) == key then
            if share_types == "" then
                share_types = value
            else
                share_types = share_types .. " " ..  value
            end
        end
    end

    --print("SHARE:" .. share["path"] .. " " .. share["netname"] .. " " .. share["remark"] .. " " .. share["type"] .. " " .. share_types)
 end

for installed_software in software_list() do
    print(installed_software)
end
for installed_package in installed_list() do
    print(installed_package['package_id'])
    print(installed_package['version'] > "1.0")
end

--print(arch)
fvi = get_file_version_info([[c:\pi_cython\host_status.exe]])
--fvi = get_file_version_info([[C:\Program Files (x86)\Notepad++\notepad++.exe]])
--print(fvi.file_os)
--print(hiword(fvi.file_version_ms))
--print(loword(fvi.file_version_ms))
--print(hiword(fvi.file_version_ls))
--print(loword(fvi.file_version_ls))

--dwLeftMost = HIWORD(dwFileVersionMS)
--dwSecondLeft = LOWORD(dwFileVersionMS)
--dwSecondRight = HIWORD(dwFileVersionLS)
--dwRightMost = LOWORD(dwFileVersionLS)
--printf( "Version: %d.%d.%d.%d\n" , dwLeftMost, dwSecondLeft, dwSecondRight, dwRightMost );

--HKEY_CLASSES_ROOT
--HKEY_CURRENT_CONFIG
--HKEY_CURRENT_USER
--HKEY_LOCAL_MACHINE
--HKEY_USERS 

--REG_NONE
--REG_SZ
--REG_EXPAND_SZ

--REG_BINARY
--REG_DWORD
--REG_DWORD_LITTLE_ENDIAN
--REG_DWORD_BIG_ENDIAN
--REG_LINK
--REG_MULTI_SZ
--REG_RESOURCE_LIST
--REG_FULL_RESOURCE_DESCRIPTOR
--REG_RESOURCE_REQUIREMENTS_LIST
--REG_QWORD
--REG_QWORD_LITTLE_ENDIAN
-- http://www.howtogeek.com/howto/37920/the-50-best-registry-hacks-that-make-windows-better/
packages = {
    {   package_id = "disable_autorun",
        version = "1",
        rev = 0,
        is_installed =
            function()
                error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDriveAutoRun")
                if error_code == 0 and value == 255 then
                    return true
                else
                    return false
                end
            end,
        install_cmds = {
            function()
                return winreg_set_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDriveAutoRun",  REG_DWORD, 255)
            end
        }
    },
    {   package_id = "hide_drives_a_and_e",
        version = "1",
        rev = 0,
        is_installed =
            function()
                error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE,  [[Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDrives")
                if error_code == 0 and value == 17 then
                    return true
                else
                    return false
                end
            end,
        install_cmds = {
            function()
                return winreg_set_value(HKEY_LOCAL_MACHINE,  [[Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoDrives",  REG_DWORD, 17)
            end
        }
    },
    {   package_id = "add_encryption_to_context_menu",
        version = "1",
        rev = 0,
        is_installed =
            function()
                error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE,  [[Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]], "EncryptionContextMenu")
                if error_code == 0 and value == 1 then
                    return true
                else
                    return false
                end
            end,
        install_cmds = {
            function()
                return winreg_set_value(HKEY_LOCAL_MACHINE,  [[Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]], "EncryptionContextMenu",  REG_DWORD, 1)
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
                return winreg_set_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]], "NoInternetOpenWith",  REG_DWORD, 1)
            end
        },
        ret_codes = windows_error_codes
    },
    {   package_id = "disable_autoreboot_after_update",
        version = "1",
        rev = 0,
        is_installed =
            function()
                error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAutoRebootWithLoggedOnUsers")
                print(tostring(error_code) .. " " .. tostring(value_type) .. " " .. tostring(value))
                if error_code == 0 and value == 1 then
                    return true
                else
                    return false
                end
            end,
        install_cmds = {
            function()
                return winreg_set_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAutoRebootWithLoggedOnUsers",  REG_DWORD, 1)
            end
        },
        ret_codes = windows_error_codes
    },
    {   package_id = "disable_default_shutdown_option_when_update_aviable",
        version = "1",
        rev = 0,
        is_installed =
            function()
                error_code, value_type, value = winreg_query_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAUAsDefaultShutdownOption")
                if error_code == 0 and value == 1 then
                    return true
                else
                    return false
                end
            end,
        install_cmds = {
            function()
                return winreg_set_value(HKEY_LOCAL_MACHINE,  [[SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]], "NoAUAsDefaultShutdownOption",  REG_DWORD, 1)
            end
        },
        ret_codes = windows_error_codes
    },
    {   package_id = "winrar",
        is_installed = 
            function()
                return true
            end,
        is_upgrade_available = function()
            return false
        end,
        ret_codes = windows_error_codes
    },
    {   package_id = "winzip",
        is_installed = 
            function()
                return true
            end,
        is_upgrade_available = function()
            return false
        end,
        ret_codes = windows_error_codes
    },
    {   package_id = "7zip",
        version = "9.20",
        rev = 0,
        uninstall_cmds = 
            {
                {
                    cmd = [["file://%PROGRAMFILES(X86)%\7-Zip\uninstall.exe"]],
                    args = {
                        {   parameter = [[/S]],
                            values = {
                                {
                                    "",
                                    false
                                },
                            }
                        }
                    }
                }
            },
        install_cmds = 
            {
                {
                    cmd = "http://www.7-zip.org/a/7z920.exe",
                    md5 = "b3fdf6e7b0aecd48ca7e4921773fb606",
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
        is_installed = 
            function()
                --print("7zip is installed: " .. tostring(is_in_software_list([[^7-Zip\s9\.2]])))
                return is_in_software_list([[^7-Zip\s9\.2]])
            end,
        is_upgrade_available = function()
            return false
        end,
        dependencies = {
            {   package_id = "winrar",
                installed = false,
            },
            {   package_id = "winzip",
                installed = false,
            }
        },
        keywords = {
            "archiv", "compress", "zip", "rar", "tar", "7z"
        },
        description = "7-Zip is an open source file archiver, or an application used to compress files.",
        ret_codes = windows_error_codes
    },
    {   package_id = "x2goclient",
        name = "X2Go Client",
        version = "4.0.5.0",
        rev = 0,
        uninstall_cmds = 
            {
                {
                    cmd = [["file://%PROGRAMFILES(X86)%\x2goclient\Uninstall.exe"]],
                    args = {
                        {   parameter = [[/S]],
                            values = {
                                {
                                    "",
                                    false
                                },
                            }
                        }
                    }
                }
            },
        install_cmds = 
            {
                {
                    cmd = "http://code.x2go.org/releases/binary-win32/x2goclient/releases/4.0.5.0-2015.07.31/x2goclient-4.0.5.0-2015.07.31-setup.exe",
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
        is_installed = 
            function()
                return is_in_software_list([[^X2Go Client for Windows]])
            end,
        is_upgrade_available = function()
            local installed, version, rev = is_in_installed_list("x2goclient")
            if installed and (version < "4.0.5.0" or (version == "4.0.5.0" and rev < "0")) then
                return true
            end
            return false
        end,
        dependencies = {
        },
        keywords = {
            "remote desktop", "x11"
        },
        description = "Client to connect to a X2Go Server (Linux Remote Desktop). Its also possible to start only an remote application.",
        ret_codes = windows_error_codes
    }
}

do
    local installed, version, rev = is_in_installed_list("7zip")
    print(tostring(installed) .. " " .. version .. " " .. rev)
    print(is_upgrade_available("7zip", "9.20", "0"))
end
