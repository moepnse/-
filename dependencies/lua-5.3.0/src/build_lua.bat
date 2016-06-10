@echo off

rem set MACHINE=X86
rem set MACHINE=X64

rem pushd dependencies\lua-5.3.0

IF /I "%1"=="clean" call :clean
IF /I "%1"=="compile" call :compile

rem popd

goto:eof

:clean
    del *.obj
    del *.o
    del *.lib
    del *.exe
    del *.dll
    goto:eof

:compile
    cl /MD /O2 /c /DLUA_BUILD_AS_DLL *.c
    ren lua.obj lua.o
    ren luac.obj luac.o
    link /DLL /IMPLIB:lua5.3.0.lib /OUT:lua5.3.0.dll *.obj /MACHINE:%MACHINE%
    link /OUT:lua.exe lua.o lua5.3.0.lib /MACHINE:%MACHINE%
    lib /OUT:lua5.3.0-static.lib *.obj
    link /OUT:luac.exe luac.o lua5.3.0-static.lib /MACHINE:%MACHINE%
    goto:eof
