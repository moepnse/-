@echo off

echo Installing Python 2.7.12...
msiexec /i %~dp0python-2.7.12.msi /qn

echo Installing wxPython 3.0...
%~dp0wxPython3.0-win32-3.0.2.0-py27.exe /VERYSILENT

