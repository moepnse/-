@echo off

set PYTHONPATH=%HOMEDRIVE%\Python27
REM possible values are:
REM    pev
REM    PATH Environment Variable
REM and:
REM    sl
REM    Symbolic Link
set DEPENDENCIES_SOURCE=pev
set PI_PATH=%HOMEDRIVE%\pi

echo Installing Dependencies...
call %~dp0dependencies\install_dependencies.bat
if not %PI_PATH% == %~dp0 (
    if exist %PI_PATH% (
        set PI_BACKUP_DIR=%PI_PATH%_%date%
        if exist %PI_BACKUP_DIR% (
            REM    /S      Removes all directories and files in the specified directory in addition to the directory itself. Used to remove a directory tree.
            REM    /Q      Quiet mode, do not ask if ok to remove a directory tree with /S
            rmdir /S /Q %PI_BACKUP_DIR%
        )
        move %PI_PATH% %PI_BACKUP_DIR%
    )
    mkdir %PI_PATH%
    REM   /I    If in doubt always assume the destination is a folder
    REM         e.g. when the destination does not exist.
    REM   /B    Copy the Symbolic link itself, not the target of the file.
    REM   /G    Allow the copying of encrypted files to a destination that does not support encryption.
    REM   /J    Copy using unbuffered I/O. Recommended for very large files.
    REM   /Q    Do not display file names while copying.
    REM   /F    Display full source and destination file names while copying.
    xcopy /E /I /F %~dp0* %PI_PATH%
)

if %DEPENDENCIES_SOURCE% == "sl" (
    echo "Creating necessary symbolic links..."
    for %%F in (python27.dll,msvcr90.dll,Microsoft.VC90.CRT.Manifest) do (
        echo "Creating link for: %%F"
        mklink \pi\%%F \Python27\%%F
    )
) else (
    echo Appending Python to the PATH Environment Variable...
    REM %PYTHONPATH%\python.exe %PYTHONPATH%\Tools\Scripts\win_add2path.py
    %PYTHONPATH%\python.exe %~dp0set_environment.py
)