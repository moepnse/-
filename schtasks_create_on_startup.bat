schtasks.exe /create /tn "PI" /ru SYSTEM /Sc ONSTART /tr "%~dp0pi_service.exe tues"