groups = {
    {   id = "office_suite",
        name = "Office Suite",
        description = "Office Suite",
        package = { "libreoffice"},
        groups = {}
    },
    {   id = "network",
        name = "Network",
        description = "Network",
        packages = {},
        groups = {
            {
                id = "webbrowsers",
                name = "Webbrowsers",
                description = "Webbrowsers",
                packages = {"firefox", "firefox_esr"}
            },
            {
                id = "remote_desktop",
                name = "Remote Desktop",
                description = "Remote Desktop",
                packages = {"x2goclient"}
            },
            {
                id = "instant_messaging",
                name = "Instant Messaging",
                description = "Instant Messaging",
                packages = {"gajim"}
            }
        }
    },
    {
        id = "file_archiver",
        name = "file archiver",
        description = "file archiver",
        packages = {"winrar", "winzip", "7zip"}
    },
    {
        id = "windows_registry_hacks",
        name = "windows registry hacks",
        description = "windows registry hacks",
        packages = {    "disable_autorun", 
                        "hide_drives_a_and_e", 
                        "add_encryption_to_context_menu",
                        "jump_directly_to_select_a_program_from_a_list_of_installed_programs", 
                        "disable_autoreboot_after_update",
                        "disable_default_shutdown_option_when_update_aviable"
                    }
    }
}
