--uninstall("msofficepp2013")
--uninstall("firefox_esr")
--install("msofficepp2013")
--install("firefox_esr")

--uninstall("7zip")
--install("7zip")
--install("7zip")
--uninstall("7zip")
--uninstall("7zip")

--install({"buchhaltung*", "chef"}, {"7zip", "firefox_esr"})

--hosts = {"*": }

print(get_domain_name())
print(get_netbios_domain_name())
--if is_array({"blub", 2}) then
    --print("yes")
--else
    --print("no")
--end
--print("host_list")
host_list = {
    {   workgroup = "TEST", 
        packages = { 
            {   "install", 
                {   "7zip",
                    "disable_autorun"
                }
            },
            {"uninstall", {"7zip"}}
        }
    },
    {   hostname = ".", 
        packages = { 
            {   "install", 
                {   "7zip",
                    "disable_autorun",
                    "add_encryption_to_context_menu",
                    "jump_directly_to_select_a_program_from_a_list_of_installed_programs",
                    "disable_autoreboot_after_update",
                    "disable_default_shutdown_option_when_update_aviable",
                    "x2goclient",
                    "firefox_esr",
                    "msofficepp2013"
                }
            }
        }
    }
}

