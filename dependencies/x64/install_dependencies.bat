@echo off

echo Installing Python 2.7.13...
msiexec /i %~dp0python-2.7.13.amd64.msi /qn

echo Installing wxPython 3.0...
%~dp0wxPython3.0-win64-3.0.2.0-py27.exe /VERYSILENT

