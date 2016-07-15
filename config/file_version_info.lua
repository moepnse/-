fvi = get_file_version_info([[c:\pi\host_status.exe]])
--fvi = get_file_version_info([[C:\Program Files (x86)\Notepad++\notepad++.exe]])
print(fvi.file_os)
print(hiword(fvi.file_version_ms))
print(loword(fvi.file_version_ms))
print(hiword(fvi.file_version_ls))
print(loword(fvi.file_version_ls))

--dwLeftMost = HIWORD(dwFileVersionMS)
--dwSecondLeft = LOWORD(dwFileVersionMS)
--dwSecondRight = HIWORD(dwFileVersionLS)
--dwRightMost = LOWORD(dwFileVersionLS)
--printf( "Version: %d.%d.%d.%d\n" , dwLeftMost, dwSecondLeft, dwSecondRight, dwRightMost );