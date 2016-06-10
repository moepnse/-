@echo off

set WIN_INCLUDE_PATH=%ProgramFiles%\Microsoft SDKs\Windows\v6.0A\Include
set WIN_LIBS_PATH=%ProgramFiles%\Microsoft SDKs\Windows\v6.0A\Libs
rem FIXME
set WIN_INCLUDE_PATH=C:\Programm^ Files\Microsoft^ SDKs\Windows\v6.0A\Include
rem FIXME
set WIN_LIBS_PATH=C:\Programm^ Files\Microsoft^ SDKs\Windows\v6.0A\Libs
set PYTHON32_PATH=%HOMEDRIVE%\Python27_32
set PYTHON32_EXE=%PYTHON32_PATH%\python.exe
set PYTHON32_INCLUDE_PATH=%PYTHON32_PATH%\include
set PYTHON32_LIBS_PATH=%PYTHON32_PATH%\libs
set CYTHON32=%PYTHON32_PATH%\Lib\site-packages\cython.py
set PYTHON64_PATH=%HOMEDRIVE%\Python27
set PYTHON64_EXE=%PYTHON64_PATH%\python.exe
set PYTHON64_INCLUDE_PATH=%PYTHON64_PATH%\include
set PYTHON64_LIBS_PATH=%PYTHON64_PATH%\libs
set CYTHON64=%PYTHON64_PATH%\Lib\site-packages\cython.py
set LUA_INCLUDE_PATH=%~dp0dependencies\lua-5.3.0\src
set LUA_LIBS_PATH=%~dp0dependencies\lua-5.3.0\src
set OLD_LIB=%LIB%
set OLD_INCLUDE=%INCLUDE%

set BRANDING=brandings\unicom\

IF /I "%1"=="x86" call :build_x86 %2
IF /I "%1"=="x64" call :build_x64 %2
IF /I "%1"=="all" (
    call :build_x86 %2
    call :build_x64 %2
)

rem set LIB=%OLD_LIB%
rem set INCLUDE=%OLD_INCLUDE%

goto:eof

:build_x86
    echo build_x86
    set MACHINE=X86
    set PYTHON_EXE=%PYTHON32_EXE%
    set PYTHON_INCLUDE_PATH=%PYTHON32_INCLUDE_PATH%
    set PYTHON_LIBS_PATH=%PYTHON32_LIBS_PATH%
    set CYTHON=%CYTHON32%
    call :set_paths
    IF /I "%1"=="LUA" call :build_lua
    IF /I "%1"=="ALL" call :build_lua
    call :create_package %1
    goto:eof

:build_x64
    echo build_x64
    set MACHINE=X64
    set PYTHON_EXE=%PYTHON64_EXE%
    set PYTHON_INCLUDE_PATH=%PYTHON64_INCLUDE_PATH%
    set PYTHON_LIBS_PATH=%PYTHON64_LIBS_PATH%
    set CYTHON=%CYTHON64%
    call :set_paths
    IF /I "%1"=="LUA" call :build_lua
    IF /I "%1"=="ALL" call :build_lua
    call :create_package %1
    goto:eof

:build_lua
    echo build_lua
    pushd dependencies\lua-5.3.0\src
    call build_lua.bat
    popd
    goto:eof

:set_paths
    echo set_paths
    rem set LIB=%OLD_LIB%
    rem set INCLUDE=%OLD_INCLUDE%

    rem IF ERRORLEVEL n statements should be read as IF Errorlevel >= number
    rem i.e.
    rem IF ERRORLEVEL 0 will return TRUE when the errorlevel is 64 

    echo.%LIB% | findstr /C:"%WIN_LIBS_PATH%" 1>nul

    if errorlevel 0 set LIB=%LIB%%WIN_LIBS_PATH%;

    echo.%INCLUDE% | findstr /C:"%WIN_INCLUDE_PATH%" 1>nul

    if errorlevel 0 (
        set INCLUDE=%INCLUDE%%WIN_INCLUDE_PATH%;
    )

    echo.%LIB% | findstr /C:"%PYTHON_LIBS_PATH%" 1>nul

    if errorlevel 0 set LIB=%LIB%%PYTHON_LIBS_PATH%;

    echo.%INCLUDE% | findstr /C:"%PYTHON_INCLUDE_PATH%" 1>nul

    if errorlevel 0 set INCLUDE=%INCLUDE%%PYTHON_INCLUDE_PATH%;

    echo.%INCLUDE% | findstr /C:"%LUA_INCLUDE_PATH%" 1>nul

    if errorlevel 0 set INCLUDE=%INCLUDE%%LUA_INCLUDE_PATH%;


    echo.%LIB% | findstr /C:"%LUA_LIBS_PATH%" 1>nul

    if errorlevel 0 set LIB=%LIB%%LUA_LIBS_PATH%;


    goto:eof

:build_spielwiese
    call :build spielwiese
    goto:eof

:build_pi_service
    call :build pi_service "Netapi32.lib Wtsapi32.lib Kernel32.lib Psapi.lib Advapi32.lib Userenv.lib ws2_32.lib iphlpapi.lib"
    goto:eof

:build_pi_status_gui
    call :build pi_status_gui Kernel32.lib
    goto:eof

:build_http_transmission
    call :build http_transmission
    goto:eof

:build_host_status
    call :build host_status Kernel32.lib
    goto:eof

:build_pi
    call :build pi Kernel32.lib
    goto:eof

:build_pi_gui
    call :build pi_gui
    goto:eof

:build_all_exe
    call :build_pi_service
    call :build_pi_status_gui
    call :http_transmission
    call :build_host_status
    call :build_pi
    call :build_pi_gui
    goto:eof

:build_all
    call :build_modules
    call :build_all_exe
    goto:eof

:build_modules
    %PYTHON_EXE% %~dp0setup.py build_ext --inplace -f
    goto:eof

:create_package
    echo creating_package

    IF /I "%1"=="modules" call :build_modules

    IF /I "%1"=="spielwiese" call :build_spielwiese
    IF /I "%1"=="pi_service" call :build_pi_service
    IF /I "%1"=="pi_status_gui" call :build_pi_status_gui
    IF /I "%1"=="http_transmission" call :http_transmission
    IF /I "%1"=="host_status" call :build_host_status
    IF /I "%1"=="pi" call :build_pi
    IF /I "%1"=="pi_gui" call :build_pi_gui

    IF /I "%1"=="ALL" call :build_all
    IF /I "%1"=="ALL_EXE" call :build_all_exe

    rmdir /Q /S %~dp0package\%MACHINE%

    xcopy /Y /E /I /EXCLUDE:exclude.lst %~dp0config %~dp0package\%MACHINE%\config
    xcopy /Y /E /I /EXCLUDE:exclude.lst %~dp0plugins %~dp0package\%MACHINE%\plugins
    xcopy /Y /E /I /EXCLUDE:exclude.lst %~dp0libs %~dp0package\%MACHINE%\libs
    xcopy /Y /E /I /EXCLUDE:exclude.lst %~dp0imgs %~dp0package\%MACHINE%\imgs
    xcopy /Y /E /I %~dp0dependencies\%MACHINE% %~dp0package\%MACHINE%\dependencies
    xcopy /Y %~dp0*.exe %~dp0package\%MACHINE%\
    xcopy /Y %~dp0*.pyd %~dp0package\%MACHINE%\
    xcopy /Y %~dp0*.manifest %~dp0package\%MACHINE%\
    xcopy /Y %~dp0*.reg %~dp0package\%MACHINE%\
    xcopy /Y /EXCLUDE:exclude.lst %~dp0*.bat %~dp0package\%MACHINE%\
    xcopy /Y %~dp0*.conf %~dp0package\%MACHINE%\
    xcopy /Y %~dp0set_environment.py %~dp0package\%MACHINE%\
    xcopy /Y %~dp0file_info.py %~dp0package\%MACHINE%\
    goto:eof

:build
    echo build
    SET _LIBS=python27.lib %~2 
    %PYTHON_EXE% %CYTHON% --fast-fail --embed -o %~1.c %~1.pyx
    if exist %BRANDING%%~1.rc (
        rc.exe %BRANDING%%~1.rc
        SET _LIBS = %_LIBS% %~1.res %~2 
    )
    cl.exe  /nologo /Ox /MD /W3 /GS- /DNDEBUG -I%PYTHON_INCLUDE_PATH% /Tc%~1.c /link /LIBPATH:%PYTHON_LIBS_PATH% %_LIBS% /OUT:"%~1.exe" /SUBSYSTEM:CONSOLE /MACHINE:%MACHINE%

    REM link.exe %~2 /nologo /subsystem:console /machine:%MACHINE% /LIBPATH:c:\Python27\libs /LIBPATH:c:\Python27\PCbuild /out:"%~1.exe"  %~1.obj 

    if not %ERRORLEVEL% == 0 (
        echo Error! Could not build %~1.
        REM /B When used in a batch script, this option will exit only the script (or subroutine) but not CMD.EXE
        exit /B 1
    )
    goto:eof