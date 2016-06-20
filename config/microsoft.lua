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

function msofficepp2013_is_installed ()
    return is_in_software_list([[Microsoft Office Professional Plus 2013]])
end

function msofficepp2013_is_upgrade_avalaible ()
    return is_in_software_list([[Microsoft Office Professional Plus 2013]])
end

set_package_check_functions('msofficepp2013', 'msofficepp2013_is_installed', 'msofficepp2013_is_upgrade_avalaible')