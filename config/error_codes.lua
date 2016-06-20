windows_error_codes = {
    success_codes = {
        [0] = {
            id = "ERROR_SUCCESS",
            description = "The operation completed successfully."
        }
    },
    error_codes = {
        [1] = {
            id = "ERROR_INVALID_FUNCTION",
            description = "Incorrect function."
        },
        [2] = {
            id = "ERROR_FILE_NOT_FOUND",
            description = "The system cannot find the file specified."
        },
        [3] = {
            id = "ERROR_PATH_NOT_FOUND",
            description = "The system cannot find the path specified."
        },
        [4] = {
            id = "ERROR_TOO_MANY_OPEN_FILES",
            description = "The system cannot open the file."
        },
        [5] = {
            id = "ERROR_ACCESS_DENIED",
            description = "Access is denied."
        },
        [6] = {
            id = "ERROR_INVALID_HANDLE",
            description = "The handle is invalid."
        },
        [7] = {
            id = "ERROR_ARENA_TRASHED",
            description = "The storage control blocks were destroyed."
        },
        [8] = {
            id = "ERROR_NOT_ENOUGH_MEMORY",
            description = "Not enough storage is available to process this command."
        },
        [9] = {
            id = "ERROR_INVALID_BLOCK",
            description = "The storage control block address is invalid."
        },
        [10] = {
            id = "ERROR_BAD_ENVIRONMENT",
            description = "The environment is incorrect."
        },
        [11] = {
            id = "ERROR_BAD_FORMAT",
            description = "An attempt was made to load a program with an incorrect format."
        },
        [12] = {
            id = "ERROR_INVALID_ACCESS",
            description = "The access code is invalid."
        },
        [13] = {
            id = "ERROR_INVALID_DATA",
            description = "The data is invalid."
        },
        [14] = {
            id = "ERROR_OUTOFMEMORY",
            description = "Not enough storage is available to complete this operation."
        },
        [15] = {
            id = "ERROR_INVALID_DRIVE",
            description = "The system cannot find the drive specified."
        },
        [16] = {
            id = "ERROR_CURRENT_DIRECTORY",
            description = "The directory cannot be removed."
        },
        [17] = {
            id = "ERROR_NOT_SAME_DEVICE",
            description = "The system cannot move the file to a different disk drive."
        },
        [18] = {
            id = "ERROR_NO_MORE_FILES",
            description = "There are no more files."
        },
        [19] = {
            id = "ERROR_WRITE_PROTECT",
            description = "The media is write protected."
        },
        [20] = {
            id = "ERROR_BAD_UNIT",
            description = "The system cannot find the device specified."
        },
        [21] = {
            id = "ERROR_NOT_READY",
            description = "The device is not ready."
        },
        [22] = {
            id = "ERROR_BAD_COMMAND",
            description = "The device does not recognize the command."
        },
        [23] = {
            id = "ERROR_CRC",
            description = "Data error (cyclic redundancy check)."
        },
        [24] = {
            id = "ERROR_BAD_LENGTH",
            description = "The program issued a command but the command length is incorrect."
        },
        [25] = {
            id = "ERROR_SEEK",
            description = "The drive cannot locate a specific area or track on the disk."
        },
        [26] = {
            id = "ERROR_NOT_DOS_DISK",
            description = "The specified disk or diskette cannot be accessed."
        },
        [27] = {
            id = "ERROR_SECTOR_NOT_FOUND",
            description = "The drive cannot find the sector requested."
        },
        [28] = {
            id = "ERROR_OUT_OF_PAPER",
            description = "The printer is out of paper."
        },
        [29] = {
            id = "ERROR_WRITE_FAULT",
            description = "The system cannot write to the specified device."
        },
        [30] = {
            id = "ERROR_READ_FAULT",
            description = "The system cannot read from the specified device."
        },
        [31] = {
            id = "ERROR_GEN_FAILURE",
            description = "A device attached to the system is not functioning."
        },
        [32] = {
            id = "ERROR_SHARING_VIOLATION",
            description = "The process cannot access the file because it is being used by another process."
        },
        [33] = {
            id = "ERROR_LOCK_VIOLATION",
            description = "The process cannot access the file because another process has locked a portion of the file."
        },
        [34] = {
            id = "ERROR_WRONG_DISK",
            description = "The wrong diskette is in the drive. Insert %2 (Volume Serial Number: %3) into drive %1."
        },
        [36] = {
            id = "ERROR_SHARING_BUFFER_EXCEEDED",
            description = "Too many files opened for sharing."
        },
        [38] = {
            id = "ERROR_HANDLE_EOF",
            description = "Reached the end of the file."
        },
        [39] = {
            id = "ERROR_HANDLE_DISK_FULL",
            description = "The disk is full."
        },
        [50] = {
            id = "ERROR_NOT_SUPPORTED",
            description = "The request is not supported."
        },
        [51] = {
            id = "ERROR_REM_NOT_LIST",
            description = "Windows cannot find the network path. Verify that the network path is correct and the destination computer is not busy or turned off. If Windows still cannot find the network path, contact your network administrator."
        },
        [52] = {
            id = "ERROR_DUP_NAME",
            description = "You were not connected because a duplicate name exists on the network. If joining a domain, go to System in Control Panel to change the computer name and try again. If joining a workgroup, choose another workgroup name."
        },
        [53] = {
            id = "ERROR_BAD_NETPATH",
            description = "The network path was not found."
        },
        [54] = {
            id = "ERROR_NETWORK_BUSY",
            description = "The network is busy."
        },
        [55] = {
            id = "ERROR_DEV_NOT_EXIST",
            description = "The specified network resource or device is no longer available."
        },
        [56] = {
            id = "ERROR_TOO_MANY_CMDS",
            description = "The network BIOS command limit has been reached."
        },
        [57] = {
            id = "ERROR_ADAP_HDW_ERR",
            description = "A network adapter hardware error occurred."
        },
        [58] = {
            id = "ERROR_BAD_NET_RESP",
            description = "The specified server cannot perform the requested operation."
        },
        [59] = {
            id = "ERROR_UNEXP_NET_ERR",
            description = "An unexpected network error occurred."
        },
        [60] = {
            id = "ERROR_BAD_REM_ADAP",
            description = "The remote adapter is not compatible."
        },
        [61] = {
            id = "ERROR_PRINTQ_FULL",
            description = "The printer queue is full."
        },
        [62] = {
            id = "ERROR_NO_SPOOL_SPACE",
            description = "Space to store the file waiting to be printed is not available on the server."
        },
        [63] = {
            id = "ERROR_PRINT_CANCELLED",
            description = "Your file waiting to be printed was deleted."
        },
        [64] = {
            id = "ERROR_NETNAME_DELETED",
            description = "The specified network name is no longer available."
        },
        [65] = {
            id = "ERROR_NETWORK_ACCESS_DENIED",
            description = "Network access is denied."
        },
        [66] = {
            id = "ERROR_BAD_DEV_TYPE",
            description = "The network resource type is not correct."
        },
        [67] = {
            id = "ERROR_BAD_NET_NAME",
            description = "The network name cannot be found."
        },
        [68] = {
            id = "ERROR_TOO_MANY_NAMES",
            description = "The name limit for the local computer network adapter card was exceeded."
        },
        [69] = {
            id = "ERROR_TOO_MANY_SESS",
            description = "The network BIOS session limit was exceeded."
        },
        [70] = {
            id = "ERROR_SHARING_PAUSED",
            description = "The remote server has been paused or is in the process of being started."
        },
        [71] = {
            id = "ERROR_REQ_NOT_ACCEP",
            description = "No more connections can be made to this remote computer at this time because there are already as many connections as the computer can accept."
        },
        [72] = {
            id = "ERROR_REDIR_PAUSED",
            description = "The specified printer or disk device has been paused."
        },
        [80] = {
            id = "ERROR_FILE_EXISTS",
            description = "The file exists."
        },
        [82] = {
            id = "ERROR_CANNOT_MAKE",
            description = "The directory or file cannot be created."
        },
        [83] = {
            id = "ERROR_FAIL_I24",
            description = "Fail on INT 24."
        },
        [84] = {
            id = "ERROR_OUT_OF_STRUCTURES",
            description = "Storage to process this request is not available."
        },
        [85] = {
            id = "ERROR_ALREADY_ASSIGNED",
            description = "The local device name is already in use."
        },
        [86] = {
            id = "ERROR_INVALID_PASSWORD",
            description = "The specified network password is not correct."
        },
        [87] = {
            id = "ERROR_INVALID_PARAMETER",
            description = "The parameter is incorrect."
        },
        [88] = {
            id = "ERROR_NET_WRITE_FAULT",
            description = "A write fault occurred on the network."
        },
        [89] = {
            id = "ERROR_NO_PROC_SLOTS",
            description = "The system cannot start another process at this time."
        },
        [100] = {
            id = "ERROR_TOO_MANY_SEMAPHORES",
            description = "Cannot create another system semaphore."
        },
        [101] = {
            id = "ERROR_EXCL_SEM_ALREADY_OWNED",
            description = "The exclusive semaphore is owned by another process."
        },
        [102] = {
            id = "ERROR_SEM_IS_SET",
            description = "The semaphore is set and cannot be closed."
        },
        [103] = {
            id = "ERROR_TOO_MANY_SEM_REQUESTS",
            description = "The semaphore cannot be set again."
        },
        [104] = {
            id = "ERROR_INVALID_AT_INTERRUPT_TIME",
            description = "Cannot request exclusive semaphores at interrupt time."
        },
        [105] = {
            id = "ERROR_SEM_OWNER_DIED",
            description = "The previous ownership of this semaphore has ended."
        },
        [106] = {
            id = "ERROR_SEM_USER_LIMIT",
            description = "Insert the diskette for drive %1."
        },
        [107] = {
            id = "ERROR_DISK_CHANGE",
            description = "The program stopped because an alternate diskette was not inserted."
        },
        [108] = {
            id = "ERROR_DRIVE_LOCKED",
            description = "The disk is in use or locked by another process."
        },
        [109] = {
            id = "ERROR_BROKEN_PIPE",
            description = "The pipe has been ended."
        },
        [110] = {
            id = "ERROR_OPEN_FAILED",
            description = "The system cannot open the device or file specified."
        },
        [111] = {
            id = "ERROR_BUFFER_OVERFLOW",
            description = "The file name is too long."
        },
        [112] = {
            id = "ERROR_DISK_FULL",
            description = "There is not enough space on the disk."
        },
        [113] = {
            id = "ERROR_NO_MORE_SEARCH_HANDLES",
            description = "No more internal file identifiers available."
        },
        [114] = {
            id = "ERROR_INVALID_TARGET_HANDLE",
            description = "The target internal file identifier is incorrect."
        },
        [117] = {
            id = "ERROR_INVALID_CATEGORY",
            description = "The IOCTL call made by the application program is not correct."
        },
        [118] = {
            id = "ERROR_INVALID_VERIFY_SWITCH",
            description = "The verify-on-write switch parameter value is not correct."
        },
        [119] = {
            id = "ERROR_BAD_DRIVER_LEVEL",
            description = "The system does not support the command requested."
        },
        [120] = {
            id = "ERROR_CALL_NOT_IMPLEMENTED",
            description = "This function is not supported on this system."
        },
        [121] = {
            id = "ERROR_SEM_TIMEOUT",
            description = "The semaphore timeout period has expired."
        },
        [122] = {
            id = "ERROR_INSUFFICIENT_BUFFER",
            description = "The data area passed to a system call is too small."
        },
        [123] = {
            id = "ERROR_INVALID_NAME",
            description = "The filename, directory name, or volume label syntax is incorrect."
        },
        [124] = {
            id = "ERROR_INVALID_LEVEL",
            description = "The system call level is not correct."
        },
        [125] = {
            id = "ERROR_NO_VOLUME_LABEL",
            description = "The disk has no volume label."
        },
        [126] = {
            id = "ERROR_MOD_NOT_FOUND",
            description = "The specified module could not be found."
        },
        [127] = {
            id = "ERROR_PROC_NOT_FOUND",
            description = "The specified procedure could not be found."
        },
        [128] = {
            id = "ERROR_WAIT_NO_CHILDREN",
            description = "There are no child processes to wait for."
        },
        [129] = {
            id = "ERROR_CHILD_NOT_COMPLETE",
            description = "The %1 application cannot be run in Win32 mode."
        },
        [130] = {
            id = "ERROR_DIRECT_ACCESS_HANDLE",
            description = "Attempt to use a file handle to an open disk partition for an operation other than raw disk I/O."
        },
        [131] = {
            id = "ERROR_NEGATIVE_SEEK",
            description = "An attempt was made to move the file pointer before the beginning of the file."
        },
        [132] = {
            id = "ERROR_SEEK_ON_DEVICE",
            description = "The file pointer cannot be set on the specified device or file."
        },
        [133] = {
            id = "ERROR_IS_JOIN_TARGET",
            description = "A JOIN or SUBST command cannot be used for a drive that contains previously joined drives."
        },
        [134] = {
            id = "ERROR_IS_JOINED",
            description = "An attempt was made to use a JOIN or SUBST command on a drive that has already been joined."
        },
        [135] = {
            id = "ERROR_IS_SUBSTED",
            description = "An attempt was made to use a JOIN or SUBST command on a drive that has already been substituted."
        },
        [136] = {
            id = "ERROR_NOT_JOINED",
            description = "The system tried to delete the JOIN of a drive that is not joined."
        },
        [137] = {
            id = "ERROR_NOT_SUBSTED",
            description = "The system tried to delete the substitution of a drive that is not substituted."
        },
        [138] = {
            id = "ERROR_JOIN_TO_JOIN",
            description = "The system tried to join a drive to a directory on a joined drive."
        },
        [139] = {
            id = "ERROR_SUBST_TO_SUBST",
            description = "The system tried to substitute a drive to a directory on a substituted drive."
        },
        [140] = {
            id = "ERROR_JOIN_TO_SUBST",
            description = "The system tried to join a drive to a directory on a substituted drive."
        },
        [141] = {
            id = "ERROR_SUBST_TO_JOIN",
            description = "The system tried to SUBST a drive to a directory on a joined drive."
        },
        [142] = {
            id = "ERROR_BUSY_DRIVE",
            description = "The system cannot perform a JOIN or SUBST at this time."
        },
        [143] = {
            id = "ERROR_SAME_DRIVE",
            description = "The system cannot join or substitute a drive to or for a directory on the same drive."
        },
        [144] = {
            id = "ERROR_DIR_NOT_ROOT",
            description = "The directory is not a subdirectory of the root directory."
        },
        [145] = {
            id = "ERROR_DIR_NOT_EMPTY",
            description = "The directory is not empty."
        },
        [146] = {
            id = "ERROR_IS_SUBST_PATH",
            description = "The path specified is being used in a substitute."
        },
        [147] = {
            id = "ERROR_IS_JOIN_PATH",
            description = "Not enough resources are available to process this command."
        },
        [148] = {
            id = "ERROR_PATH_BUSY",
            description = "The path specified cannot be used at this time."
        },
        [149] = {
            id = "ERROR_IS_SUBST_TARGET",
            description = "An attempt was made to join or substitute a drive for which a directory on the drive is the target of a previous substitute."
        },
        [150] = {
            id = "ERROR_SYSTEM_TRACE",
            description = "System trace information was not specified in your CONFIG.SYS file, or tracing is disallowed."
        },
        [151] = {
            id = "ERROR_INVALID_EVENT_COUNT",
            description = "The number of specified semaphore events for DosMuxSemWait is not correct."
        },
        [152] = {
            id = "ERROR_TOO_MANY_MUXWAITERS",
            description = "DosMuxSemWait did not execute; too many semaphores are already set."
        },
        [153] = {
            id = "ERROR_INVALID_LIST_FORMAT",
            description = "The DosMuxSemWait list is not correct."
        },
        [154] = {
            id = "ERROR_LABEL_TOO_LONG",
            description = "The volume label you entered exceeds the label character limit of the target file system."
        },
        [155] = {
            id = "ERROR_TOO_MANY_TCBS",
            description = "Cannot create another thread."
        },
        [156] = {
            id = "ERROR_SIGNAL_REFUSED",
            description = "The recipient process has refused the signal."
        },
        [157] = {
            id = "ERROR_DISCARDED",
            description = "The segment is already discarded and cannot be locked."
        },
        [158] = {
            id = "ERROR_NOT_LOCKED",
            description = "The segment is already unlocked."
        },
        [159] = {
            id = "ERROR_BAD_THREADID_ADDR",
            description = "The address for the thread ID is not correct."
        },
        [160] = {
            id = "ERROR_BAD_ARGUMENTS",
            description = "One or more arguments are not correct."
        },
        [161] = {
            id = "ERROR_BAD_PATHNAME",
            description = "The specified path is invalid."
        },
        [162] = {
            id = "ERROR_SIGNAL_PENDING",
            description = "A signal is already pending."
        },
        [164] = {
            id = "ERROR_MAX_THRDS_REACHED",
            description = "No more threads can be created in the system."
        },
        [167] = {
            id = "ERROR_LOCK_FAILED",
            description = "Unable to lock a region of a file."
        },
        [170] = {
            id = "ERROR_BUSY",
            description = "The requested resource is in use."
        },
        [171] = {
            id = "ERROR_DEVICE_SUPPORT_IN_PROGRESS",
            description = "Device's command support detection is in progress."
        },
        [173] = {
            id = "ERROR_CANCEL_VIOLATION",
            description = "A lock request was not outstanding for the supplied cancel region."
        },
        [174] = {
            id = "ERROR_ATOMIC_LOCKS_NOT_SUPPORTED",
            description = "The file system does not support atomic changes to the lock type."
        },
        [180] = {
            id = "ERROR_INVALID_SEGMENT_NUMBER",
            description = "The system detected a segment number that was not correct."
        },
        [182] = {
            id = "ERROR_INVALID_ORDINAL",
            description = "The operating system cannot run %1."
        },
        [183] = {
            id = "ERROR_ALREADY_EXISTS",
            description = "Cannot create a file when that file already exists."
        },
        [186] = {
            id = "ERROR_INVALID_FLAG_NUMBER",
            description = "The flag passed is not correct."
        },
        [187] = {
            id = "ERROR_SEM_NOT_FOUND",
            description = "The specified system semaphore name was not found."
        },
        [188] = {
            id = "ERROR_INVALID_STARTING_CODESEG",
            description = "The operating system cannot run %1."
        },
        [189] = {
            id = "ERROR_INVALID_STACKSEG",
            description = "The operating system cannot run %1."
        },
        [190] = {
            id = "ERROR_INVALID_MODULETYPE",
            description = "The operating system cannot run %1."
        },
        [191] = {
            id = "ERROR_INVALID_EXE_SIGNATURE",
            description = "Cannot run %1 in Win32 mode."
        },
        [192] = {
            id = "ERROR_EXE_MARKED_INVALID",
            description = "The operating system cannot run %1."
        },
        [193] = {
            id = "ERROR_BAD_EXE_FORMAT",
            description = "%1 is not a valid Win32 application."
        },
        [194] = {
            id = "ERROR_ITERATED_DATA_EXCEEDS_64k",
            description = "The operating system cannot run %1."
        },
        [195] = {
            id = "ERROR_INVALID_MINALLOCSIZE",
            description = "The operating system cannot run %1."
        },
        [196] = {
            id = "ERROR_DYNLINK_FROM_INVALID_RING",
            description = "The operating system cannot run this application program."
        },
        [197] = {
            id = "ERROR_IOPL_NOT_ENABLED",
            description = "The operating system is not presently configured to run this application."
        },
        [198] = {
            id = "ERROR_INVALID_SEGDPL",
            description = "The operating system cannot run %1."
        },
        [199] = {
            id = "ERROR_AUTODATASEG_EXCEEDS_64k",
            description = "The operating system cannot run this application program."
        },
        [200] = {
            id = "ERROR_RING2SEG_MUST_BE_MOVABLE",
            description = "The code segment cannot be greater than or equal to 64K."
        },
        [201] = {
            id = "ERROR_RELOC_CHAIN_XEEDS_SEGLIM",
            description = "The operating system cannot run %1."
        },
        [202] = {
            id = "ERROR_INFLOOP_IN_RELOC_CHAIN",
            description = "The operating system cannot run %1."
        },
        [203] = {
            id = "ERROR_ENVVAR_NOT_FOUND",
            description = "The system could not find the environment option that was entered."
        },
        [205] = {
            id = "ERROR_NO_SIGNAL_SENT",
            description = "No process in the command subtree has a signal handler."
        },
        [206] = {
            id = "ERROR_FILENAME_EXCED_RANGE",
            description = "The filename or extension is too long."
        },
        [207] = {
            id = "ERROR_RING2_STACK_IN_USE",
            description = "The ring 2 stack is in use."
        },
        [208] = {
            id = "ERROR_META_EXPANSION_TOO_LONG",
            description = "The global filename characters, * or ?, are entered incorrectly or too many global filename characters are specified."
        },
        [209] = {
            id = "ERROR_INVALID_SIGNAL_NUMBER",
            description = "The signal being posted is not correct."
        },
        [210] = {
            id = "ERROR_THREAD_1_INACTIVE",
            description = "The signal handler cannot be set."
        },
        [212] = {
            id = "ERROR_LOCKED",
            description = "The segment is locked and cannot be reallocated."
        },
        [214] = {
            id = "ERROR_TOO_MANY_MODULES",
            description = "Too many dynamic-link modules are attached to this program or dynamic-link module."
        },
        [215] = {
            id = "ERROR_NESTING_NOT_ALLOWED",
            description = "Cannot nest calls to LoadModule."
        },
        [216] = {
            id = "ERROR_EXE_MACHINE_TYPE_MISMATCH",
            description = "This version of %1 is not compatible with the version of Windows you're running. Check your computer's system information and then contact the software publisher."
        },
        [217] = {
            id = "ERROR_EXE_CANNOT_MODIFY_SIGNED_BINARY",
            description = "The image file %1 is signed, unable to modify."
        },
        [218] = {
            id = "ERROR_EXE_CANNOT_MODIFY_STRONG_SIGNED_BINARY",
            description = "The image file %1 is strong signed, unable to modify."
        },
        [220] = {
            id = "ERROR_FILE_CHECKED_OUT",
            description = "This file is checked out or locked for editing by another user."
        },
        [221] = {
            id = "ERROR_CHECKOUT_REQUIRED",
            description = "The file must be checked out before saving changes."
        },
        [222] = {
            id = "ERROR_BAD_FILE_TYPE",
            description = "The file type being saved or retrieved has been blocked."
        },
        [223] = {
            id = "ERROR_FILE_TOO_LARGE",
            description = "The file size exceeds the limit allowed and cannot be saved."
        },
        [224] = {
            id = "ERROR_FORMS_AUTH_REQUIRED",
            description = "Access Denied. Before opening files in this location, you must first add the web site to your trusted sites list, browse to the web site, and select the option to login automatically."
        },
        [225] = {
            id = "ERROR_VIRUS_INFECTED",
            description = "Operation did not complete successfully because the file contains a virus or potentially unwanted software."
        },
        [226] = {
            id = "ERROR_VIRUS_DELETED",
            description = "This file contains a virus or potentially unwanted software and cannot be opened. Due to the nature of this virus or potentially unwanted software, the file has been removed from this location."
        },
        [229] = {
            id = "ERROR_PIPE_LOCAL",
            description = "The pipe is local."
        },
        [230] = {
            id = "ERROR_BAD_PIPE",
            description = "The pipe state is invalid."
        },
        [231] = {
            id = "ERROR_PIPE_BUSY",
            description = "All pipe instances are busy."
        },
        [232] = {
            id = "ERROR_NO_DATA",
            description = "The pipe is being closed."
        },
        [233] = {
            id = "ERROR_PIPE_NOT_CONNECTED",
            description = "No process is on the other end of the pipe."
        },
        [234] = {
            id = "ERROR_MORE_DATA",
            description = "More data is available."
        },
        [240] = {
            id = "ERROR_VC_DISCONNECTED",
            description = "The session was canceled."
        },
        [254] = {
            id = "ERROR_INVALID_EA_NAME",
            description = "The specified extended attribute name was invalid."
        },
        [255] = {
            id = "ERROR_EA_LIST_INCONSISTENT",
            description = "The extended attributes are inconsistent."
        },
        [258] = {
            id = "WAIT_TIMEOUT",
            description = "The wait operation timed out."
        },
        [259] = {
            id = "ERROR_NO_MORE_ITEMS",
            description = "No more data is available."
        },
        [266] = {
            id = "ERROR_CANNOT_COPY",
            description = "The copy functions cannot be used."
        },
        [267] = {
            id = "ERROR_DIRECTORY",
            description = "The directory name is invalid."
        },
        [275] = {
            id = "ERROR_EAS_DIDNT_FIT",
            description = "The extended attributes did not fit in the buffer."
        },
        [276] = {
            id = "ERROR_EA_FILE_CORRUPT",
            description = "The extended attribute file on the mounted file system is corrupt."
        },
        [277] = {
            id = "ERROR_EA_TABLE_FULL",
            description = "The extended attribute table file is full."
        },
        [278] = {
            id = "ERROR_INVALID_EA_HANDLE",
            description = "The specified extended attribute handle is invalid."
        },
        [282] = {
            id = "ERROR_EAS_NOT_SUPPORTED",
            description = "The mounted file system does not support extended attributes."
        },
        [288] = {
            id = "ERROR_NOT_OWNER",
            description = "Attempt to release mutex not owned by caller."
        },
        [298] = {
            id = "ERROR_TOO_MANY_POSTS",
            description = "Too many posts were made to a semaphore."
        },
        [299] = {
            id = "ERROR_PARTIAL_COPY",
            description = "Only part of a ReadProcessMemory or WriteProcessMemory request was completed."
        },
        [300] = {
            id = "ERROR_OPLOCK_NOT_GRANTED",
            description = "The oplock request is denied."
        },
        [301] = {
            id = "ERROR_INVALID_OPLOCK_PROTOCOL",
            description = "An invalid oplock acknowledgment was received by the system."
        },
        [302] = {
            id = "ERROR_DISK_TOO_FRAGMENTED",
            description = "The volume is too fragmented to complete this operation."
        },
        [303] = {
            id = "ERROR_DELETE_PENDING",
            description = "The file cannot be opened because it is in the process of being deleted."
        },
        [304] = {
            id = "ERROR_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING",
            description = "Short name settings may not be changed on this volume due to the global registry setting."
        },
        [305] = {
            id = "ERROR_SHORT_NAMES_NOT_ENABLED_ON_VOLUME",
            description = "Short names are not enabled on this volume."
        },
        [306] = {
            id = "ERROR_SECURITY_STREAM_IS_INCONSISTENT",
            description = "The security stream for the given volume is in an inconsistent state. Please run CHKDSK on the volume."
        },
        [307] = {
            id = "ERROR_INVALID_LOCK_RANGE",
            description = "A requested file lock operation cannot be processed due to an invalid byte range."
        },
        [308] = {
            id = "ERROR_IMAGE_SUBSYSTEM_NOT_PRESENT",
            description = "The subsystem needed to support the image type is not present."
        },
        [309] = {
            id = "ERROR_NOTIFICATION_GUID_ALREADY_DEFINED",
            description = "The specified file already has a notification GUID associated with it."
        },
        [310] = {
            id = "ERROR_INVALID_EXCEPTION_HANDLER",
            description = "An invalid exception handler routine has been detected."
        },
        [311] = {
            id = "ERROR_DUPLICATE_PRIVILEGES",
            description = "Duplicate privileges were specified for the token."
        },
        [312] = {
            id = "ERROR_NO_RANGES_PROCESSED",
            description = "No ranges for the specified operation were able to be processed."
        },
        [313] = {
            id = "ERROR_NOT_ALLOWED_ON_SYSTEM_FILE",
            description = "Operation is not allowed on a file system internal file."
        },
        [314] = {
            id = "ERROR_DISK_RESOURCES_EXHAUSTED",
            description = "The physical resources of this disk have been exhausted."
        },
        [315] = {
            id = "ERROR_INVALID_TOKEN",
            description = "The token representing the data is invalid."
        },
        [316] = {
            id = "ERROR_DEVICE_FEATURE_NOT_SUPPORTED",
            description = "The device does not support the command feature."
        },
        [317] = {
            id = "ERROR_MR_MID_NOT_FOUND",
            description = "The system cannot find message text for message number 0x%1 in the message file for %2."
        },
        [318] = {
            id = "ERROR_SCOPE_NOT_FOUND",
            description = "The scope specified was not found."
        },
        [319] = {
            id = "ERROR_UNDEFINED_SCOPE",
            description = "The Central Access Policy specified is not defined on the target machine."
        },
        [320] = {
            id = "ERROR_INVALID_CAP",
            description = "The Central Access Policy obtained from Active Directory is invalid."
        },
        [321] = {
            id = "ERROR_DEVICE_UNREACHABLE",
            description = "The device is unreachable."
        },
        [322] = {
            id = "ERROR_DEVICE_NO_RESOURCES",
            description = "The target device has insufficient resources to complete the operation."
        },
        [323] = {
            id = "ERROR_DATA_CHECKSUM_ERROR",
            description = "A data integrity checksum error occurred. Data in the file stream is corrupt."
        },
        [324] = {
            id = "ERROR_INTERMIXED_KERNEL_EA_OPERATION",
            description = "An attempt was made to modify both a KERNEL and normal Extended Attribute (EA) in the same operation."
        },
        [326] = {
            id = "ERROR_FILE_LEVEL_TRIM_NOT_SUPPORTED",
            description = "Device does not support file-level TRIM."
        },
        [327] = {
            id = "ERROR_OFFSET_ALIGNMENT_VIOLATION",
            description = "The command specified a data offset that does not align to the device's granularity/alignment."
        },
        [328] = {
            id = "ERROR_INVALID_FIELD_IN_PARAMETER_LIST",
            description = "The command specified an invalid field in its parameter list."
        },
        [329] = {
            id = "ERROR_OPERATION_IN_PROGRESS",
            description = "An operation is currently in progress with the device."
        },
        [330] = {
            id = "ERROR_BAD_DEVICE_PATH",
            description = "An attempt was made to send down the command via an invalid path to the target device."
        },
        [331] = {
            id = "ERROR_TOO_MANY_DESCRIPTORS",
            description = "The command specified a number of descriptors that exceeded the maximum supported by the device."
        },
        [332] = {
            id = "ERROR_SCRUB_DATA_DISABLED",
            description = "Scrub is disabled on the specified file."
        },
        [333] = {
            id = "ERROR_NOT_REDUNDANT_STORAGE",
            description = "The storage device does not provide redundancy."
        },
        [334] = {
            id = "ERROR_RESIDENT_FILE_NOT_SUPPORTED",
            description = "An operation is not supported on a resident file."
        },
        [335] = {
            id = "ERROR_COMPRESSED_FILE_NOT_SUPPORTED",
            description = "An operation is not supported on a compressed file."
        },
        [336] = {
            id = "ERROR_DIRECTORY_NOT_SUPPORTED",
            description = "An operation is not supported on a directory."
        },
        [337] = {
            id = "ERROR_NOT_READ_FROM_COPY",
            description = "The specified copy of the requested data could not be read."
        },
        [350] = {
            id = "ERROR_FAIL_NOACTION_REBOOT",
            description = "No action was taken as a system reboot is required."
        },
        [351] = {
            id = "ERROR_FAIL_SHUTDOWN",
            description = "The shutdown operation failed."
        },
        [352] = {
            id = "ERROR_FAIL_RESTART",
            description = "The restart operation failed."
        },
        [353] = {
            id = "ERROR_MAX_SESSIONS_REACHED",
            description = "The maximum number of sessions has been reached."
        },
        [400] = {
            id = "ERROR_THREAD_MODE_ALREADY_BACKGROUND",
            description = "The thread is already in background processing mode."
        },
        [401] = {
            id = "ERROR_THREAD_MODE_NOT_BACKGROUND",
            description = "The thread is not in background processing mode."
        },
        [402] = {
            id = "ERROR_PROCESS_MODE_ALREADY_BACKGROUND",
            description = "The process is already in background processing mode."
        },
        [403] = {
            id = "ERROR_PROCESS_MODE_NOT_BACKGROUND",
            description = "The process is not in background processing mode."
        },
        [487] = {
            id = "ERROR_INVALID_ADDRESS",
            description = "Attempt to access invalid address."
        },
        [500] = {
            id = "ERROR_USER_PROFILE_LOAD",
            description = "User profile cannot be loaded."
        },
        [534] = {
            id = "ERROR_ARITHMETIC_OVERFLOW",
            description = "Arithmetic result exceeded 32 bits."
        },
        [535] = {
            id = "ERROR_PIPE_CONNECTED",
            description = "There is a process on other end of the pipe."
        },
        [536] = {
            id = "ERROR_PIPE_LISTENING",
            description = "Waiting for a process to open the other end of the pipe."
        },
        [537] = {
            id = "ERROR_VERIFIER_STOP",
            description = "Application verifier has found an error in the current process."
        },
        [538] = {
            id = "ERROR_ABIOS_ERROR",
            description = "An error occurred in the ABIOS subsystem."
        },
        [539] = {
            id = "ERROR_WX86_WARNING",
            description = "A warning occurred in the WX86 subsystem."
        },
        [540] = {
            id = "ERROR_WX86_ERROR",
            description = "An error occurred in the WX86 subsystem."
        },
        [541] = {
            id = "ERROR_TIMER_NOT_CANCELED",
            description = "An attempt was made to cancel or set a timer that has an associated APC and the subject thread is not the thread that originally set the timer with an associated APC routine."
        },
        [542] = {
            id = "ERROR_UNWIND",
            description = "Unwind exception code."
        },
        [543] = {
            id = "ERROR_BAD_STACK",
            description = "An invalid or unaligned stack was encountered during an unwind operation."
        },
        [544] = {
            id = "ERROR_INVALID_UNWIND_TARGET",
            description = "An invalid unwind target was encountered during an unwind operation."
        },
        [545] = {
            id = "ERROR_INVALID_PORT_ATTRIBUTES",
            description = "Invalid Object Attributes specified to NtCreatePort or invalid Port Attributes specified to NtConnectPort"
        },
        [546] = {
            id = "ERROR_PORT_MESSAGE_TOO_LONG",
            description = "Length of message passed to NtRequestPort or NtRequestWaitReplyPort was longer than the maximum message allowed by the port."
        },
        [547] = {
            id = "ERROR_INVALID_QUOTA_LOWER",
            description = "An attempt was made to lower a quota limit below the current usage."
        },
        [548] = {
            id = "ERROR_DEVICE_ALREADY_ATTACHED",
            description = "An attempt was made to attach to a device that was already attached to another device."
        },
        [549] = {
            id = "ERROR_INSTRUCTION_MISALIGNMENT",
            description = "An attempt was made to execute an instruction at an unaligned address and the host system does not support unaligned instruction references."
        },
        [550] = {
            id = "ERROR_PROFILING_NOT_STARTED",
            description = "Profiling not started."
        },
        [551] = {
            id = "ERROR_PROFILING_NOT_STOPPED",
            description = "Profiling not stopped."
        },
        [552] = {
            id = "ERROR_COULD_NOT_INTERPRET",
            description = "The passed ACL did not contain the minimum required information."
        },
        [553] = {
            id = "ERROR_PROFILING_AT_LIMIT",
            description = "The number of active profiling objects is at the maximum and no more may be started."
        },
        [554] = {
            id = "ERROR_CANT_WAIT",
            description = "Used to indicate that an operation cannot continue without blocking for I/O."
        },
        [555] = {
            id = "ERROR_CANT_TERMINATE_SELF",
            description = "Indicates that a thread attempted to terminate itself by default (called NtTerminateThread with NULL) and it was the last thread in the current process."
        },
        [556] = {
            id = "ERROR_UNEXPECTED_MM_CREATE_ERR",
            description = "If an MM error is returned which is not defined in the standard FsRtl filter, it is converted to one of the following errors which is guaranteed to be in the filter. In this case information is lost, however, the filter correctly handles the exception."
        },
        [557] = {
            id = "ERROR_UNEXPECTED_MM_MAP_ERROR",
            description = "If an MM error is returned which is not defined in the standard FsRtl filter, it is converted to one of the following errors which is guaranteed to be in the filter. In this case information is lost, however, the filter correctly handles the exception."
        },
        [558] = {
            id = "ERROR_UNEXPECTED_MM_EXTEND_ERR",
            description = "If an MM error is returned which is not defined in the standard FsRtl filter, it is converted to one of the following errors which is guaranteed to be in the filter. In this case information is lost, however, the filter correctly handles the exception."
        },
        [559] = {
            id = "ERROR_BAD_FUNCTION_TABLE",
            description = "A malformed function table was encountered during an unwind operation."
        },
        [560] = {
            id = "ERROR_NO_GUID_TRANSLATION",
            description = "Indicates that an attempt was made to assign protection to a file system file or directory and one of the SIDs in the security descriptor could not be translated into a GUID that could be stored by the file system. This causes the protection attempt to fail, which may cause a file creation attempt to fail."
        },
        [561] = {
            id = "ERROR_INVALID_LDT_SIZE",
            description = "Indicates that an attempt was made to grow an LDT by setting its size, or that the size was not an even number of selectors."
        },
        [563] = {
            id = "ERROR_INVALID_LDT_OFFSET",
            description = "Indicates that the starting value for the LDT information was not an integral multiple of the selector size."
        },
        [564] = {
            id = "ERROR_INVALID_LDT_DESCRIPTOR",
            description = "Indicates that the user supplied an invalid descriptor when trying to set up Ldt descriptors."
        },
        [565] = {
            id = "ERROR_TOO_MANY_THREADS",
            description = "Indicates a process has too many threads to perform the requested action. For example, assignment of a primary token may only be performed when a process has zero or one threads."
        },
        [566] = {
            id = "ERROR_THREAD_NOT_IN_PROCESS",
            description = "An attempt was made to operate on a thread within a specific process, but the thread specified is not in the process specified."
        },
        [567] = {
            id = "ERROR_PAGEFILE_QUOTA_EXCEEDED",
            description = "Page file quota was exceeded."
        },
        [568] = {
            id = "ERROR_LOGON_SERVER_CONFLICT",
            description = "The Netlogon service cannot start because another Netlogon service running in the domain conflicts with the specified role."
        },
        [569] = {
            id = "ERROR_SYNCHRONIZATION_REQUIRED",
            description = "The SAM database on a Windows Server is significantly out of synchronization with the copy on the Domain Controller. A complete synchronization is required."
        },
        [570] = {
            id = "ERROR_NET_OPEN_FAILED",
            description = "The NtCreateFile API failed. This error should never be returned to an application, it is a place holder for the Windows Lan Manager Redirector to use in its internal error mapping routines."
        },
        [571] = {
            id = "ERROR_IO_PRIVILEGE_FAILED",
            description = "{Privilege Failed} The I/O permissions for the process could not be changed."
        },
        [572] = {
            id = "ERROR_CONTROL_C_EXIT",
            description = "{Application Exit by CTRL+C} The application terminated as a result of a CTRL+C."
        },
        [573] = {
            id = "ERROR_MISSING_SYSTEMFILE",
            description = "{Missing System File} The required system file %hs is bad or missing."
        },
        [574] = {
            id = "ERROR_UNHANDLED_EXCEPTION",
            description = "{Application Error} The exception %s (0x%08lx) occurred in the application at location 0x%08lx."
        },
        [575] = {
            id = "ERROR_APP_INIT_FAILURE",
            description = "{Application Error} The application was unable to start correctly (0x%lx). Click OK to close the application."
        },
        [576] = {
            id = "ERROR_PAGEFILE_CREATE_FAILED",
            description = "{Unable to Create Paging File} The creation of the paging file %hs failed (%lx). The requested size was %ld."
        },
        [577] = {
            id = "ERROR_INVALID_IMAGE_HASH",
            description = "Windows cannot verify the digital signature for this file. A recent hardware or software change might have installed a file that is signed incorrectly or damaged, or that might be malicious software from an unknown source."
        },
        [578] = {
            id = "ERROR_NO_PAGEFILE",
            description = "{No Paging File Specified} No paging file was specified in the system configuration."
        },
        [579] = {
            id = "ERROR_ILLEGAL_FLOAT_CONTEXT",
            description = "{EXCEPTION} A real-mode application issued a floating-point instruction and floating-point hardware is not present."
        },
        [580] = {
            id = "ERROR_NO_EVENT_PAIR",
            description = "An event pair synchronization operation was performed using the thread specific client/server event pair object, but no event pair object was associated with the thread."
        },
        [581] = {
            id = "ERROR_DOMAIN_CTRLR_CONFIG_ERROR",
            description = "A Windows Server has an incorrect configuration."
        },
        [582] = {
            id = "ERROR_ILLEGAL_CHARACTER",
            description = "An illegal character was encountered. For a multi-byte character set this includes a lead byte without a succeeding trail byte. For the Unicode character set this includes the characters 0xFFFF and 0xFFFE."
        },
        [583] = {
            id = "ERROR_UNDEFINED_CHARACTER",
            description = "The Unicode character is not defined in the Unicode character set installed on the system."
        },
        [584] = {
            id = "ERROR_FLOPPY_VOLUME",
            description = "The paging file cannot be created on a floppy diskette."
        },
        [585] = {
            id = "ERROR_BIOS_FAILED_TO_CONNECT_INTERRUPT",
            description = "The system BIOS failed to connect a system interrupt to the device or bus for which the device is connected."
        },
        [586] = {
            id = "ERROR_BACKUP_CONTROLLER",
            description = "This operation is only allowed for the Primary Domain Controller of the domain."
        },
        [587] = {
            id = "ERROR_MUTANT_LIMIT_EXCEEDED",
            description = "An attempt was made to acquire a mutant such that its maximum count would have been exceeded."
        },
        [588] = {
            id = "ERROR_FS_DRIVER_REQUIRED",
            description = "A volume has been accessed for which a file system driver is required that has not yet been loaded."
        },
        [589] = {
            id = "ERROR_CANNOT_LOAD_REGISTRY_FILE",
            description = "{Registry File Failure} The registry cannot load the hive (file): %hs or its log or alternate. It is corrupt, absent, or not writable."
        },
        [590] = {
            id = "ERROR_DEBUG_ATTACH_FAILED",
            description = "{Unexpected Failure in DebugActiveProcess} An unexpected failure occurred while processing a DebugActiveProcess API request. You may choose OK to terminate the process, or Cancel to ignore the error."
        },
        [591] = {
            id = "ERROR_SYSTEM_PROCESS_TERMINATED",
            description = "{Fatal System Error} The %hs system process terminated unexpectedly with a status of 0x%08x (0x%08x 0x%08x). The system has been shut down."
        },
        [592] = {
            id = "ERROR_DATA_NOT_ACCEPTED",
            description = "{Data Not Accepted} The TDI client could not handle the data received during an indication."
        },
        [593] = {
            id = "ERROR_VDM_HARD_ERROR",
            description = "NTVDM encountered a hard error."
        },
        [594] = {
            id = "ERROR_DRIVER_CANCEL_TIMEOUT",
            description = "{Cancel Timeout} The driver %hs failed to complete a cancelled I/O request in the allotted time."
        },
        [595] = {
            id = "ERROR_REPLY_MESSAGE_MISMATCH",
            description = "{Reply Message Mismatch} An attempt was made to reply to an LPC message, but the thread specified by the client ID in the message was not waiting on that message."
        },
        [596] = {
            id = "ERROR_LOST_WRITEBEHIND_DATA",
            description = "{Delayed Write Failed} Windows was unable to save all the data for the file %hs. The data has been lost. This error may be caused by a failure of your computer hardware or network connection. Please try to save this file elsewhere."
        },
        [597] = {
            id = "ERROR_CLIENT_SERVER_PARAMETERS_INVALID",
            description = "The parameter(s) passed to the server in the client/server shared memory window were invalid. Too much data may have been put in the shared memory window."
        },
        [598] = {
            id = "ERROR_NOT_TINY_STREAM",
            description = "The stream is not a tiny stream."
        },
        [599] = {
            id = "ERROR_STACK_OVERFLOW_READ",
            description = "The request must be handled by the stack overflow code."
        },
        [600] = {
            id = "ERROR_CONVERT_TO_LARGE",
            description = "Internal OFS status codes indicating how an allocation operation is handled. Either it is retried after the containing onode is moved or the extent stream is converted to a large stream."
        },
        [601] = {
            id = "ERROR_FOUND_OUT_OF_SCOPE",
            description = "The attempt to find the object found an object matching by ID on the volume but it is out of the scope of the handle used for the operation."
        },
        [602] = {
            id = "ERROR_ALLOCATE_BUCKET",
            description = "The bucket array must be grown. Retry transaction after doing so."
        },
        [603] = {
            id = "ERROR_MARSHALL_OVERFLOW",
            description = "The user/kernel marshalling buffer has overflowed."
        },
        [604] = {
            id = "ERROR_INVALID_VARIANT",
            description = "The supplied variant structure contains invalid data."
        },
        [605] = {
            id = "ERROR_BAD_COMPRESSION_BUFFER",
            description = "The specified buffer contains ill-formed data."
        },
        [606] = {
            id = "ERROR_AUDIT_FAILED",
            description = "{Audit Failed} An attempt to generate a security audit failed."
        },
        [607] = {
            id = "ERROR_TIMER_RESOLUTION_NOT_SET",
            description = "The timer resolution was not previously set by the current process."
        },
        [608] = {
            id = "ERROR_INSUFFICIENT_LOGON_INFO",
            description = "There is insufficient account information to log you on."
        },
        [609] = {
            id = "ERROR_BAD_DLL_ENTRYPOINT",
            description = "{Invalid DLL Entrypoint} The dynamic link library %hs is not written correctly. The stack pointer has been left in an inconsistent state. The entrypoint should be declared as WINAPI or STDCALL. Select YES to fail the DLL load. Select NO to continue execution. Selecting NO may cause the application to operate incorrectly."
        },
        [610] = {
            id = "ERROR_BAD_SERVICE_ENTRYPOINT",
            description = "{Invalid Service Callback Entrypoint} The %hs service is not written correctly. The stack pointer has been left in an inconsistent state. The callback entrypoint should be declared as WINAPI or STDCALL. Selecting OK will cause the service to continue operation. However, the service process may operate incorrectly."
        },
        [611] = {
            id = "ERROR_IP_ADDRESS_CONFLICT1",
            description = "There is an IP address conflict with another system on the network."
        },
        [612] = {
            id = "ERROR_IP_ADDRESS_CONFLICT2",
            description = "There is an IP address conflict with another system on the network."
        },
        [613] = {
            id = "ERROR_REGISTRY_QUOTA_LIMIT",
            description = "{Low On Registry Space} The system has reached the maximum size allowed for the system part of the registry. Additional storage requests will be ignored."
        },
        [614] = {
            id = "ERROR_NO_CALLBACK_ACTIVE",
            description = "A callback return system service cannot be executed when no callback is active."
        },
        [615] = {
            id = "ERROR_PWD_TOO_SHORT",
            description = "The password provided is too short to meet the policy of your user account. Please choose a longer password."
        },
        [616] = {
            id = "ERROR_PWD_TOO_RECENT",
            description = "The policy of your user account does not allow you to change passwords too frequently. This is done to prevent users from changing back to a familiar, but potentially discovered, password. If you feel your password has been compromised then please contact your administrator immediately to have a new one assigned."
        },
        [617] = {
            id = "ERROR_PWD_HISTORY_CONFLICT",
            description = "You have attempted to change your password to one that you have used in the past. The policy of your user account does not allow this. Please select a password that you have not previously used."
        },
        [618] = {
            id = "ERROR_UNSUPPORTED_COMPRESSION",
            description = "The specified compression format is unsupported."
        },
        [619] = {
            id = "ERROR_INVALID_HW_PROFILE",
            description = "The specified hardware profile configuration is invalid."
        },
        [620] = {
            id = "ERROR_INVALID_PLUGPLAY_DEVICE_PATH",
            description = "The specified Plug and Play registry device path is invalid."
        },
        [621] = {
            id = "ERROR_QUOTA_LIST_INCONSISTENT",
            description = "The specified quota list is internally inconsistent with its descriptor."
        },
        [622] = {
            id = "ERROR_EVALUATION_EXPIRATION",
            description = "{Windows Evaluation Notification} The evaluation period for this installation of Windows has expired. This system will shutdown in 1 hour. To restore access to this installation of Windows, please upgrade this installation using a licensed distribution of this product."
        },
        [623] = {
            id = "ERROR_ILLEGAL_DLL_RELOCATION",
            description = "{Illegal System DLL Relocation} The system DLL %hs was relocated in memory. The application will not run properly. The relocation occurred because the DLL %hs occupied an address range reserved for Windows system DLLs. The vendor supplying the DLL should be contacted for a new DLL."
        },
        [624] = {
            id = "ERROR_DLL_INIT_FAILED_LOGOFF",
            description = "{DLL Initialization Failed} The application failed to initialize because the window station is shutting down."
        },
        [625] = {
            id = "ERROR_VALIDATE_CONTINUE",
            description = "The validation process needs to continue on to the next step."
        },
        [626] = {
            id = "ERROR_NO_MORE_MATCHES",
            description = "There are no more matches for the current index enumeration."
        },
        [627] = {
            id = "ERROR_RANGE_LIST_CONFLICT",
            description = "The range could not be added to the range list because of a conflict."
        },
        [628] = {
            id = "ERROR_SERVER_SID_MISMATCH",
            description = "The server process is running under a SID different than that required by client."
        },
        [629] = {
            id = "ERROR_CANT_ENABLE_DENY_ONLY",
            description = "A group marked use for deny only cannot be enabled."
        },
        [630] = {
            id = "ERROR_FLOAT_MULTIPLE_FAULTS",
            description = "{EXCEPTION} Multiple floating point faults."
        },
        [631] = {
            id = "ERROR_FLOAT_MULTIPLE_TRAPS",
            description = "{EXCEPTION} Multiple floating point traps."
        },
        [632] = {
            id = "ERROR_NOINTERFACE",
            description = "The requested interface is not supported."
        },
        [633] = {
            id = "ERROR_DRIVER_FAILED_SLEEP",
            description = "{System Standby Failed} The driver %hs does not support standby mode. Updating this driver may allow the system to go to standby mode."
        },
        [634] = {
            id = "ERROR_CORRUPT_SYSTEM_FILE",
            description = "The system file %1 has become corrupt and has been replaced."
        },
        [635] = {
            id = "ERROR_COMMITMENT_MINIMUM",
            description = "{Virtual Memory Minimum Too Low} Your system is low on virtual memory. Windows is increasing the size of your virtual memory paging file. During this process, memory requests for some applications may be denied. For more information, see Help."
        },
        [636] = {
            id = "ERROR_PNP_RESTART_ENUMERATION",
            description = "A device was removed so enumeration must be restarted."
        },
        [637] = {
            id = "ERROR_SYSTEM_IMAGE_BAD_SIGNATURE",
            description = "{Fatal System Error} The system image %s is not properly signed. The file has been replaced with the signed file. The system has been shut down."
        },
        [638] = {
            id = "ERROR_PNP_REBOOT_REQUIRED",
            description = "Device will not start without a reboot."
        },
        [639] = {
            id = "ERROR_INSUFFICIENT_POWER",
            description = "There is not enough power to complete the requested operation."
        },
        [640] = {
            id = "ERROR_MULTIPLE_FAULT_VIOLATION",
            description = "ERROR_MULTIPLE_FAULT_VIOLATION"
        },
        [641] = {
            id = "ERROR_SYSTEM_SHUTDOWN",
            description = "The system is in the process of shutting down."
        },
        [642] = {
            id = "ERROR_PORT_NOT_SET",
            description = "An attempt to remove a processes DebugPort was made, but a port was not already associated with the process."
        },
        [643] = {
            id = "ERROR_DS_VERSION_CHECK_FAILURE",
            description = "This version of Windows is not compatible with the behavior version of directory forest, domain or domain controller."
        },
        [644] = {
            id = "ERROR_RANGE_NOT_FOUND",
            description = "The specified range could not be found in the range list."
        },
        [646] = {
            id = "ERROR_NOT_SAFE_MODE_DRIVER",
            description = "The driver was not loaded because the system is booting into safe mode."
        },
        [647] = {
            id = "ERROR_FAILED_DRIVER_ENTRY",
            description = "The driver was not loaded because it failed its initialization call."
        },
        [648] = {
            id = "ERROR_DEVICE_ENUMERATION_ERROR",
            description = "The \"%hs\" encountered an error while applying power or reading the device configuration. This may be caused by a failure of your hardware or by a poor connection."
        },
        [649] = {
            id = "ERROR_MOUNT_POINT_NOT_RESOLVED",
            description = "The create operation failed because the name contained at least one mount point which resolves to a volume to which the specified device object is not attached."
        },
        [650] = {
            id = "ERROR_INVALID_DEVICE_OBJECT_PARAMETER",
            description = "The device object parameter is either not a valid device object or is not attached to the volume specified by the file name."
        },
        [651] = {
            id = "ERROR_MCA_OCCURED",
            description = "A Machine Check Error has occurred. Please check the system eventlog for additional information."
        },
        [652] = {
            id = "ERROR_DRIVER_DATABASE_ERROR",
            description = "There was error [%2] processing the driver database."
        },
        [653] = {
            id = "ERROR_SYSTEM_HIVE_TOO_LARGE",
            description = "System hive size has exceeded its limit."
        },
        [654] = {
            id = "ERROR_DRIVER_FAILED_PRIOR_UNLOAD",
            description = "The driver could not be loaded because a previous version of the driver is still in memory."
        },
        [655] = {
            id = "ERROR_VOLSNAP_PREPARE_HIBERNATE",
            description = "{Volume Shadow Copy Service} Please wait while the Volume Shadow Copy Service prepares volume %hs for hibernation."
        },
        [656] = {
            id = "ERROR_HIBERNATION_FAILURE",
            description = "The system has failed to hibernate (The error code is %hs). Hibernation will be disabled until the system is restarted."
        },
        [657] = {
            id = "ERROR_PWD_TOO_LONG",
            description = "The password provided is too long to meet the policy of your user account. Please choose a shorter password."
        },
        [665] = {
            id = "ERROR_FILE_SYSTEM_LIMITATION",
            description = "The requested operation could not be completed due to a file system limitation."
        },
        [668] = {
            id = "ERROR_ASSERTION_FAILURE",
            description = "An assertion failure has occurred."
        },
        [669] = {
            id = "ERROR_ACPI_ERROR",
            description = "An error occurred in the ACPI subsystem."
        },
        [670] = {
            id = "ERROR_WOW_ASSERTION",
            description = "WOW Assertion Error."
        },
        [671] = {
            id = "ERROR_PNP_BAD_MPS_TABLE",
            description = "A device is missing in the system BIOS MPS table. This device will not be used. Please contact your system vendor for system BIOS update."
        },
        [672] = {
            id = "ERROR_PNP_TRANSLATION_FAILED",
            description = "A translator failed to translate resources."
        },
        [673] = {
            id = "ERROR_PNP_IRQ_TRANSLATION_FAILED",
            description = "A IRQ translator failed to translate resources."
        },
        [674] = {
            id = "ERROR_PNP_INVALID_ID",
            description = "Driver %2 returned invalid ID for a child device (%3)."
        },
        [675] = {
            id = "ERROR_WAKE_SYSTEM_DEBUGGER",
            description = "{Kernel Debugger Awakened} the system debugger was awakened by an interrupt."
        },
        [676] = {
            id = "ERROR_HANDLES_CLOSED",
            description = "{Handles Closed} Handles to objects have been automatically closed as a result of the requested operation."
        },
        [677] = {
            id = "ERROR_EXTRANEOUS_INFORMATION",
            description = "{Too Much Information} The specified access control list (ACL) contained more information than was expected."
        },
        [678] = {
            id = "ERROR_RXACT_COMMIT_NECESSARY",
            description = "This warning level status indicates that the transaction state already exists for the registry sub-tree, but that a transaction commit was previously aborted. The commit has NOT been completed, but has not been rolled back either (so it may still be committed if desired)."
        },
        [679] = {
            id = "ERROR_MEDIA_CHECK",
            description = "{Media Changed} The media may have changed."
        },
        [680] = {
            id = "ERROR_GUID_SUBSTITUTION_MADE",
            description = "{GUID Substitution} During the translation of a global identifier (GUID) to a Windows security ID (SID), no administratively-defined GUID prefix was found. A substitute prefix was used, which will not compromise system security. However, this may provide a more restrictive access than intended."
        },
        [681] = {
            id = "ERROR_STOPPED_ON_SYMLINK",
            description = "The create operation stopped after reaching a symbolic link."
        },
        [682] = {
            id = "ERROR_LONGJUMP",
            description = "A long jump has been executed."
        },
        [683] = {
            id = "ERROR_PLUGPLAY_QUERY_VETOED",
            description = "The Plug and Play query operation was not successful."
        },
        [684] = {
            id = "ERROR_UNWIND_CONSOLIDATE",
            description = "A frame consolidation has been executed."
        },
        [685] = {
            id = "ERROR_REGISTRY_HIVE_RECOVERED",
            description = "{Registry Hive Recovered} Registry hive (file): %hs was corrupted and it has been recovered. Some data might have been lost."
        },
        [686] = {
            id = "ERROR_DLL_MIGHT_BE_INSECURE",
            description = "The application is attempting to run executable code from the module %hs. This may be insecure. An alternative, %hs, is available. Should the application use the secure module %hs?"
        },
        [687] = {
            id = "ERROR_DLL_MIGHT_BE_INCOMPATIBLE",
            description = "The application is loading executable code from the module %hs. This is secure, but may be incompatible with previous releases of the operating system. An alternative, %hs, is available. Should the application use the secure module %hs?"
        },
        [688] = {
            id = "ERROR_DBG_EXCEPTION_NOT_HANDLED",
            description = "Debugger did not handle the exception."
        },
        [689] = {
            id = "ERROR_DBG_REPLY_LATER",
            description = "Debugger will reply later."
        },
        [690] = {
            id = "ERROR_DBG_UNABLE_TO_PROVIDE_HANDLE",
            description = "Debugger cannot provide handle."
        },
        [691] = {
            id = "ERROR_DBG_TERMINATE_THREAD",
            description = "Debugger terminated thread."
        },
        [692] = {
            id = "ERROR_DBG_TERMINATE_PROCESS",
            description = "Debugger terminated process."
        },
        [693] = {
            id = "ERROR_DBG_CONTROL_C",
            description = "Debugger got control C."
        },
        [694] = {
            id = "ERROR_DBG_PRINTEXCEPTION_C",
            description = "Debugger printed exception on control C."
        },
        [695] = {
            id = "ERROR_DBG_RIPEXCEPTION",
            description = "Debugger received RIP exception."
        },
        [696] = {
            id = "ERROR_DBG_CONTROL_BREAK",
            description = "Debugger received control break."
        },
        [697] = {
            id = "ERROR_DBG_COMMAND_EXCEPTION",
            description = "Debugger command communication exception."
        },
        [698] = {
            id = "ERROR_OBJECT_NAME_EXISTS",
            description = "{Object Exists} An attempt was made to create an object and the object name already existed."
        },
        [699] = {
            id = "ERROR_THREAD_WAS_SUSPENDED",
            description = "{Thread Suspended} A thread termination occurred while the thread was suspended. The thread was resumed, and termination proceeded."
        },
        [700] = {
            id = "ERROR_IMAGE_NOT_AT_BASE",
            description = "{Image Relocated} An image file could not be mapped at the address specified in the image file. Local fixups must be performed on this image."
        },
        [701] = {
            id = "ERROR_RXACT_STATE_CREATED",
            description = "This informational level status indicates that a specified registry sub-tree transaction state did not yet exist and had to be created."
        },
        [702] = {
            id = "ERROR_SEGMENT_NOTIFICATION",
            description = "{Segment Load} A virtual DOS machine (VDM) is loading, unloading, or moving an MS-DOS or Win16 program segment image. An exception is raised so a debugger can load, unload or track symbols and breakpoints within these 16-bit segments."
        },
        [703] = {
            id = "ERROR_BAD_CURRENT_DIRECTORY",
            description = "{Invalid Current Directory} The process cannot switch to the startup current directory %hs. Select OK to set current directory to %hs, or select CANCEL to exit."
        },
        [704] = {
            id = "ERROR_FT_READ_RECOVERY_FROM_BACKUP",
            description = "{Redundant Read} To satisfy a read request, the NT fault-tolerant file system successfully read the requested data from a redundant copy. This was done because the file system encountered a failure on a member of the fault-tolerant volume, but was unable to reassign the failing area of the device."
        },
        [705] = {
            id = "ERROR_FT_WRITE_RECOVERY",
            description = "{Redundant Write} To satisfy a write request, the NT fault-tolerant file system successfully wrote a redundant copy of the information. This was done because the file system encountered a failure on a member of the fault-tolerant volume, but was not able to reassign the failing area of the device."
        },
        [706] = {
            id = "ERROR_IMAGE_MACHINE_TYPE_MISMATCH",
            description = "{Machine Type Mismatch} The image file %hs is valid, but is for a machine type other than the current machine. Select OK to continue, or CANCEL to fail the DLL load."
        },
        [707] = {
            id = "ERROR_RECEIVE_PARTIAL",
            description = "{Partial Data Received} The network transport returned partial data to its client. The remaining data will be sent later."
        },
        [708] = {
            id = "ERROR_RECEIVE_EXPEDITED",
            description = "{Expedited Data Received} The network transport returned data to its client that was marked as expedited by the remote system."
        },
        [709] = {
            id = "ERROR_RECEIVE_PARTIAL_EXPEDITED",
            description = "{Partial Expedited Data Received} The network transport returned partial data to its client and this data was marked as expedited by the remote system. The remaining data will be sent later."
        },
        [710] = {
            id = "ERROR_EVENT_DONE",
            description = "{TDI Event Done} The TDI indication has completed successfully."
        },
        [711] = {
            id = "ERROR_EVENT_PENDING",
            description = "{TDI Event Pending} The TDI indication has entered the pending state."
        },
        [712] = {
            id = "ERROR_CHECKING_FILE_SYSTEM",
            description = "Checking file system on %wZ."
        },
        [713] = {
            id = "ERROR_FATAL_APP_EXIT",
            description = "{Fatal Application Exit} %hs."
        },
        [714] = {
            id = "ERROR_PREDEFINED_HANDLE",
            description = "The specified registry key is referenced by a predefined handle."
        },
        [715] = {
            id = "ERROR_WAS_UNLOCKED",
            description = "{Page Unlocked} The page protection of a locked page was changed to 'No Access' and the page was unlocked from memory and from the process."
        },
        [716] = {
            id = "ERROR_SERVICE_NOTIFICATION",
            description = "%hs"
        },
        [717] = {
            id = "ERROR_WAS_LOCKED",
            description = "{Page Locked} One of the pages to lock was already locked."
        },
        [718] = {
            id = "ERROR_LOG_HARD_ERROR",
            description = "Application popup: %1 : %2"
        },
        [719] = {
            id = "ERROR_ALREADY_WIN32",
            description = "ERROR_ALREADY_WIN32"
        },
        [720] = {
            id = "ERROR_IMAGE_MACHINE_TYPE_MISMATCH_EXE",
            description = "{Machine Type Mismatch} The image file %hs is valid, but is for a machine type other than the current machine."
        },
        [721] = {
            id = "ERROR_NO_YIELD_PERFORMED",
            description = "A yield execution was performed and no thread was available to run."
        },
        [722] = {
            id = "ERROR_TIMER_RESUME_IGNORED",
            description = "The resumable flag to a timer API was ignored."
        },
        [723] = {
            id = "ERROR_ARBITRATION_UNHANDLED",
            description = "The arbiter has deferred arbitration of these resources to its parent."
        },
        [724] = {
            id = "ERROR_CARDBUS_NOT_SUPPORTED",
            description = "The inserted CardBus device cannot be started because of a configuration error on \"%hs\"."
        },
        [725] = {
            id = "ERROR_MP_PROCESSOR_MISMATCH",
            description = "The CPUs in this multiprocessor system are not all the same revision level. To use all processors the operating system restricts itself to the features of the least capable processor in the system. Should problems occur with this system, contact the CPU manufacturer to see if this mix of processors is supported."
        },
        [726] = {
            id = "ERROR_HIBERNATED",
            description = "The system was put into hibernation."
        },
        [727] = {
            id = "ERROR_RESUME_HIBERNATION",
            description = "The system was resumed from hibernation."
        },
        [728] = {
            id = "ERROR_FIRMWARE_UPDATED",
            description = "Windows has detected that the system firmware (BIOS) was updated [previous firmware date = %2, current firmware date %3]."
        },
        [729] = {
            id = "ERROR_DRIVERS_LEAKING_LOCKED_PAGES",
            description = "A device driver is leaking locked I/O pages causing system degradation. The system has automatically enabled tracking code in order to try and catch the culprit."
        },
        [730] = {
            id = "ERROR_WAKE_SYSTEM",
            description = "The system has awoken."
        },
        [731] = {
            id = "ERROR_WAIT_1",
            description = "ERROR_WAIT_1"
        },
        [732] = {
            id = "ERROR_WAIT_2",
            description = "ERROR_WAIT_2"
        },
        [733] = {
            id = "ERROR_WAIT_3",
            description = "ERROR_WAIT_3"
        },
        [734] = {
            id = "ERROR_WAIT_63",
            description = "ERROR_WAIT_63"
        },
        [735] = {
            id = "ERROR_ABANDONED_WAIT_0",
            description = "ERROR_ABANDONED_WAIT_0"
        },
        [736] = {
            id = "ERROR_ABANDONED_WAIT_63",
            description = "ERROR_ABANDONED_WAIT_63"
        },
        [737] = {
            id = "ERROR_USER_APC",
            description = "ERROR_USER_APC"
        },
        [738] = {
            id = "ERROR_KERNEL_APC",
            description = "ERROR_KERNEL_APC"
        },
        [739] = {
            id = "ERROR_ALERTED",
            description = "ERROR_ALERTED"
        },
        [740] = {
            id = "ERROR_ELEVATION_REQUIRED",
            description = "The requested operation requires elevation."
        },
        [741] = {
            id = "ERROR_REPARSE",
            description = "A reparse should be performed by the Object Manager since the name of the file resulted in a symbolic link."
        },
        [742] = {
            id = "ERROR_OPLOCK_BREAK_IN_PROGRESS",
            description = "An open/create operation completed while an oplock break is underway."
        },
        [743] = {
            id = "ERROR_VOLUME_MOUNTED",
            description = "A new volume has been mounted by a file system."
        },
        [744] = {
            id = "ERROR_RXACT_COMMITTED",
            description = "This success level status indicates that the transaction state already exists for the registry sub-tree, but that a transaction commit was previously aborted. The commit has now been completed."
        },
        [745] = {
            id = "ERROR_NOTIFY_CLEANUP",
            description = "This indicates that a notify change request has been completed due to closing the handle which made the notify change request."
        },
        [746] = {
            id = "ERROR_PRIMARY_TRANSPORT_CONNECT_FAILED",
            description = "{Connect Failure on Primary Transport} An attempt was made to connect to the remote server %hs on the primary transport, but the connection failed. The computer WAS able to connect on a secondary transport."
        },
        [747] = {
            id = "ERROR_PAGE_FAULT_TRANSITION",
            description = "Page fault was a transition fault."
        },
        [748] = {
            id = "ERROR_PAGE_FAULT_DEMAND_ZERO",
            description = "Page fault was a demand zero fault."
        },
        [749] = {
            id = "ERROR_PAGE_FAULT_COPY_ON_WRITE",
            description = "Page fault was a demand zero fault."
        },
        [750] = {
            id = "ERROR_PAGE_FAULT_GUARD_PAGE",
            description = "Page fault was a demand zero fault."
        },
        [751] = {
            id = "ERROR_PAGE_FAULT_PAGING_FILE",
            description = "Page fault was satisfied by reading from a secondary storage device."
        },
        [752] = {
            id = "ERROR_CACHE_PAGE_LOCKED",
            description = "Cached page was locked during operation."
        },
        [753] = {
            id = "ERROR_CRASH_DUMP",
            description = "Crash dump exists in paging file."
        },
        [754] = {
            id = "ERROR_BUFFER_ALL_ZEROS",
            description = "Specified buffer contains all zeros."
        },
        [755] = {
            id = "ERROR_REPARSE_OBJECT",
            description = "A reparse should be performed by the Object Manager since the name of the file resulted in a symbolic link."
        },
        [756] = {
            id = "ERROR_RESOURCE_REQUIREMENTS_CHANGED",
            description = "The device has succeeded a query-stop and its resource requirements have changed."
        },
        [757] = {
            id = "ERROR_TRANSLATION_COMPLETE",
            description = "The translator has translated these resources into the global space and no further translations should be performed."
        },
        [758] = {
            id = "ERROR_NOTHING_TO_TERMINATE",
            description = "A process being terminated has no threads to terminate."
        },
        [759] = {
            id = "ERROR_PROCESS_NOT_IN_JOB",
            description = "The specified process is not part of a job."
        },
        [760] = {
            id = "ERROR_PROCESS_IN_JOB",
            description = "The specified process is part of a job."
        },
        [761] = {
            id = "ERROR_VOLSNAP_HIBERNATE_READY",
            description = "{Volume Shadow Copy Service} The system is now ready for hibernation."
        },
        [762] = {
            id = "ERROR_FSFILTER_OP_COMPLETED_SUCCESSFULLY",
            description = "A file system or file system filter driver has successfully completed an FsFilter operation."
        },
        [763] = {
            id = "ERROR_INTERRUPT_VECTOR_ALREADY_CONNECTED",
            description = "The specified interrupt vector was already connected."
        },
        [764] = {
            id = "ERROR_INTERRUPT_STILL_CONNECTED",
            description = "The specified interrupt vector is still connected."
        },
        [765] = {
            id = "ERROR_WAIT_FOR_OPLOCK",
            description = "An operation is blocked waiting for an oplock."
        },
        [766] = {
            id = "ERROR_DBG_EXCEPTION_HANDLED",
            description = "Debugger handled exception."
        },
        [767] = {
            id = "ERROR_DBG_CONTINUE",
            description = "Debugger continued."
        },
        [768] = {
            id = "ERROR_CALLBACK_POP_STACK",
            description = "An exception occurred in a user mode callback and the kernel callback frame should be removed."
        },
        [769] = {
            id = "ERROR_COMPRESSION_DISABLED",
            description = "Compression is disabled for this volume."
        },
        [770] = {
            id = "ERROR_CANTFETCHBACKWARDS",
            description = "The data provider cannot fetch backwards through a result set."
        },
        [771] = {
            id = "ERROR_CANTSCROLLBACKWARDS",
            description = "The data provider cannot scroll backwards through a result set."
        },
        [772] = {
            id = "ERROR_ROWSNOTRELEASED",
            description = "The data provider requires that previously fetched data is released before asking for more data."
        },
        [773] = {
            id = "ERROR_BAD_ACCESSOR_FLAGS",
            description = "The data provider was not able to interpret the flags set for a column binding in an accessor."
        },
        [774] = {
            id = "ERROR_ERRORS_ENCOUNTERED",
            description = "One or more errors occurred while processing the request."
        },
        [775] = {
            id = "ERROR_NOT_CAPABLE",
            description = "The implementation is not capable of performing the request."
        },
        [776] = {
            id = "ERROR_REQUEST_OUT_OF_SEQUENCE",
            description = "The client of a component requested an operation which is not valid given the state of the component instance."
        },
        [777] = {
            id = "ERROR_VERSION_PARSE_ERROR",
            description = "A version number could not be parsed."
        },
        [778] = {
            id = "ERROR_BADSTARTPOSITION",
            description = "The iterator's start position is invalid."
        },
        [779] = {
            id = "ERROR_MEMORY_HARDWARE",
            description = "The hardware has reported an uncorrectable memory error."
        },
        [780] = {
            id = "ERROR_DISK_REPAIR_DISABLED",
            description = "The attempted operation required self healing to be enabled."
        },
        [781] = {
            id = "ERROR_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE",
            description = "The Desktop heap encountered an error while allocating session memory. There is more information in the system event log."
        },
        [782] = {
            id = "ERROR_SYSTEM_POWERSTATE_TRANSITION",
            description = "The system power state is transitioning from %2 to %3."
        },
        [783] = {
            id = "ERROR_SYSTEM_POWERSTATE_COMPLEX_TRANSITION",
            description = "The system power state is transitioning from %2 to %3 but could enter %4."
        },
        [784] = {
            id = "ERROR_MCA_EXCEPTION",
            description = "A thread is getting dispatched with MCA EXCEPTION because of MCA."
        },
        [785] = {
            id = "ERROR_ACCESS_AUDIT_BY_POLICY",
            description = "Access to %1 is monitored by policy rule %2."
        },
        [786] = {
            id = "ERROR_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY",
            description = "Access to %1 has been restricted by your Administrator by policy rule %2."
        },
        [787] = {
            id = "ERROR_ABANDON_HIBERFILE",
            description = "A valid hibernation file has been invalidated and should be abandoned."
        },
        [788] = {
            id = "ERROR_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED",
            description = "{Delayed Write Failed} Windows was unable to save all the data for the file %hs; the data has been lost. This error may be caused by network connectivity issues. Please try to save this file elsewhere."
        },
        [789] = {
            id = "ERROR_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR",
            description = "{Delayed Write Failed} Windows was unable to save all the data for the file %hs; the data has been lost. This error was returned by the server on which the file exists. Please try to save this file elsewhere."
        },
        [790] = {
            id = "ERROR_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR",
            description = "{Delayed Write Failed} Windows was unable to save all the data for the file %hs; the data has been lost. This error may be caused if the device has been removed or the media is write-protected."
        },
        [791] = {
            id = "ERROR_BAD_MCFG_TABLE",
            description = "The resources required for this device conflict with the MCFG table."
        },
        [792] = {
            id = "ERROR_DISK_REPAIR_REDIRECTED",
            description = "The volume repair could not be performed while it is online. Please schedule to take the volume offline so that it can be repaired."
        },
        [793] = {
            id = "ERROR_DISK_REPAIR_UNSUCCESSFUL",
            description = "The volume repair was not successful."
        },
        [794] = {
            id = "ERROR_CORRUPT_LOG_OVERFULL",
            description = "One of the volume corruption logs is full. Further corruptions that may be detected won't be logged."
        },
        [795] = {
            id = "ERROR_CORRUPT_LOG_CORRUPTED",
            description = "One of the volume corruption logs is internally corrupted and needs to be recreated. The volume may contain undetected corruptions and must be scanned."
        },
        [796] = {
            id = "ERROR_CORRUPT_LOG_UNAVAILABLE",
            description = "One of the volume corruption logs is unavailable for being operated on."
        },
        [797] = {
            id = "ERROR_CORRUPT_LOG_DELETED_FULL",
            description = "One of the volume corruption logs was deleted while still having corruption records in them. The volume contains detected corruptions and must be scanned."
        },
        [798] = {
            id = "ERROR_CORRUPT_LOG_CLEARED",
            description = "One of the volume corruption logs was cleared by chkdsk and no longer contains real corruptions."
        },
        [799] = {
            id = "ERROR_ORPHAN_NAME_EXHAUSTED",
            description = "Orphaned files exist on the volume but could not be recovered because no more new names could be created in the recovery directory. Files must be moved from the recovery directory."
        },
        [800] = {
            id = "ERROR_OPLOCK_SWITCHED_TO_NEW_HANDLE",
            description = "The oplock that was associated with this handle is now associated with a different handle."
        },
        [801] = {
            id = "ERROR_CANNOT_GRANT_REQUESTED_OPLOCK",
            description = "An oplock of the requested level cannot be granted. An oplock of a lower level may be available."
        },
        [802] = {
            id = "ERROR_CANNOT_BREAK_OPLOCK",
            description = "The operation did not complete successfully because it would cause an oplock to be broken. The caller has requested that existing oplocks not be broken."
        },
        [803] = {
            id = "ERROR_OPLOCK_HANDLE_CLOSED",
            description = "The handle with which this oplock was associated has been closed. The oplock is now broken."
        },
        [804] = {
            id = "ERROR_NO_ACE_CONDITION",
            description = "The specified access control entry (ACE) does not contain a condition."
        },
        [805] = {
            id = "ERROR_INVALID_ACE_CONDITION",
            description = "The specified access control entry (ACE) contains an invalid condition."
        },
        [806] = {
            id = "ERROR_FILE_HANDLE_REVOKED",
            description = "Access to the specified file handle has been revoked."
        },
        [807] = {
            id = "ERROR_IMAGE_AT_DIFFERENT_BASE",
            description = "An image file was mapped at a different address from the one specified in the image file but fixups will still be automatically performed on the image."
        },
        [994] = {
            id = "ERROR_EA_ACCESS_DENIED",
            description = "Access to the extended attribute was denied."
        },
        [995] = {
            id = "ERROR_OPERATION_ABORTED",
            description = "The I/O operation has been aborted because of either a thread exit or an application request."
        },
        [996] = {
            id = "ERROR_IO_INCOMPLETE",
            description = "Overlapped I/O event is not in a signaled state."
        },
        [997] = {
            id = "ERROR_IO_PENDING",
            description = "Overlapped I/O operation is in progress."
        },
        [998] = {
            id = "ERROR_NOACCESS",
            description = "Invalid access to memory location."
        },
        [999] = {
            id = "ERROR_SWAPERROR",
            description = "Error performing inpage operation."
        },
        [1001] = {
            id = "ERROR_STACK_OVERFLOW",
            description = "Recursion too deep; the stack overflowed."
        },
        [1002] = {
            id = "ERROR_INVALID_MESSAGE",
            description = "The window cannot act on the sent message."
        },
        [1003] = {
            id = "ERROR_CAN_NOT_COMPLETE",
            description = "Cannot complete this function."
        },
        [1004] = {
            id = "ERROR_INVALID_FLAGS",
            description = "Invalid flags."
        },
        [1005] = {
            id = "ERROR_UNRECOGNIZED_VOLUME",
            description = "The volume does not contain a recognized file system. Please make sure that all required file system drivers are loaded and that the volume is not corrupted."
        },
        [1006] = {
            id = "ERROR_FILE_INVALID",
            description = "The volume for a file has been externally altered so that the opened file is no longer valid."
        },
        [1007] = {
            id = "ERROR_FULLSCREEN_MODE",
            description = "The requested operation cannot be performed in full-screen mode."
        },
        [1008] = {
            id = "ERROR_NO_TOKEN",
            description = "An attempt was made to reference a token that does not exist."
        },
        [1009] = {
            id = "ERROR_BADDB",
            description = "The configuration registry database is corrupt."
        },
        [1010] = {
            id = "ERROR_BADKEY",
            description = "The configuration registry key is invalid."
        },
        [1011] = {
            id = "ERROR_CANTOPEN",
            description = "The configuration registry key could not be opened."
        },
        [1012] = {
            id = "ERROR_CANTREAD",
            description = "The configuration registry key could not be read."
        },
        [1013] = {
            id = "ERROR_CANTWRITE",
            description = "The configuration registry key could not be written."
        },
        [1014] = {
            id = "ERROR_REGISTRY_RECOVERED",
            description = "One of the files in the registry database had to be recovered by use of a log or alternate copy. The recovery was successful."
        },
        [1015] = {
            id = "ERROR_REGISTRY_CORRUPT",
            description = "The registry is corrupted. The structure of one of the files containing registry data is corrupted, or the system's memory image of the file is corrupted, or the file could not be recovered because the alternate copy or log was absent or corrupted."
        },
        [1016] = {
            id = "ERROR_REGISTRY_IO_FAILED",
            description = "An I/O operation initiated by the registry failed unrecoverably. The registry could not read in, or write out, or flush, one of the files that contain the system's image of the registry."
        },
        [1017] = {
            id = "ERROR_NOT_REGISTRY_FILE",
            description = "The system has attempted to load or restore a file into the registry, but the specified file is not in a registry file format."
        },
        [1018] = {
            id = "ERROR_KEY_DELETED",
            description = "Illegal operation attempted on a registry key that has been marked for deletion."
        },
        [1019] = {
            id = "ERROR_NO_LOG_SPACE",
            description = "System could not allocate the required space in a registry log."
        },
        [1020] = {
            id = "ERROR_KEY_HAS_CHILDREN",
            description = "Cannot create a symbolic link in a registry key that already has subkeys or values."
        },
        [1021] = {
            id = "ERROR_CHILD_MUST_BE_VOLATILE",
            description = "Cannot create a stable subkey under a volatile parent key."
        },
        [1022] = {
            id = "ERROR_NOTIFY_ENUM_DIR",
            description = "A notify change request is being completed and the information is not being returned in the caller's buffer. The caller now needs to enumerate the files to find the changes."
        },
        [1051] = {
            id = "ERROR_DEPENDENT_SERVICES_RUNNING",
            description = "A stop control has been sent to a service that other running services are dependent on."
        },
        [1052] = {
            id = "ERROR_INVALID_SERVICE_CONTROL",
            description = "The requested control is not valid for this service."
        },
        [1053] = {
            id = "ERROR_SERVICE_REQUEST_TIMEOUT",
            description = "The service did not respond to the start or control request in a timely fashion."
        },
        [1054] = {
            id = "ERROR_SERVICE_NO_THREAD",
            description = "A thread could not be created for the service."
        },
        [1055] = {
            id = "ERROR_SERVICE_DATABASE_LOCKED",
            description = "The service database is locked."
        },
        [1056] = {
            id = "ERROR_SERVICE_ALREADY_RUNNING",
            description = "An instance of the service is already running."
        },
        [1057] = {
            id = "ERROR_INVALID_SERVICE_ACCOUNT",
            description = "The account name is invalid or does not exist, or the password is invalid for the account name specified."
        },
        [1058] = {
            id = "ERROR_SERVICE_DISABLED",
            description = "The service cannot be started, either because it is disabled or because it has no enabled devices associated with it."
        },
        [1059] = {
            id = "ERROR_CIRCULAR_DEPENDENCY",
            description = "Circular service dependency was specified."
        },
        [1060] = {
            id = "ERROR_SERVICE_DOES_NOT_EXIST",
            description = "The specified service does not exist as an installed service."
        },
        [1061] = {
            id = "ERROR_SERVICE_CANNOT_ACCEPT_CTRL",
            description = "The service cannot accept control messages at this time."
        },
        [1062] = {
            id = "ERROR_SERVICE_NOT_ACTIVE",
            description = "The service has not been started."
        },
        [1063] = {
            id = "ERROR_FAILED_SERVICE_CONTROLLER_CONNECT",
            description = "The service process could not connect to the service controller."
        },
        [1064] = {
            id = "ERROR_EXCEPTION_IN_SERVICE",
            description = "An exception occurred in the service when handling the control request."
        },
        [1065] = {
            id = "ERROR_DATABASE_DOES_NOT_EXIST",
            description = "The database specified does not exist."
        },
        [1066] = {
            id = "ERROR_SERVICE_SPECIFIC_ERROR",
            description = "The service has returned a service-specific error code."
        },
        [1067] = {
            id = "ERROR_PROCESS_ABORTED",
            description = "The process terminated unexpectedly."
        },
        [1068] = {
            id = "ERROR_SERVICE_DEPENDENCY_FAIL",
            description = "The dependency service or group failed to start."
        },
        [1069] = {
            id = "ERROR_SERVICE_LOGON_FAILED",
            description = "The service did not start due to a logon failure."
        },
        [1070] = {
            id = "ERROR_SERVICE_START_HANG",
            description = "After starting, the service hung in a start-pending state."
        },
        [1071] = {
            id = "ERROR_INVALID_SERVICE_LOCK",
            description = "The specified service database lock is invalid."
        },
        [1072] = {
            id = "ERROR_SERVICE_MARKED_FOR_DELETE",
            description = "The specified service has been marked for deletion."
        },
        [1073] = {
            id = "ERROR_SERVICE_EXISTS",
            description = "The specified service already exists."
        },
        [1074] = {
            id = "ERROR_ALREADY_RUNNING_LKG",
            description = "The system is currently running with the last-known-good configuration."
        },
        [1075] = {
            id = "ERROR_SERVICE_DEPENDENCY_DELETED",
            description = "The dependency service does not exist or has been marked for deletion."
        },
        [1076] = {
            id = "ERROR_BOOT_ALREADY_ACCEPTED",
            description = "The current boot has already been accepted for use as the last-known-good control set."
        },
        [1077] = {
            id = "ERROR_SERVICE_NEVER_STARTED",
            description = "No attempts to start the service have been made since the last boot."
        },
        [1078] = {
            id = "ERROR_DUPLICATE_SERVICE_NAME",
            description = "The name is already in use as either a service name or a service display name."
        },
        [1079] = {
            id = "ERROR_DIFFERENT_SERVICE_ACCOUNT",
            description = "The account specified for this service is different from the account specified for other services running in the same process."
        },
        [1080] = {
            id = "ERROR_CANNOT_DETECT_DRIVER_FAILURE",
            description = "Failure actions can only be set for Win32 services, not for drivers."
        },
        [1081] = {
            id = "ERROR_CANNOT_DETECT_PROCESS_ABORT",
            description = "This service runs in the same process as the service control manager. Therefore, the service control manager cannot take action if this service's process terminates unexpectedly."
        },
        [1082] = {
            id = "ERROR_NO_RECOVERY_PROGRAM",
            description = "No recovery program has been configured for this service."
        },
        [1083] = {
            id = "ERROR_SERVICE_NOT_IN_EXE",
            description = "The executable program that this service is configured to run in does not implement the service."
        },
        [1084] = {
            id = "ERROR_NOT_SAFEBOOT_SERVICE",
            description = "This service cannot be started in Safe Mode."
        },
        [1100] = {
            id = "ERROR_END_OF_MEDIA",
            description = "The physical end of the tape has been reached."
        },
        [1101] = {
            id = "ERROR_FILEMARK_DETECTED",
            description = "A tape access reached a filemark."
        },
        [1102] = {
            id = "ERROR_BEGINNING_OF_MEDIA",
            description = "The beginning of the tape or a partition was encountered."
        },
        [1103] = {
            id = "ERROR_SETMARK_DETECTED",
            description = "A tape access reached the end of a set of files."
        },
        [1104] = {
            id = "ERROR_NO_DATA_DETECTED",
            description = "No more data is on the tape."
        },
        [1105] = {
            id = "ERROR_PARTITION_FAILURE",
            description = "Tape could not be partitioned."
        },
        [1106] = {
            id = "ERROR_INVALID_BLOCK_LENGTH",
            description = "When accessing a new tape of a multivolume partition, the current block size is incorrect."
        },
        [1107] = {
            id = "ERROR_DEVICE_NOT_PARTITIONED",
            description = "Tape partition information could not be found when loading a tape."
        },
        [1108] = {
            id = "ERROR_UNABLE_TO_LOCK_MEDIA",
            description = "Unable to lock the media eject mechanism."
        },
        [1109] = {
            id = "ERROR_UNABLE_TO_UNLOAD_MEDIA",
            description = "Unable to unload the media."
        },
        [1110] = {
            id = "ERROR_MEDIA_CHANGED",
            description = "The media in the drive may have changed."
        },
        [1111] = {
            id = "ERROR_BUS_RESET",
            description = "The I/O bus was reset."
        },
        [1112] = {
            id = "ERROR_NO_MEDIA_IN_DRIVE",
            description = "No media in drive."
        },
        [1113] = {
            id = "ERROR_NO_UNICODE_TRANSLATION",
            description = "No mapping for the Unicode character exists in the target multi-byte code page."
        },
        [1114] = {
            id = "ERROR_DLL_INIT_FAILED",
            description = "A dynamic link library (DLL) initialization routine failed."
        },
        [1115] = {
            id = "ERROR_SHUTDOWN_IN_PROGRESS",
            description = "A system shutdown is in progress."
        },
        [1116] = {
            id = "ERROR_NO_SHUTDOWN_IN_PROGRESS",
            description = "Unable to abort the system shutdown because no shutdown was in progress."
        },
        [1117] = {
            id = "ERROR_IO_DEVICE",
            description = "The request could not be performed because of an I/O device error."
        },
        [1118] = {
            id = "ERROR_SERIAL_NO_DEVICE",
            description = "No serial device was successfully initialized. The serial driver will unload."
        },
        [1119] = {
            id = "ERROR_IRQ_BUSY",
            description = "Unable to open a device that was sharing an interrupt request (IRQ) with other devices. At least one other device that uses that IRQ was already opened."
        },
        [1120] = {
            id = "ERROR_MORE_WRITES",
            description = "A serial I/O operation was completed by another write to the serial port. The IOCTL_SERIAL_XOFF_COUNTER reached zero.)"
        },
        [1121] = {
            id = "ERROR_COUNTER_TIMEOUT",
            description = "A serial I/O operation completed because the timeout period expired. The IOCTL_SERIAL_XOFF_COUNTER did not reach zero.)"
        },
        [1122] = {
            id = "ERROR_FLOPPY_ID_MARK_NOT_FOUND",
            description = "No ID address mark was found on the floppy disk."
        },
        [1123] = {
            id = "ERROR_FLOPPY_WRONG_CYLINDER",
            description = "Mismatch between the floppy disk sector ID field and the floppy disk controller track address."
        },
        [1124] = {
            id = "ERROR_FLOPPY_UNKNOWN_ERROR",
            description = "The floppy disk controller reported an error that is not recognized by the floppy disk driver."
        },
        [1125] = {
            id = "ERROR_FLOPPY_BAD_REGISTERS",
            description = "The floppy disk controller returned inconsistent results in its registers."
        },
        [1126] = {
            id = "ERROR_DISK_RECALIBRATE_FAILED",
            description = "While accessing the hard disk, a recalibrate operation failed, even after retries."
        },
        [1127] = {
            id = "ERROR_DISK_OPERATION_FAILED",
            description = "While accessing the hard disk, a disk operation failed even after retries."
        },
        [1128] = {
            id = "ERROR_DISK_RESET_FAILED",
            description = "While accessing the hard disk, a disk controller reset was needed, but even that failed."
        },
        [1129] = {
            id = "ERROR_EOM_OVERFLOW",
            description = "Physical end of tape encountered."
        },
        [1130] = {
            id = "ERROR_NOT_ENOUGH_SERVER_MEMORY",
            description = "Not enough server storage is available to process this command."
        },
        [1131] = {
            id = "ERROR_POSSIBLE_DEADLOCK",
            description = "A potential deadlock condition has been detected."
        },
        [1132] = {
            id = "ERROR_MAPPED_ALIGNMENT",
            description = "The base address or the file offset specified does not have the proper alignment."
        },
        [1140] = {
            id = "ERROR_SET_POWER_STATE_VETOED",
            description = "An attempt to change the system power state was vetoed by another application or driver."
        },
        [1141] = {
            id = "ERROR_SET_POWER_STATE_FAILED",
            description = "The system BIOS failed an attempt to change the system power state."
        },
        [1142] = {
            id = "ERROR_TOO_MANY_LINKS",
            description = "An attempt was made to create more links on a file than the file system supports."
        },
        [1150] = {
            id = "ERROR_OLD_WIN_VERSION",
            description = "The specified program requires a newer version of Windows."
        },
        [1151] = {
            id = "ERROR_APP_WRONG_OS",
            description = "The specified program is not a Windows or MS-DOS program."
        },
        [1152] = {
            id = "ERROR_SINGLE_INSTANCE_APP",
            description = "Cannot start more than one instance of the specified program."
        },
        [1153] = {
            id = "ERROR_RMODE_APP",
            description = "The specified program was written for an earlier version of Windows."
        },
        [1154] = {
            id = "ERROR_INVALID_DLL",
            description = "One of the library files needed to run this application is damaged."
        },
        [1155] = {
            id = "ERROR_NO_ASSOCIATION",
            description = "No application is associated with the specified file for this operation."
        },
        [1156] = {
            id = "ERROR_DDE_FAIL",
            description = "An error occurred in sending the command to the application."
        },
        [1157] = {
            id = "ERROR_DLL_NOT_FOUND",
            description = "One of the library files needed to run this application cannot be found."
        },
        [1158] = {
            id = "ERROR_NO_MORE_USER_HANDLES",
            description = "The current process has used all of its system allowance of handles for Window Manager objects."
        },
        [1159] = {
            id = "ERROR_MESSAGE_SYNC_ONLY",
            description = "The message can be used only with synchronous operations."
        },
        [1160] = {
            id = "ERROR_SOURCE_ELEMENT_EMPTY",
            description = "The indicated source element has no media."
        },
        [1161] = {
            id = "ERROR_DESTINATION_ELEMENT_FULL",
            description = "The indicated destination element already contains media."
        },
        [1162] = {
            id = "ERROR_ILLEGAL_ELEMENT_ADDRESS",
            description = "The indicated element does not exist."
        },
        [1163] = {
            id = "ERROR_MAGAZINE_NOT_PRESENT",
            description = "The indicated element is part of a magazine that is not present."
        },
        [1164] = {
            id = "ERROR_DEVICE_REINITIALIZATION_NEEDED",
            description = "The indicated device requires reinitialization due to hardware errors."
        },
        [1165] = {
            id = "ERROR_DEVICE_REQUIRES_CLEANING",
            description = "The device has indicated that cleaning is required before further operations are attempted."
        },
        [1166] = {
            id = "ERROR_DEVICE_DOOR_OPEN",
            description = "The device has indicated that its door is open."
        },
        [1167] = {
            id = "ERROR_DEVICE_NOT_CONNECTED",
            description = "The device is not connected."
        },
        [1168] = {
            id = "ERROR_NOT_FOUND",
            description = "Element not found."
        },
        [1169] = {
            id = "ERROR_NO_MATCH",
            description = "There was no match for the specified key in the index."
        },
        [1170] = {
            id = "ERROR_SET_NOT_FOUND",
            description = "The property set specified does not exist on the object."
        },
        [1171] = {
            id = "ERROR_POINT_NOT_FOUND",
            description = "The point passed to GetMouseMovePoints is not in the buffer."
        },
        [1172] = {
            id = "ERROR_NO_TRACKING_SERVICE",
            description = "The tracking (workstation) service is not running."
        },
        [1173] = {
            id = "ERROR_NO_VOLUME_ID",
            description = "The Volume ID could not be found."
        },
        [1175] = {
            id = "ERROR_UNABLE_TO_REMOVE_REPLACED",
            description = "Unable to remove the file to be replaced."
        },
        [1176] = {
            id = "ERROR_UNABLE_TO_MOVE_REPLACEMENT",
            description = "Unable to move the replacement file to the file to be replaced. The file to be replaced has retained its original name."
        },
        [1177] = {
            id = "ERROR_UNABLE_TO_MOVE_REPLACEMENT_2",
            description = "Unable to move the replacement file to the file to be replaced. The file to be replaced has been renamed using the backup name."
        },
        [1178] = {
            id = "ERROR_JOURNAL_DELETE_IN_PROGRESS",
            description = "The volume change journal is being deleted."
        },
        [1179] = {
            id = "ERROR_JOURNAL_NOT_ACTIVE",
            description = "The volume change journal is not active."
        },
        [1180] = {
            id = "ERROR_POTENTIAL_FILE_FOUND",
            description = "A file was found, but it may not be the correct file."
        },
        [1181] = {
            id = "ERROR_JOURNAL_ENTRY_DELETED",
            description = "The journal entry has been deleted from the journal."
        },
        [1190] = {
            id = "ERROR_SHUTDOWN_IS_SCHEDULED",
            description = "A system shutdown has already been scheduled."
        },
        [1191] = {
            id = "ERROR_SHUTDOWN_USERS_LOGGED_ON",
            description = "The system shutdown cannot be initiated because there are other users logged on to the computer."
        },
        [1200] = {
            id = "ERROR_BAD_DEVICE",
            description = "The specified device name is invalid."
        },
        [1201] = {
            id = "ERROR_CONNECTION_UNAVAIL",
            description = "The device is not currently connected but it is a remembered connection."
        },
        [1202] = {
            id = "ERROR_DEVICE_ALREADY_REMEMBERED",
            description = "The local device name has a remembered connection to another network resource."
        },
        [1203] = {
            id = "ERROR_NO_NET_OR_BAD_PATH",
            description = "The network path was either typed incorrectly, does not exist, or the network provider is not currently available. Please try retyping the path or contact your network administrator."
        },
        [1204] = {
            id = "ERROR_BAD_PROVIDER",
            description = "The specified network provider name is invalid."
        },
        [1205] = {
            id = "ERROR_CANNOT_OPEN_PROFILE",
            description = "Unable to open the network connection profile."
        },
        [1206] = {
            id = "ERROR_BAD_PROFILE",
            description = "The network connection profile is corrupted."
        },
        [1207] = {
            id = "ERROR_NOT_CONTAINER",
            description = "Cannot enumerate a noncontainer."
        },
        [1208] = {
            id = "ERROR_EXTENDED_ERROR",
            description = "An extended error has occurred."
        },
        [1209] = {
            id = "ERROR_INVALID_GROUPNAME",
            description = "The format of the specified group name is invalid."
        },
        [1210] = {
            id = "ERROR_INVALID_COMPUTERNAME",
            description = "The format of the specified computer name is invalid."
        },
        [1211] = {
            id = "ERROR_INVALID_EVENTNAME",
            description = "The format of the specified event name is invalid."
        },
        [1212] = {
            id = "ERROR_INVALID_DOMAINNAME",
            description = "The format of the specified domain name is invalid."
        },
        [1213] = {
            id = "ERROR_INVALID_SERVICENAME",
            description = "The format of the specified service name is invalid."
        },
        [1214] = {
            id = "ERROR_INVALID_NETNAME",
            description = "The format of the specified network name is invalid."
        },
        [1215] = {
            id = "ERROR_INVALID_SHARENAME",
            description = "The format of the specified share name is invalid."
        },
        [1216] = {
            id = "ERROR_INVALID_PASSWORDNAME",
            description = "The format of the specified password is invalid."
        },
        [1217] = {
            id = "ERROR_INVALID_MESSAGENAME",
            description = "The format of the specified message name is invalid."
        },
        [1218] = {
            id = "ERROR_INVALID_MESSAGEDEST",
            description = "The format of the specified message destination is invalid."
        },
        [1219] = {
            id = "ERROR_SESSION_CREDENTIAL_CONFLICT",
            description = "Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed. Disconnect all previous connections to the server or shared resource and try again."
        },
        [1220] = {
            id = "ERROR_REMOTE_SESSION_LIMIT_EXCEEDED",
            description = "An attempt was made to establish a session to a network server, but there are already too many sessions established to that server."
        },
        [1221] = {
            id = "ERROR_DUP_DOMAINNAME",
            description = "The workgroup or domain name is already in use by another computer on the network."
        },
        [1222] = {
            id = "ERROR_NO_NETWORK",
            description = "The network is not present or not started."
        },
        [1223] = {
            id = "ERROR_CANCELLED",
            description = "The operation was canceled by the user."
        },
        [1224] = {
            id = "ERROR_USER_MAPPED_FILE",
            description = "The requested operation cannot be performed on a file with a user-mapped section open."
        },
        [1225] = {
            id = "ERROR_CONNECTION_REFUSED",
            description = "The remote computer refused the network connection."
        },
        [1226] = {
            id = "ERROR_GRACEFUL_DISCONNECT",
            description = "The network connection was gracefully closed."
        },
        [1227] = {
            id = "ERROR_ADDRESS_ALREADY_ASSOCIATED",
            description = "The network transport endpoint already has an address associated with it."
        },
        [1228] = {
            id = "ERROR_ADDRESS_NOT_ASSOCIATED",
            description = "An address has not yet been associated with the network endpoint."
        },
        [1229] = {
            id = "ERROR_CONNECTION_INVALID",
            description = "An operation was attempted on a nonexistent network connection."
        },
        [1230] = {
            id = "ERROR_CONNECTION_ACTIVE",
            description = "An invalid operation was attempted on an active network connection."
        },
        [1231] = {
            id = "ERROR_NETWORK_UNREACHABLE",
            description = "The network location cannot be reached. For information about network troubleshooting, see Windows Help."
        },
        [1232] = {
            id = "ERROR_HOST_UNREACHABLE",
            description = "The network location cannot be reached. For information about network troubleshooting, see Windows Help."
        },
        [1233] = {
            id = "ERROR_PROTOCOL_UNREACHABLE",
            description = "The network location cannot be reached. For information about network troubleshooting, see Windows Help."
        },
        [1234] = {
            id = "ERROR_PORT_UNREACHABLE",
            description = "No service is operating at the destination network endpoint on the remote system."
        },
        [1235] = {
            id = "ERROR_REQUEST_ABORTED",
            description = "The request was aborted."
        },
        [1236] = {
            id = "ERROR_CONNECTION_ABORTED",
            description = "The network connection was aborted by the local system."
        },
        [1237] = {
            id = "ERROR_RETRY",
            description = "The operation could not be completed. A retry should be performed."
        },
        [1238] = {
            id = "ERROR_CONNECTION_COUNT_LIMIT",
            description = "A connection to the server could not be made because the limit on the number of concurrent connections for this account has been reached."
        },
        [1239] = {
            id = "ERROR_LOGIN_TIME_RESTRICTION",
            description = "Attempting to log in during an unauthorized time of day for this account."
        },
        [1240] = {
            id = "ERROR_LOGIN_WKSTA_RESTRICTION",
            description = "The account is not authorized to log in from this station."
        },
        [1241] = {
            id = "ERROR_INCORRECT_ADDRESS",
            description = "The network address could not be used for the operation requested."
        },
        [1242] = {
            id = "ERROR_ALREADY_REGISTERED",
            description = "The service is already registered."
        },
        [1243] = {
            id = "ERROR_SERVICE_NOT_FOUND",
            description = "The specified service does not exist."
        },
        [1244] = {
            id = "ERROR_NOT_AUTHENTICATED",
            description = "The operation being requested was not performed because the user has not been authenticated."
        },
        [1245] = {
            id = "ERROR_NOT_LOGGED_ON",
            description = "The operation being requested was not performed because the user has not logged on to the network. The specified service does not exist."
        },
        [1246] = {
            id = "ERROR_CONTINUE",
            description = "Continue with work in progress."
        },
        [1247] = {
            id = "ERROR_ALREADY_INITIALIZED",
            description = "An attempt was made to perform an initialization operation when initialization has already been completed."
        },
        [1248] = {
            id = "ERROR_NO_MORE_DEVICES",
            description = "No more local devices."
        },
        [1249] = {
            id = "ERROR_NO_SUCH_SITE",
            description = "The specified site does not exist."
        },
        [1250] = {
            id = "ERROR_DOMAIN_CONTROLLER_EXISTS",
            description = "A domain controller with the specified name already exists."
        },
        [1251] = {
            id = "ERROR_ONLY_IF_CONNECTED",
            description = "This operation is supported only when you are connected to the server."
        },
        [1252] = {
            id = "ERROR_OVERRIDE_NOCHANGES",
            description = "The group policy framework should call the extension even if there are no changes."
        },
        [1253] = {
            id = "ERROR_BAD_USER_PROFILE",
            description = "The specified user does not have a valid profile."
        },
        [1254] = {
            id = "ERROR_NOT_SUPPORTED_ON_SBS",
            description = "This operation is not supported on a computer running Windows Server 2003 for Small Business Server."
        },
        [1255] = {
            id = "ERROR_SERVER_SHUTDOWN_IN_PROGRESS",
            description = "The server machine is shutting down."
        },
        [1256] = {
            id = "ERROR_HOST_DOWN",
            description = "The remote system is not available. For information about network troubleshooting, see Windows Help."
        },
        [1257] = {
            id = "ERROR_NON_ACCOUNT_SID",
            description = "The security identifier provided is not from an account domain."
        },
        [1258] = {
            id = "ERROR_NON_DOMAIN_SID",
            description = "The security identifier provided does not have a domain component."
        },
        [1259] = {
            id = "ERROR_APPHELP_BLOCK",
            description = "AppHelp dialog canceled thus preventing the application from starting."
        },
        [1260] = {
            id = "ERROR_ACCESS_DISABLED_BY_POLICY",
            description = "This program is blocked by group policy. For more information, contact your system administrator."
        },
        [1261] = {
            id = "ERROR_REG_NAT_CONSUMPTION",
            description = "A program attempt to use an invalid register value. Normally caused by an uninitialized register. This error is Itanium specific."
        },
        [1262] = {
            id = "ERROR_CSCSHARE_OFFLINE",
            description = "The share is currently offline or does not exist."
        },
        [1263] = {
            id = "ERROR_PKINIT_FAILURE",
            description = "The Kerberos protocol encountered an error while validating the KDC certificate during smartcard logon. There is more information in the system event log."
        },
        [1264] = {
            id = "ERROR_SMARTCARD_SUBSYSTEM_FAILURE",
            description = "The Kerberos protocol encountered an error while attempting to utilize the smartcard subsystem."
        },
        [1265] = {
            id = "ERROR_DOWNGRADE_DETECTED",
            description = "The system cannot contact a domain controller to service the authentication request. Please try again later."
        },
        [1271] = {
            id = "ERROR_MACHINE_LOCKED",
            description = "The machine is locked and cannot be shut down without the force option."
        },
        [1273] = {
            id = "ERROR_CALLBACK_SUPPLIED_INVALID_DATA",
            description = "An application-defined callback gave invalid data when called."
        },
        [1274] = {
            id = "ERROR_SYNC_FOREGROUND_REFRESH_REQUIRED",
            description = "The group policy framework should call the extension in the synchronous foreground policy refresh."
        },
        [1275] = {
            id = "ERROR_DRIVER_BLOCKED",
            description = "This driver has been blocked from loading."
        },
        [1276] = {
            id = "ERROR_INVALID_IMPORT_OF_NON_DLL",
            description = "A dynamic link library (DLL) referenced a module that was neither a DLL nor the process's executable image."
        },
        [1277] = {
            id = "ERROR_ACCESS_DISABLED_WEBBLADE",
            description = "Windows cannot open this program since it has been disabled."
        },
        [1278] = {
            id = "ERROR_ACCESS_DISABLED_WEBBLADE_TAMPER",
            description = "Windows cannot open this program because the license enforcement system has been tampered with or become corrupted."
        },
        [1279] = {
            id = "ERROR_RECOVERY_FAILURE",
            description = "A transaction recover failed."
        },
        [1280] = {
            id = "ERROR_ALREADY_FIBER",
            description = "The current thread has already been converted to a fiber."
        },
        [1281] = {
            id = "ERROR_ALREADY_THREAD",
            description = "The current thread has already been converted from a fiber."
        },
        [1282] = {
            id = "ERROR_STACK_BUFFER_OVERRUN",
            description = "The system detected an overrun of a stack-based buffer in this application. This overrun could potentially allow a malicious user to gain control of this application."
        },
        [1283] = {
            id = "ERROR_PARAMETER_QUOTA_EXCEEDED",
            description = "Data present in one of the parameters is more than the function can operate on."
        },
        [1284] = {
            id = "ERROR_DEBUGGER_INACTIVE",
            description = "An attempt to do an operation on a debug object failed because the object is in the process of being deleted."
        },
        [1285] = {
            id = "ERROR_DELAY_LOAD_FAILED",
            description = "An attempt to delay-load a .dll or get a function address in a delay-loaded .dll failed."
        },
        [1286] = {
            id = "ERROR_VDM_DISALLOWED",
            description = "%1 is a 16-bit application. You do not have permissions to execute 16-bit applications. Check your permissions with your system administrator."
        },
        [1287] = {
            id = "ERROR_UNIDENTIFIED_ERROR",
            description = "Insufficient information exists to identify the cause of failure."
        },
        [1288] = {
            id = "ERROR_INVALID_CRUNTIME_PARAMETER",
            description = "The parameter passed to a C runtime function is incorrect."
        },
        [1289] = {
            id = "ERROR_BEYOND_VDL",
            description = "The operation occurred beyond the valid data length of the file."
        },
        [1290] = {
            id = "ERROR_INCOMPATIBLE_SERVICE_SID_TYPE",
            description = "The service start failed since one or more services in the same process have an incompatible service SID type setting. A service with restricted service SID type can only coexist in the same process with other services with a restricted SID type. If the service SID type for this service was just configured, the hosting process must be restarted in order to start this service."
        },
        [1291] = {
            id = "ERROR_DRIVER_PROCESS_TERMINATED",
            description = "The process hosting the driver for this device has been terminated."
        },
        [1292] = {
            id = "ERROR_IMPLEMENTATION_LIMIT",
            description = "An operation attempted to exceed an implementation-defined limit."
        },
        [1293] = {
            id = "ERROR_PROCESS_IS_PROTECTED",
            description = "Either the target process, or the target thread's containing process, is a protected process."
        },
        [1294] = {
            id = "ERROR_SERVICE_NOTIFY_CLIENT_LAGGING",
            description = "The service notification client is lagging too far behind the current state of services in the machine."
        },
        [1295] = {
            id = "ERROR_DISK_QUOTA_EXCEEDED",
            description = "The requested file operation failed because the storage quota was exceeded. To free up disk space, move files to a different location or delete unnecessary files. For more information, contact your system administrator."
        },
        [1296] = {
            id = "ERROR_CONTENT_BLOCKED",
            description = "The requested file operation failed because the storage policy blocks that type of file. For more information, contact your system administrator."
        },
        [1297] = {
            id = "ERROR_INCOMPATIBLE_SERVICE_PRIVILEGE",
            description = "A privilege that the service requires to function properly does not exist in the service account configuration. You may use the Services Microsoft Management Console (MMC) snap-in (services.msc) and the Local Security Settings MMC snap-in (secpol.msc) to view the service configuration and the account configuration."
        },
        [1298] = {
            id = "ERROR_APP_HANG",
            description = "A thread involved in this operation appears to be unresponsive."
        },
        [1299] = {
            id = "ERROR_INVALID_LABEL",
            description = "Indicates a particular Security ID may not be assigned as the label of an object."
        },
        [1300] = {
            id = "ERROR_NOT_ALL_ASSIGNED",
            description = "Not all privileges or groups referenced are assigned to the caller."
        },
        [1301] = {
            id = "ERROR_SOME_NOT_MAPPED",
            description = "Some mapping between account names and security IDs was not done."
        },
        [1302] = {
            id = "ERROR_NO_QUOTAS_FOR_ACCOUNT",
            description = "No system quota limits are specifically set for this account."
        },
        [1303] = {
            id = "ERROR_LOCAL_USER_SESSION_KEY",
            description = "No encryption key is available. A well-known encryption key was returned."
        },
        [1304] = {
            id = "ERROR_NULL_LM_PASSWORD",
            description = "The password is too complex to be converted to a LAN Manager password. The LAN Manager password returned is a NULL string."
        },
        [1305] = {
            id = "ERROR_UNKNOWN_REVISION",
            description = "The revision level is unknown."
        },
        [1306] = {
            id = "ERROR_REVISION_MISMATCH",
            description = "Indicates two revision levels are incompatible."
        },
        [1307] = {
            id = "ERROR_INVALID_OWNER",
            description = "This security ID may not be assigned as the owner of this object."
        },
        [1308] = {
            id = "ERROR_INVALID_PRIMARY_GROUP",
            description = "This security ID may not be assigned as the primary group of an object."
        },
        [1309] = {
            id = "ERROR_NO_IMPERSONATION_TOKEN",
            description = "An attempt has been made to operate on an impersonation token by a thread that is not currently impersonating a client."
        },
        [1310] = {
            id = "ERROR_CANT_DISABLE_MANDATORY",
            description = "The group may not be disabled."
        },
        [1311] = {
            id = "ERROR_NO_LOGON_SERVERS",
            description = "There are currently no logon servers available to service the logon request."
        },
        [1312] = {
            id = "ERROR_NO_SUCH_LOGON_SESSION",
            description = "A specified logon session does not exist. It may already have been terminated."
        },
        [1313] = {
            id = "ERROR_NO_SUCH_PRIVILEGE",
            description = "A specified privilege does not exist."
        },
        [1314] = {
            id = "ERROR_PRIVILEGE_NOT_HELD",
            description = "A required privilege is not held by the client."
        },
        [1315] = {
            id = "ERROR_INVALID_ACCOUNT_NAME",
            description = "The name provided is not a properly formed account name."
        },
        [1316] = {
            id = "ERROR_USER_EXISTS",
            description = "The specified account already exists."
        },
        [1317] = {
            id = "ERROR_NO_SUCH_USER",
            description = "The specified account does not exist."
        },
        [1318] = {
            id = "ERROR_GROUP_EXISTS",
            description = "The specified group already exists."
        },
        [1319] = {
            id = "ERROR_NO_SUCH_GROUP",
            description = "The specified group does not exist."
        },
        [1320] = {
            id = "ERROR_MEMBER_IN_GROUP",
            description = "Either the specified user account is already a member of the specified group, or the specified group cannot be deleted because it contains a member."
        },
        [1321] = {
            id = "ERROR_MEMBER_NOT_IN_GROUP",
            description = "The specified user account is not a member of the specified group account."
        },
        [1322] = {
            id = "ERROR_LAST_ADMIN",
            description = "This operation is disallowed as it could result in an administration account being disabled, deleted or unable to log on."
        },
        [1323] = {
            id = "ERROR_WRONG_PASSWORD",
            description = "Unable to update the password. The value provided as the current password is incorrect."
        },
        [1324] = {
            id = "ERROR_ILL_FORMED_PASSWORD",
            description = "Unable to update the password. The value provided for the new password contains values that are not allowed in passwords."
        },
        [1325] = {
            id = "ERROR_PASSWORD_RESTRICTION",
            description = "Unable to update the password. The value provided for the new password does not meet the length, complexity, or history requirements of the domain."
        },
        [1326] = {
            id = "ERROR_LOGON_FAILURE",
            description = "The user name or password is incorrect."
        },
        [1327] = {
            id = "ERROR_ACCOUNT_RESTRICTION",
            description = "Account restrictions are preventing this user from signing in. For example: blank passwords aren't allowed, sign-in times are limited, or a policy restriction has been enforced."
        },
        [1328] = {
            id = "ERROR_INVALID_LOGON_HOURS",
            description = "Your account has time restrictions that keep you from signing in right now."
        },
        [1329] = {
            id = "ERROR_INVALID_WORKSTATION",
            description = "This user isn't allowed to sign in to this computer."
        },
        [1330] = {
            id = "ERROR_PASSWORD_EXPIRED",
            description = "The password for this account has expired."
        },
        [1331] = {
            id = "ERROR_ACCOUNT_DISABLED",
            description = "This user can't sign in because this account is currently disabled."
        },
        [1332] = {
            id = "ERROR_NONE_MAPPED",
            description = "No mapping between account names and security IDs was done."
        },
        [1333] = {
            id = "ERROR_TOO_MANY_LUIDS_REQUESTED",
            description = "Too many local user identifiers (LUIDs) were requested at one time."
        },
        [1334] = {
            id = "ERROR_LUIDS_EXHAUSTED",
            description = "No more local user identifiers (LUIDs) are available."
        },
        [1335] = {
            id = "ERROR_INVALID_SUB_AUTHORITY",
            description = "The subauthority part of a security ID is invalid for this particular use."
        },
        [1336] = {
            id = "ERROR_INVALID_ACL",
            description = "The access control list (ACL) structure is invalid."
        },
        [1337] = {
            id = "ERROR_INVALID_SID",
            description = "The security ID structure is invalid."
        },
        [1338] = {
            id = "ERROR_INVALID_SECURITY_DESCR",
            description = "The security descriptor structure is invalid."
        },
        [1340] = {
            id = "ERROR_BAD_INHERITANCE_ACL",
            description = "The inherited access control list (ACL) or access control entry (ACE) could not be built."
        },
        [1341] = {
            id = "ERROR_SERVER_DISABLED",
            description = "The server is currently disabled."
        },
        [1342] = {
            id = "ERROR_SERVER_NOT_DISABLED",
            description = "The server is currently enabled."
        },
        [1343] = {
            id = "ERROR_INVALID_ID_AUTHORITY",
            description = "The value provided was an invalid value for an identifier authority."
        },
        [1344] = {
            id = "ERROR_ALLOTTED_SPACE_EXCEEDED",
            description = "No more memory is available for security information updates."
        },
        [1345] = {
            id = "ERROR_INVALID_GROUP_ATTRIBUTES",
            description = "The specified attributes are invalid, or incompatible with the attributes for the group as a whole."
        },
        [1346] = {
            id = "ERROR_BAD_IMPERSONATION_LEVEL",
            description = "Either a required impersonation level was not provided, or the provided impersonation level is invalid."
        },
        [1347] = {
            id = "ERROR_CANT_OPEN_ANONYMOUS",
            description = "Cannot open an anonymous level security token."
        },
        [1348] = {
            id = "ERROR_BAD_VALIDATION_CLASS",
            description = "The validation information class requested was invalid."
        },
        [1349] = {
            id = "ERROR_BAD_TOKEN_TYPE",
            description = "The type of the token is inappropriate for its attempted use."
        },
        [1350] = {
            id = "ERROR_NO_SECURITY_ON_OBJECT",
            description = "Unable to perform a security operation on an object that has no associated security."
        },
        [1351] = {
            id = "ERROR_CANT_ACCESS_DOMAIN_INFO",
            description = "Configuration information could not be read from the domain controller, either because the machine is unavailable, or access has been denied."
        },
        [1352] = {
            id = "ERROR_INVALID_SERVER_STATE",
            description = "The security account manager (SAM) or local security authority (LSA) server was in the wrong state to perform the security operation."
        },
        [1353] = {
            id = "ERROR_INVALID_DOMAIN_STATE",
            description = "The domain was in the wrong state to perform the security operation."
        },
        [1354] = {
            id = "ERROR_INVALID_DOMAIN_ROLE",
            description = "This operation is only allowed for the Primary Domain Controller of the domain."
        },
        [1355] = {
            id = "ERROR_NO_SUCH_DOMAIN",
            description = "The specified domain either does not exist or could not be contacted."
        },
        [1356] = {
            id = "ERROR_DOMAIN_EXISTS",
            description = "The specified domain already exists."
        },
        [1357] = {
            id = "ERROR_DOMAIN_LIMIT_EXCEEDED",
            description = "An attempt was made to exceed the limit on the number of domains per server."
        },
        [1358] = {
            id = "ERROR_INTERNAL_DB_CORRUPTION",
            description = "Unable to complete the requested operation because of either a catastrophic media failure or a data structure corruption on the disk."
        },
        [1359] = {
            id = "ERROR_INTERNAL_ERROR",
            description = "An internal error occurred."
        },
        [1360] = {
            id = "ERROR_GENERIC_NOT_MAPPED",
            description = "Generic access types were contained in an access mask which should already be mapped to nongeneric types."
        },
        [1361] = {
            id = "ERROR_BAD_DESCRIPTOR_FORMAT",
            description = "A security descriptor is not in the right format (absolute or self-relative)."
        },
        [1362] = {
            id = "ERROR_NOT_LOGON_PROCESS",
            description = "The requested action is restricted for use by logon processes only. The calling process has not registered as a logon process."
        },
        [1363] = {
            id = "ERROR_LOGON_SESSION_EXISTS",
            description = "Cannot start a new logon session with an ID that is already in use."
        },
        [1364] = {
            id = "ERROR_NO_SUCH_PACKAGE",
            description = "A specified authentication package is unknown."
        },
        [1365] = {
            id = "ERROR_BAD_LOGON_SESSION_STATE",
            description = "The logon session is not in a state that is consistent with the requested operation."
        },
        [1366] = {
            id = "ERROR_LOGON_SESSION_COLLISION",
            description = "The logon session ID is already in use."
        },
        [1367] = {
            id = "ERROR_INVALID_LOGON_TYPE",
            description = "A logon request contained an invalid logon type value."
        },
        [1368] = {
            id = "ERROR_CANNOT_IMPERSONATE",
            description = "Unable to impersonate using a named pipe until data has been read from that pipe."
        },
        [1369] = {
            id = "ERROR_RXACT_INVALID_STATE",
            description = "The transaction state of a registry subtree is incompatible with the requested operation."
        },
        [1370] = {
            id = "ERROR_RXACT_COMMIT_FAILURE",
            description = "An internal security database corruption has been encountered."
        },
        [1371] = {
            id = "ERROR_SPECIAL_ACCOUNT",
            description = "Cannot perform this operation on built-in accounts."
        },
        [1372] = {
            id = "ERROR_SPECIAL_GROUP",
            description = "Cannot perform this operation on this built-in special group."
        },
        [1373] = {
            id = "ERROR_SPECIAL_USER",
            description = "Cannot perform this operation on this built-in special user."
        },
        [1374] = {
            id = "ERROR_MEMBERS_PRIMARY_GROUP",
            description = "The user cannot be removed from a group because the group is currently the user's primary group."
        },
        [1375] = {
            id = "ERROR_TOKEN_ALREADY_IN_USE",
            description = "The token is already in use as a primary token."
        },
        [1376] = {
            id = "ERROR_NO_SUCH_ALIAS",
            description = "The specified local group does not exist."
        },
        [1377] = {
            id = "ERROR_MEMBER_NOT_IN_ALIAS",
            description = "The specified account name is not a member of the group."
        },
        [1378] = {
            id = "ERROR_MEMBER_IN_ALIAS",
            description = "The specified account name is already a member of the group."
        },
        [1379] = {
            id = "ERROR_ALIAS_EXISTS",
            description = "The specified local group already exists."
        },
        [1380] = {
            id = "ERROR_LOGON_NOT_GRANTED",
            description = "Logon failure: the user has not been granted the requested logon type at this computer."
        },
        [1381] = {
            id = "ERROR_TOO_MANY_SECRETS",
            description = "The maximum number of secrets that may be stored in a single system has been exceeded."
        },
        [1382] = {
            id = "ERROR_SECRET_TOO_LONG",
            description = "The length of a secret exceeds the maximum length allowed."
        },
        [1383] = {
            id = "ERROR_INTERNAL_DB_ERROR",
            description = "The local security authority database contains an internal inconsistency."
        },
        [1384] = {
            id = "ERROR_TOO_MANY_CONTEXT_IDS",
            description = "During a logon attempt, the user's security context accumulated too many security IDs."
        },
        [1385] = {
            id = "ERROR_LOGON_TYPE_NOT_GRANTED",
            description = "Logon failure: the user has not been granted the requested logon type at this computer."
        },
        [1386] = {
            id = "ERROR_NT_CROSS_ENCRYPTION_REQUIRED",
            description = "A cross-encrypted password is necessary to change a user password."
        },
        [1387] = {
            id = "ERROR_NO_SUCH_MEMBER",
            description = "A member could not be added to or removed from the local group because the member does not exist."
        },
        [1388] = {
            id = "ERROR_INVALID_MEMBER",
            description = "A new member could not be added to a local group because the member has the wrong account type."
        },
        [1389] = {
            id = "ERROR_TOO_MANY_SIDS",
            description = "Too many security IDs have been specified."
        },
        [1390] = {
            id = "ERROR_LM_CROSS_ENCRYPTION_REQUIRED",
            description = "A cross-encrypted password is necessary to change this user password."
        },
        [1391] = {
            id = "ERROR_NO_INHERITANCE",
            description = "Indicates an ACL contains no inheritable components."
        },
        [1392] = {
            id = "ERROR_FILE_CORRUPT",
            description = "The file or directory is corrupted and unreadable."
        },
        [1393] = {
            id = "ERROR_DISK_CORRUPT",
            description = "The disk structure is corrupted and unreadable."
        },
        [1394] = {
            id = "ERROR_NO_USER_SESSION_KEY",
            description = "There is no user session key for the specified logon session."
        },
        [1395] = {
            id = "ERROR_LICENSE_QUOTA_EXCEEDED",
            description = "The service being accessed is licensed for a particular number of connections. No more connections can be made to the service at this time because there are already as many connections as the service can accept."
        },
        [1396] = {
            id = "ERROR_WRONG_TARGET_NAME",
            description = "The target account name is incorrect."
        },
        [1397] = {
            id = "ERROR_MUTUAL_AUTH_FAILED",
            description = "Mutual Authentication failed. The server's password is out of date at the domain controller."
        },
        [1398] = {
            id = "ERROR_TIME_SKEW",
            description = "There is a time and/or date difference between the client and server."
        },
        [1399] = {
            id = "ERROR_CURRENT_DOMAIN_NOT_ALLOWED",
            description = "This operation cannot be performed on the current domain."
        },
        [1400] = {
            id = "ERROR_INVALID_WINDOW_HANDLE",
            description = "Invalid window handle."
        },
        [1401] = {
            id = "ERROR_INVALID_MENU_HANDLE",
            description = "Invalid menu handle."
        },
        [1402] = {
            id = "ERROR_INVALID_CURSOR_HANDLE",
            description = "Invalid cursor handle."
        },
        [1403] = {
            id = "ERROR_INVALID_ACCEL_HANDLE",
            description = "Invalid accelerator table handle."
        },
        [1404] = {
            id = "ERROR_INVALID_HOOK_HANDLE",
            description = "Invalid hook handle."
        },
        [1405] = {
            id = "ERROR_INVALID_DWP_HANDLE",
            description = "Invalid handle to a multiple-window position structure."
        },
        [1406] = {
            id = "ERROR_TLW_WITH_WSCHILD",
            description = "Cannot create a top-level child window."
        },
        [1407] = {
            id = "ERROR_CANNOT_FIND_WND_CLASS",
            description = "Cannot find window class."
        },
        [1408] = {
            id = "ERROR_WINDOW_OF_OTHER_THREAD",
            description = "Invalid window; it belongs to other thread."
        },
        [1409] = {
            id = "ERROR_HOTKEY_ALREADY_REGISTERED",
            description = "Hot key is already registered."
        },
        [1410] = {
            id = "ERROR_CLASS_ALREADY_EXISTS",
            description = "Class already exists."
        },
        [1411] = {
            id = "ERROR_CLASS_DOES_NOT_EXIST",
            description = "Class does not exist."
        },
        [1412] = {
            id = "ERROR_CLASS_HAS_WINDOWS",
            description = "Class still has open windows."
        },
        [1413] = {
            id = "ERROR_INVALID_INDEX",
            description = "Invalid index."
        },
        [1414] = {
            id = "ERROR_INVALID_ICON_HANDLE",
            description = "Invalid icon handle."
        },
        [1415] = {
            id = "ERROR_PRIVATE_DIALOG_INDEX",
            description = "Using private DIALOG window words."
        },
        [1416] = {
            id = "ERROR_LISTBOX_ID_NOT_FOUND",
            description = "The list box identifier was not found."
        },
        [1417] = {
            id = "ERROR_NO_WILDCARD_CHARACTERS",
            description = "No wildcards were found."
        },
        [1418] = {
            id = "ERROR_CLIPBOARD_NOT_OPEN",
            description = "Thread does not have a clipboard open."
        },
        [1419] = {
            id = "ERROR_HOTKEY_NOT_REGISTERED",
            description = "Hot key is not registered."
        },
        [1420] = {
            id = "ERROR_WINDOW_NOT_DIALOG",
            description = "The window is not a valid dialog window."
        },
        [1421] = {
            id = "ERROR_CONTROL_ID_NOT_FOUND",
            description = "Control ID not found."
        },
        [1422] = {
            id = "ERROR_INVALID_COMBOBOX_MESSAGE",
            description = "Invalid message for a combo box because it does not have an edit control."
        },
        [1423] = {
            id = "ERROR_WINDOW_NOT_COMBOBOX",
            description = "The window is not a combo box."
        },
        [1424] = {
            id = "ERROR_INVALID_EDIT_HEIGHT",
            description = "Height must be less than 256."
        },
        [1425] = {
            id = "ERROR_DC_NOT_FOUND",
            description = "Invalid device context (DC) handle."
        },
        [1426] = {
            id = "ERROR_INVALID_HOOK_FILTER",
            description = "Invalid hook procedure type."
        },
        [1427] = {
            id = "ERROR_INVALID_FILTER_PROC",
            description = "Invalid hook procedure."
        },
        [1428] = {
            id = "ERROR_HOOK_NEEDS_HMOD",
            description = "Cannot set nonlocal hook without a module handle."
        },
        [1429] = {
            id = "ERROR_GLOBAL_ONLY_HOOK",
            description = "This hook procedure can only be set globally."
        },
        [1430] = {
            id = "ERROR_JOURNAL_HOOK_SET",
            description = "The journal hook procedure is already installed."
        },
        [1431] = {
            id = "ERROR_HOOK_NOT_INSTALLED",
            description = "The hook procedure is not installed."
        },
        [1432] = {
            id = "ERROR_INVALID_LB_MESSAGE",
            description = "Invalid message for single-selection list box."
        },
        [1433] = {
            id = "ERROR_SETCOUNT_ON_BAD_LB",
            description = "LB_SETCOUNT sent to non-lazy list box."
        },
        [1434] = {
            id = "ERROR_LB_WITHOUT_TABSTOPS",
            description = "This list box does not support tab stops."
        },
        [1435] = {
            id = "ERROR_DESTROY_OBJECT_OF_OTHER_THREAD",
            description = "Cannot destroy object created by another thread."
        },
        [1436] = {
            id = "ERROR_CHILD_WINDOW_MENU",
            description = "Child windows cannot have menus."
        },
        [1437] = {
            id = "ERROR_NO_SYSTEM_MENU",
            description = "The window does not have a system menu."
        },
        [1438] = {
            id = "ERROR_INVALID_MSGBOX_STYLE",
            description = "Invalid message box style."
        },
        [1439] = {
            id = "ERROR_INVALID_SPI_VALUE",
            description = "Invalid system-wide (SPI_*) parameter."
        },
        [1440] = {
            id = "ERROR_SCREEN_ALREADY_LOCKED",
            description = "Screen already locked."
        },
        [1441] = {
            id = "ERROR_HWNDS_HAVE_DIFF_PARENT",
            description = "All handles to windows in a multiple-window position structure must have the same parent."
        },
        [1442] = {
            id = "ERROR_NOT_CHILD_WINDOW",
            description = "The window is not a child window."
        },
        [1443] = {
            id = "ERROR_INVALID_GW_COMMAND",
            description = "Invalid GW_* command."
        },
        [1444] = {
            id = "ERROR_INVALID_THREAD_ID",
            description = "Invalid thread identifier."
        },
        [1445] = {
            id = "ERROR_NON_MDICHILD_WINDOW",
            description = "Cannot process a message from a window that is not a multiple document interface (MDI) window."
        },
        [1446] = {
            id = "ERROR_POPUP_ALREADY_ACTIVE",
            description = "Popup menu already active."
        },
        [1447] = {
            id = "ERROR_NO_SCROLLBARS",
            description = "The window does not have scroll bars."
        },
        [1448] = {
            id = "ERROR_INVALID_SCROLLBAR_RANGE",
            description = "Scroll bar range cannot be greater than MAXLONG."
        },
        [1449] = {
            id = "ERROR_INVALID_SHOWWIN_COMMAND",
            description = "Cannot show or remove the window in the way specified."
        },
        [1450] = {
            id = "ERROR_NO_SYSTEM_RESOURCES",
            description = "Insufficient system resources exist to complete the requested service."
        },
        [1451] = {
            id = "ERROR_NONPAGED_SYSTEM_RESOURCES",
            description = "Insufficient system resources exist to complete the requested service."
        },
        [1452] = {
            id = "ERROR_PAGED_SYSTEM_RESOURCES",
            description = "Insufficient system resources exist to complete the requested service."
        },
        [1453] = {
            id = "ERROR_WORKING_SET_QUOTA",
            description = "Insufficient quota to complete the requested service."
        },
        [1454] = {
            id = "ERROR_PAGEFILE_QUOTA",
            description = "Insufficient quota to complete the requested service."
        },
        [1455] = {
            id = "ERROR_COMMITMENT_LIMIT",
            description = "The paging file is too small for this operation to complete."
        },
        [1456] = {
            id = "ERROR_MENU_ITEM_NOT_FOUND",
            description = "A menu item was not found."
        },
        [1457] = {
            id = "ERROR_INVALID_KEYBOARD_HANDLE",
            description = "Invalid keyboard layout handle."
        },
        [1458] = {
            id = "ERROR_HOOK_TYPE_NOT_ALLOWED",
            description = "Hook type not allowed."
        },
        [1459] = {
            id = "ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION",
            description = "This operation requires an interactive window station."
        },
        [1460] = {
            id = "ERROR_TIMEOUT",
            description = "This operation returned because the timeout period expired."
        },
        [1461] = {
            id = "ERROR_INVALID_MONITOR_HANDLE",
            description = "Invalid monitor handle."
        },
        [1462] = {
            id = "ERROR_INCORRECT_SIZE",
            description = "Incorrect size argument."
        },
        [1463] = {
            id = "ERROR_SYMLINK_CLASS_DISABLED",
            description = "The symbolic link cannot be followed because its type is disabled."
        },
        [1464] = {
            id = "ERROR_SYMLINK_NOT_SUPPORTED",
            description = "This application does not support the current operation on symbolic links."
        },
        [1465] = {
            id = "ERROR_XML_PARSE_ERROR",
            description = "Windows was unable to parse the requested XML data."
        },
        [1466] = {
            id = "ERROR_XMLDSIG_ERROR",
            description = "An error was encountered while processing an XML digital signature."
        },
        [1467] = {
            id = "ERROR_RESTART_APPLICATION",
            description = "This application must be restarted."
        },
        [1468] = {
            id = "ERROR_WRONG_COMPARTMENT",
            description = "The caller made the connection request in the wrong routing compartment."
        },
        [1469] = {
            id = "ERROR_AUTHIP_FAILURE",
            description = "There was an AuthIP failure when attempting to connect to the remote host."
        },
        [1470] = {
            id = "ERROR_NO_NVRAM_RESOURCES",
            description = "Insufficient NVRAM resources exist to complete the requested service. A reboot might be required."
        },
        [1471] = {
            id = "ERROR_NOT_GUI_PROCESS",
            description = "Unable to finish the requested operation because the specified process is not a GUI process."
        },
        [1500] = {
            id = "ERROR_EVENTLOG_FILE_CORRUPT",
            description = "The event log file is corrupted."
        },
        [1501] = {
            id = "ERROR_EVENTLOG_CANT_START",
            description = "No event log file could be opened, so the event logging service did not start."
        },
        [1502] = {
            id = "ERROR_LOG_FILE_FULL",
            description = "The event log file is full."
        },
        [1503] = {
            id = "ERROR_EVENTLOG_FILE_CHANGED",
            description = "The event log file has changed between read operations."
        },
        [1550] = {
            id = "ERROR_INVALID_TASK_NAME",
            description = "The specified task name is invalid."
        },
        [1551] = {
            id = "ERROR_INVALID_TASK_INDEX",
            description = "The specified task index is invalid."
        },
        [1552] = {
            id = "ERROR_THREAD_ALREADY_IN_TASK",
            description = "The specified thread is already joining a task."
        },
        [1601] = {
            id = "ERROR_INSTALL_SERVICE_FAILURE",
            description = "The Windows Installer Service could not be accessed. This can occur if the Windows Installer is not correctly installed. Contact your support personnel for assistance."
        },
        [1602] = {
            id = "ERROR_INSTALL_USEREXIT",
            description = "User cancelled installation."
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
            description = "Unknown property."
        },
        [1609] = {
            id = "ERROR_INVALID_HANDLE_STATE",
            description = "Handle is in an invalid state."
        },
        [1610] = {
            id = "ERROR_BAD_CONFIGURATION",
            description = "The configuration data for this product is corrupt. Contact your support personnel."
        },
        [1611] = {
            id = "ERROR_INDEX_ABSENT",
            description = "Component qualifier not present."
        },
        [1612] = {
            id = "ERROR_INSTALL_SOURCE_ABSENT",
            description = "The installation source for this product is not available. Verify that the source exists and that you can access it."
        },
        [1613] = {
            id = "ERROR_INSTALL_PACKAGE_VERSION",
            description = "This installation package cannot be installed by the Windows Installer service. You must install a Windows service pack that contains a newer version of the Windows Installer service."
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
        [1617] = {
            id = "ERROR_DEVICE_REMOVED",
            description = "The device has been removed."
        },
        [1618] = {
            id = "ERROR_INSTALL_ALREADY_RUNNING",
            description = "Another installation is already in progress. Complete that installation before proceeding with this install."
        },
        [1619] = {
            id = "ERROR_INSTALL_PACKAGE_OPEN_FAILED",
            description = "This installation package could not be opened. Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package."
        },
        [1620] = {
            id = "ERROR_INSTALL_PACKAGE_INVALID",
            description = "This installation package could not be opened. Contact the application vendor to verify that this is a valid Windows Installer package."
        },
        [1621] = {
            id = "ERROR_INSTALL_UI_FAILURE",
            description = "There was an error starting the Windows Installer service user interface. Contact your support personnel."
        },
        [1622] = {
            id = "ERROR_INSTALL_LOG_FAILURE",
            description = "Error opening installation log file. Verify that the specified log file location exists and that you can write to it."
        },
        [1623] = {
            id = "ERROR_INSTALL_LANGUAGE_UNSUPPORTED",
            description = "The language of this installation package is not supported by your system."
        },
        [1624] = {
            id = "ERROR_INSTALL_TRANSFORM_FAILURE",
            description = "Error applying transforms. Verify that the specified transform paths are valid."
        },
        [1625] = {
            id = "ERROR_INSTALL_PACKAGE_REJECTED",
            description = "This installation is forbidden by system policy. Contact your system administrator."
        },
        [1626] = {
            id = "ERROR_FUNCTION_NOT_CALLED",
            description = "Function could not be executed."
        },
        [1627] = {
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
            description = "The Windows Installer service failed to start. Contact your support personnel."
        },
        [1632] = {
            id = "ERROR_INSTALL_TEMP_UNWRITABLE",
            description = "The Temp folder is on a drive that is full or is inaccessible. Free up space on the drive or verify that you have write permission on the Temp folder."
        },
        [1633] = {
            id = "ERROR_INSTALL_PLATFORM_UNSUPPORTED",
            description = "This installation package is not supported by this processor type. Contact your product vendor."
        },
        [1634] = {
            id = "ERROR_INSTALL_NOTUSED",
            description = "Component not used on this computer."
        },
        [1635] = {
            id = "ERROR_PATCH_PACKAGE_OPEN_FAILED",
            description = "This update package could not be opened. Verify that the update package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer update package."
        },
        [1636] = {
            id = "ERROR_PATCH_PACKAGE_INVALID",
            description = "This update package could not be opened. Contact the application vendor to verify that this is a valid Windows Installer update package."
        },
        [1637] = {
            id = "ERROR_PATCH_PACKAGE_UNSUPPORTED",
            description = "This update package cannot be processed by the Windows Installer service. You must install a Windows service pack that contains a newer version of the Windows Installer service."
        },
        [1638] = {
            id = "ERROR_PRODUCT_VERSION",
            description = "Another version of this product is already installed. Installation of this version cannot continue. To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel."
        },
        [1639] = {
            id = "ERROR_INVALID_COMMAND_LINE",
            description = "Invalid command line argument. Consult the Windows Installer SDK for detailed command line help."
        },
        [1640] = {
            id = "ERROR_INSTALL_REMOTE_DISALLOWED",
            description = "Only administrators have permission to add, remove, or configure server software during a Terminal services remote session. If you want to install or configure software on the server, contact your network administrator."
        },
        [1641] = {
            id = "ERROR_SUCCESS_REBOOT_INITIATED",
            description = "The requested operation completed successfully. The system will be restarted so the changes can take effect."
        },
        [1642] = {
            id = "ERROR_PATCH_TARGET_NOT_FOUND",
            description = "The upgrade cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade."
        },
        [1643] = {
            id = "ERROR_PATCH_PACKAGE_REJECTED",
            description = "The update package is not permitted by software restriction policy."
        },
        [1644] = {
            id = "ERROR_INSTALL_TRANSFORM_REJECTED",
            description = "One or more customizations are not permitted by software restriction policy."
        },
        [1645] = {
            id = "ERROR_INSTALL_REMOTE_PROHIBITED",
            description = "The Windows Installer does not permit installation from a Remote Desktop Connection."
        },
        [1646] = {
            id = "ERROR_PATCH_REMOVAL_UNSUPPORTED",
            description = "Uninstallation of the update package is not supported."
        },
        [1647] = {
            id = "ERROR_UNKNOWN_PATCH",
            description = "The update is not applied to this product."
        },
        [1648] = {
            id = "ERROR_PATCH_NO_SEQUENCE",
            description = "No valid sequence could be found for the set of updates."
        },
        [1649] = {
            id = "ERROR_PATCH_REMOVAL_DISALLOWED",
            description = "Update removal was disallowed by policy."
        },
        [1650] = {
            id = "ERROR_INVALID_PATCH_XML",
            description = "The XML update data is invalid."
        },
        [1651] = {
            id = "ERROR_PATCH_MANAGED_ADVERTISED_PRODUCT",
            description = "Windows Installer does not permit updating of managed advertised products. At least one feature of the product must be installed before applying the update."
        },
        [1652] = {
            id = "ERROR_INSTALL_SERVICE_SAFEBOOT",
            description = "The Windows Installer service is not accessible in Safe Mode. Please try again when your computer is not in Safe Mode or you can use System Restore to return your machine to a previous good state."
        },
        [1653] = {
            id = "ERROR_FAIL_FAST_EXCEPTION",
            description = "A fail fast exception occurred. Exception handlers will not be invoked and the process will be terminated immediately."
        },
        [1654] = {
            id = "ERROR_INSTALL_REJECTED",
            description = "The app that you are trying to run is not supported on this version of Windows."
        },
        [1700] = {
            id = "RPC_S_INVALID_STRING_BINDING",
            description = "The string binding is invalid."
        },
        [1701] = {
            id = "RPC_S_WRONG_KIND_OF_BINDING",
            description = "The binding handle is not the correct type."
        },
        [1702] = {
            id = "RPC_S_INVALID_BINDING",
            description = "The binding handle is invalid."
        },
        [1703] = {
            id = "RPC_S_PROTSEQ_NOT_SUPPORTED",
            description = "The RPC protocol sequence is not supported."
        },
        [1704] = {
            id = "RPC_S_INVALID_RPC_PROTSEQ",
            description = "The RPC protocol sequence is invalid."
        },
        [1705] = {
            id = "RPC_S_INVALID_STRING_UUID",
            description = "The string universal unique identifier (UUID) is invalid."
        },
        [1706] = {
            id = "RPC_S_INVALID_ENDPOINT_FORMAT",
            description = "The endpoint format is invalid."
        },
        [1707] = {
            id = "RPC_S_INVALID_NET_ADDR",
            description = "The network address is invalid."
        },
        [1708] = {
            id = "RPC_S_NO_ENDPOINT_FOUND",
            description = "No endpoint was found."
        },
        [1709] = {
            id = "RPC_S_INVALID_TIMEOUT",
            description = "The timeout value is invalid."
        },
        [1710] = {
            id = "RPC_S_OBJECT_NOT_FOUND",
            description = "The object universal unique identifier (UUID) was not found."
        },
        [1711] = {
            id = "RPC_S_ALREADY_REGISTERED",
            description = "The object universal unique identifier (UUID) has already been registered."
        },
        [1712] = {
            id = "RPC_S_TYPE_ALREADY_REGISTERED",
            description = "The type universal unique identifier (UUID) has already been registered."
        },
        [1713] = {
            id = "RPC_S_ALREADY_LISTENING",
            description = "The RPC server is already listening."
        },
        [1714] = {
            id = "RPC_S_NO_PROTSEQS_REGISTERED",
            description = "No protocol sequences have been registered."
        },
        [1715] = {
            id = "RPC_S_NOT_LISTENING",
            description = "The RPC server is not listening."
        },
        [1716] = {
            id = "RPC_S_UNKNOWN_MGR_TYPE",
            description = "The manager type is unknown."
        },
        [1717] = {
            id = "RPC_S_UNKNOWN_IF",
            description = "The interface is unknown."
        },
        [1718] = {
            id = "RPC_S_NO_BINDINGS",
            description = "There are no bindings."
        },
        [1719] = {
            id = "RPC_S_NO_PROTSEQS",
            description = "There are no protocol sequences."
        },
        [1720] = {
            id = "RPC_S_CANT_CREATE_ENDPOINT",
            description = "The endpoint cannot be created."
        },
        [1721] = {
            id = "RPC_S_OUT_OF_RESOURCES",
            description = "Not enough resources are available to complete this operation."
        },
        [1722] = {
            id = "RPC_S_SERVER_UNAVAILABLE",
            description = "The RPC server is unavailable."
        },
        [1723] = {
            id = "RPC_S_SERVER_TOO_BUSY",
            description = "The RPC server is too busy to complete this operation."
        },
        [1724] = {
            id = "RPC_S_INVALID_NETWORK_OPTIONS",
            description = "The network options are invalid."
        },
        [1725] = {
            id = "RPC_S_NO_CALL_ACTIVE",
            description = "There are no remote procedure calls active on this thread."
        },
        [1726] = {
            id = "RPC_S_CALL_FAILED",
            description = "The remote procedure call failed."
        },
        [1727] = {
            id = "RPC_S_CALL_FAILED_DNE",
            description = "The remote procedure call failed and did not execute."
        },
        [1728] = {
            id = "RPC_S_PROTOCOL_ERROR",
            description = "A remote procedure call (RPC) protocol error occurred."
        },
        [1729] = {
            id = "RPC_S_PROXY_ACCESS_DENIED",
            description = "Access to the HTTP proxy is denied."
        },
        [1730] = {
            id = "RPC_S_UNSUPPORTED_TRANS_SYN",
            description = "The transfer syntax is not supported by the RPC server."
        },
        [1732] = {
            id = "RPC_S_UNSUPPORTED_TYPE",
            description = "The universal unique identifier (UUID) type is not supported."
        },
        [1733] = {
            id = "RPC_S_INVALID_TAG",
            description = "The tag is invalid."
        },
        [1734] = {
            id = "RPC_S_INVALID_BOUND",
            description = "The array bounds are invalid."
        },
        [1735] = {
            id = "RPC_S_NO_ENTRY_NAME",
            description = "The binding does not contain an entry name."
        },
        [1736] = {
            id = "RPC_S_INVALID_NAME_SYNTAX",
            description = "The name syntax is invalid."
        },
        [1737] = {
            id = "RPC_S_UNSUPPORTED_NAME_SYNTAX",
            description = "The name syntax is not supported."
        },
        [1739] = {
            id = "RPC_S_UUID_NO_ADDRESS",
            description = "No network address is available to use to construct a universal unique identifier (UUID)."
        },
        [1740] = {
            id = "RPC_S_DUPLICATE_ENDPOINT",
            description = "The endpoint is a duplicate."
        },
        [1741] = {
            id = "RPC_S_UNKNOWN_AUTHN_TYPE",
            description = "The authentication type is unknown."
        },
        [1742] = {
            id = "RPC_S_MAX_CALLS_TOO_SMALL",
            description = "The maximum number of calls is too small."
        },
        [1743] = {
            id = "RPC_S_STRING_TOO_LONG",
            description = "The string is too long."
        },
        [1744] = {
            id = "RPC_S_PROTSEQ_NOT_FOUND",
            description = "The RPC protocol sequence was not found."
        },
        [1745] = {
            id = "RPC_S_PROCNUM_OUT_OF_RANGE",
            description = "The procedure number is out of range."
        },
        [1746] = {
            id = "RPC_S_BINDING_HAS_NO_AUTH",
            description = "The binding does not contain any authentication information."
        },
        [1747] = {
            id = "RPC_S_UNKNOWN_AUTHN_SERVICE",
            description = "The authentication service is unknown."
        },
        [1748] = {
            id = "RPC_S_UNKNOWN_AUTHN_LEVEL",
            description = "The authentication level is unknown."
        },
        [1749] = {
            id = "RPC_S_INVALID_AUTH_IDENTITY",
            description = "The security context is invalid."
        },
        [1750] = {
            id = "RPC_S_UNKNOWN_AUTHZ_SERVICE",
            description = "The authorization service is unknown."
        },
        [1751] = {
            id = "EPT_S_INVALID_ENTRY",
            description = "The entry is invalid."
        },
        [1752] = {
            id = "EPT_S_CANT_PERFORM_OP",
            description = "The server endpoint cannot perform the operation."
        },
        [1753] = {
            id = "EPT_S_NOT_REGISTERED",
            description = "There are no more endpoints available from the endpoint mapper."
        },
        [1754] = {
            id = "RPC_S_NOTHING_TO_EXPORT",
            description = "No interfaces have been exported."
        },
        [1755] = {
            id = "RPC_S_INCOMPLETE_NAME",
            description = "The entry name is incomplete."
        },
        [1756] = {
            id = "RPC_S_INVALID_VERS_OPTION",
            description = "The version option is invalid."
        },
        [1757] = {
            id = "RPC_S_NO_MORE_MEMBERS",
            description = "There are no more members."
        },
        [1758] = {
            id = "RPC_S_NOT_ALL_OBJS_UNEXPORTED",
            description = "There is nothing to unexport."
        },
        [1759] = {
            id = "RPC_S_INTERFACE_NOT_FOUND",
            description = "The interface was not found."
        },
        [1760] = {
            id = "RPC_S_ENTRY_ALREADY_EXISTS",
            description = "The entry already exists."
        },
        [1761] = {
            id = "RPC_S_ENTRY_NOT_FOUND",
            description = "The entry is not found."
        },
        [1762] = {
            id = "RPC_S_NAME_SERVICE_UNAVAILABLE",
            description = "The name service is unavailable."
        },
        [1763] = {
            id = "RPC_S_INVALID_NAF_ID",
            description = "The network address family is invalid."
        },
        [1764] = {
            id = "RPC_S_CANNOT_SUPPORT",
            description = "The requested operation is not supported."
        },
        [1765] = {
            id = "RPC_S_NO_CONTEXT_AVAILABLE",
            description = "No security context is available to allow impersonation."
        },
        [1766] = {
            id = "RPC_S_INTERNAL_ERROR",
            description = "An internal error occurred in a remote procedure call (RPC)."
        },
        [1767] = {
            id = "RPC_S_ZERO_DIVIDE",
            description = "The RPC server attempted an integer division by zero."
        },
        [1768] = {
            id = "RPC_S_ADDRESS_ERROR",
            description = "An addressing error occurred in the RPC server."
        },
        [1769] = {
            id = "RPC_S_FP_DIV_ZERO",
            description = "A floating-point operation at the RPC server caused a division by zero."
        },
        [1770] = {
            id = "RPC_S_FP_UNDERFLOW",
            description = "A floating-point underflow occurred at the RPC server."
        },
        [1771] = {
            id = "RPC_S_FP_OVERFLOW",
            description = "A floating-point overflow occurred at the RPC server."
        },
        [1772] = {
            id = "RPC_X_NO_MORE_ENTRIES",
            description = "The list of RPC servers available for the binding of auto handles has been exhausted."
        },
        [1773] = {
            id = "RPC_X_SS_CHAR_TRANS_OPEN_FAIL",
            description = "Unable to open the character translation table file."
        },
        [1774] = {
            id = "RPC_X_SS_CHAR_TRANS_SHORT_FILE",
            description = "The file containing the character translation table has fewer than 512 bytes."
        },
        [1775] = {
            id = "RPC_X_SS_IN_NULL_CONTEXT",
            description = "A null context handle was passed from the client to the host during a remote procedure call."
        },
        [1777] = {
            id = "RPC_X_SS_CONTEXT_DAMAGED",
            description = "The context handle changed during a remote procedure call."
        },
        [1778] = {
            id = "RPC_X_SS_HANDLES_MISMATCH",
            description = "The binding handles passed to a remote procedure call do not match."
        },
        [1779] = {
            id = "RPC_X_SS_CANNOT_GET_CALL_HANDLE",
            description = "The stub is unable to get the remote procedure call handle."
        },
        [1780] = {
            id = "RPC_X_NULL_REF_POINTER",
            description = "A null reference pointer was passed to the stub."
        },
        [1781] = {
            id = "RPC_X_ENUM_VALUE_OUT_OF_RANGE",
            description = "The enumeration value is out of range."
        },
        [1782] = {
            id = "RPC_X_BYTE_COUNT_TOO_SMALL",
            description = "The byte count is too small."
        },
        [1783] = {
            id = "RPC_X_BAD_STUB_DATA",
            description = "The stub received bad data."
        },
        [1784] = {
            id = "ERROR_INVALID_USER_BUFFER",
            description = "The supplied user buffer is not valid for the requested operation."
        },
        [1785] = {
            id = "ERROR_UNRECOGNIZED_MEDIA",
            description = "The disk media is not recognized. It may not be formatted."
        },
        [1786] = {
            id = "ERROR_NO_TRUST_LSA_SECRET",
            description = "The workstation does not have a trust secret."
        },
        [1787] = {
            id = "ERROR_NO_TRUST_SAM_ACCOUNT",
            description = "The security database on the server does not have a computer account for this workstation trust relationship."
        },
        [1788] = {
            id = "ERROR_TRUSTED_DOMAIN_FAILURE",
            description = "The trust relationship between the primary domain and the trusted domain failed."
        },
        [1789] = {
            id = "ERROR_TRUSTED_RELATIONSHIP_FAILURE",
            description = "The trust relationship between this workstation and the primary domain failed."
        },
        [1790] = {
            id = "ERROR_TRUST_FAILURE",
            description = "The network logon failed."
        },
        [1791] = {
            id = "RPC_S_CALL_IN_PROGRESS",
            description = "A remote procedure call is already in progress for this thread."
        },
        [1792] = {
            id = "ERROR_NETLOGON_NOT_STARTED",
            description = "An attempt was made to logon, but the network logon service was not started."
        },
        [1793] = {
            id = "ERROR_ACCOUNT_EXPIRED",
            description = "The user's account has expired."
        },
        [1794] = {
            id = "ERROR_REDIRECTOR_HAS_OPEN_HANDLES",
            description = "The redirector is in use and cannot be unloaded."
        },
        [1795] = {
            id = "ERROR_PRINTER_DRIVER_ALREADY_INSTALLED",
            description = "The specified printer driver is already installed."
        },
        [1796] = {
            id = "ERROR_UNKNOWN_PORT",
            description = "The specified port is unknown."
        },
        [1797] = {
            id = "ERROR_UNKNOWN_PRINTER_DRIVER",
            description = "The printer driver is unknown."
        },
        [1798] = {
            id = "ERROR_UNKNOWN_PRINTPROCESSOR",
            description = "The print processor is unknown."
        },
        [1799] = {
            id = "ERROR_INVALID_SEPARATOR_FILE",
            description = "The specified separator file is invalid."
        },
        [1800] = {
            id = "ERROR_INVALID_PRIORITY",
            description = "The specified priority is invalid."
        },
        [1801] = {
            id = "ERROR_INVALID_PRINTER_NAME",
            description = "The printer name is invalid."
        },
        [1802] = {
            id = "ERROR_PRINTER_ALREADY_EXISTS",
            description = "The printer already exists."
        },
        [1803] = {
            id = "ERROR_INVALID_PRINTER_COMMAND",
            description = "The printer command is invalid."
        },
        [1804] = {
            id = "ERROR_INVALID_DATATYPE",
            description = "The specified datatype is invalid."
        },
        [1805] = {
            id = "ERROR_INVALID_ENVIRONMENT",
            description = "The environment specified is invalid."
        },
        [1806] = {
            id = "RPC_S_NO_MORE_BINDINGS",
            description = "There are no more bindings."
        },
        [1807] = {
            id = "ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT",
            description = "The account used is an interdomain trust account. Use your global user account or local user account to access this server."
        },
        [1808] = {
            id = "ERROR_NOLOGON_WORKSTATION_TRUST_ACCOUNT",
            description = "The account used is a computer account. Use your global user account or local user account to access this server."
        },
        [1809] = {
            id = "ERROR_NOLOGON_SERVER_TRUST_ACCOUNT",
            description = "The account used is a server trust account. Use your global user account or local user account to access this server."
        },
        [1810] = {
            id = "ERROR_DOMAIN_TRUST_INCONSISTENT",
            description = "The name or security ID (SID) of the domain specified is inconsistent with the trust information for that domain."
        },
        [1811] = {
            id = "ERROR_SERVER_HAS_OPEN_HANDLES",
            description = "The server is in use and cannot be unloaded."
        },
        [1812] = {
            id = "ERROR_RESOURCE_DATA_NOT_FOUND",
            description = "The specified image file did not contain a resource section."
        },
        [1813] = {
            id = "ERROR_RESOURCE_TYPE_NOT_FOUND",
            description = "The specified resource type cannot be found in the image file."
        },
        [1814] = {
            id = "ERROR_RESOURCE_NAME_NOT_FOUND",
            description = "The specified resource name cannot be found in the image file."
        },
        [1815] = {
            id = "ERROR_RESOURCE_LANG_NOT_FOUND",
            description = "The specified resource language ID cannot be found in the image file."
        },
        [1816] = {
            id = "ERROR_NOT_ENOUGH_QUOTA",
            description = "Not enough quota is available to process this command."
        },
        [1817] = {
            id = "RPC_S_NO_INTERFACES",
            description = "No interfaces have been registered."
        },
        [1818] = {
            id = "RPC_S_CALL_CANCELLED",
            description = "The remote procedure call was cancelled."
        },
        [1819] = {
            id = "RPC_S_BINDING_INCOMPLETE",
            description = "The binding handle does not contain all required information."
        },
        [1820] = {
            id = "RPC_S_COMM_FAILURE",
            description = "A communications failure occurred during a remote procedure call."
        },
        [1821] = {
            id = "RPC_S_UNSUPPORTED_AUTHN_LEVEL",
            description = "The requested authentication level is not supported."
        },
        [1822] = {
            id = "RPC_S_NO_PRINC_NAME",
            description = "No principal name registered."
        },
        [1823] = {
            id = "RPC_S_NOT_RPC_ERROR",
            description = "The error specified is not a valid Windows RPC error code."
        },
        [1824] = {
            id = "RPC_S_UUID_LOCAL_ONLY",
            description = "A UUID that is valid only on this computer has been allocated."
        },
        [1825] = {
            id = "RPC_S_SEC_PKG_ERROR",
            description = "A security package specific error occurred."
        },
        [1826] = {
            id = "RPC_S_NOT_CANCELLED",
            description = "Thread is not canceled."
        },
        [1827] = {
            id = "RPC_X_INVALID_ES_ACTION",
            description = "Invalid operation on the encoding/decoding handle."
        },
        [1828] = {
            id = "RPC_X_WRONG_ES_VERSION",
            description = "Incompatible version of the serializing package."
        },
        [1829] = {
            id = "RPC_X_WRONG_STUB_VERSION",
            description = "Incompatible version of the RPC stub."
        },
        [1830] = {
            id = "RPC_X_INVALID_PIPE_OBJECT",
            description = "The RPC pipe object is invalid or corrupted."
        },
        [1831] = {
            id = "RPC_X_WRONG_PIPE_ORDER",
            description = "An invalid operation was attempted on an RPC pipe object."
        },
        [1832] = {
            id = "RPC_X_WRONG_PIPE_VERSION",
            description = "Unsupported RPC pipe version."
        },
        [1833] = {
            id = "RPC_S_COOKIE_AUTH_FAILED",
            description = "HTTP proxy server rejected the connection because the cookie authentication failed."
        },
        [1898] = {
            id = "RPC_S_GROUP_MEMBER_NOT_FOUND",
            description = "The group member was not found."
        },
        [1899] = {
            id = "EPT_S_CANT_CREATE",
            description = "The endpoint mapper database entry could not be created."
        },
        [1900] = {
            id = "RPC_S_INVALID_OBJECT",
            description = "The object universal unique identifier (UUID) is the nil UUID."
        },
        [1901] = {
            id = "ERROR_INVALID_TIME",
            description = "The specified time is invalid."
        },
        [1902] = {
            id = "ERROR_INVALID_FORM_NAME",
            description = "The specified form name is invalid."
        },
        [1903] = {
            id = "ERROR_INVALID_FORM_SIZE",
            description = "The specified form size is invalid."
        },
        [1904] = {
            id = "ERROR_ALREADY_WAITING",
            description = "The specified printer handle is already being waited on."
        },
        [1905] = {
            id = "ERROR_PRINTER_DELETED",
            description = "The specified printer has been deleted."
        },
        [1906] = {
            id = "ERROR_INVALID_PRINTER_STATE",
            description = "The state of the printer is invalid."
        },
        [1907] = {
            id = "ERROR_PASSWORD_MUST_CHANGE",
            description = "The user's password must be changed before signing in."
        },
        [1908] = {
            id = "ERROR_DOMAIN_CONTROLLER_NOT_FOUND",
            description = "Could not find the domain controller for this domain."
        },
        [1909] = {
            id = "ERROR_ACCOUNT_LOCKED_OUT",
            description = "The referenced account is currently locked out and may not be logged on to."
        },
        [1910] = {
            id = "OR_INVALID_OXID",
            description = "The object exporter specified was not found."
        },
        [1911] = {
            id = "OR_INVALID_OID",
            description = "The object specified was not found."
        },
        [1912] = {
            id = "OR_INVALID_SET",
            description = "The object resolver set specified was not found."
        },
        [1913] = {
            id = "RPC_S_SEND_INCOMPLETE",
            description = "Some data remains to be sent in the request buffer."
        },
        [1914] = {
            id = "RPC_S_INVALID_ASYNC_HANDLE",
            description = "Invalid asynchronous remote procedure call handle."
        },
        [1915] = {
            id = "RPC_S_INVALID_ASYNC_CALL",
            description = "Invalid asynchronous RPC call handle for this operation."
        },
        [1916] = {
            id = "RPC_X_PIPE_CLOSED",
            description = "The RPC pipe object has already been closed."
        },
        [1917] = {
            id = "RPC_X_PIPE_DISCIPLINE_ERROR",
            description = "The RPC call completed before all pipes were processed."
        },
        [1918] = {
            id = "RPC_X_PIPE_EMPTY",
            description = "No more data is available from the RPC pipe."
        },
        [1919] = {
            id = "ERROR_NO_SITENAME",
            description = "No site name is available for this machine."
        },
        [1920] = {
            id = "ERROR_CANT_ACCESS_FILE",
            description = "The file cannot be accessed by the system."
        },
        [1921] = {
            id = "ERROR_CANT_RESOLVE_FILENAME",
            description = "The name of the file cannot be resolved by the system."
        },
        [1922] = {
            id = "RPC_S_ENTRY_TYPE_MISMATCH",
            description = "The entry is not of the expected type."
        },
        [1923] = {
            id = "RPC_S_NOT_ALL_OBJS_EXPORTED",
            description = "Not all object UUIDs could be exported to the specified entry."
        },
        [1924] = {
            id = "RPC_S_INTERFACE_NOT_EXPORTED",
            description = "Interface could not be exported to the specified entry."
        },
        [1925] = {
            id = "RPC_S_PROFILE_NOT_ADDED",
            description = "The specified profile entry could not be added."
        },
        [1926] = {
            id = "RPC_S_PRF_ELT_NOT_ADDED",
            description = "The specified profile element could not be added."
        },
        [1927] = {
            id = "RPC_S_PRF_ELT_NOT_REMOVED",
            description = "The specified profile element could not be removed."
        },
        [1928] = {
            id = "RPC_S_GRP_ELT_NOT_ADDED",
            description = "The group element could not be added."
        },
        [1929] = {
            id = "RPC_S_GRP_ELT_NOT_REMOVED",
            description = "The group element could not be removed."
        },
        [1930] = {
            id = "ERROR_KM_DRIVER_BLOCKED",
            description = "The printer driver is not compatible with a policy enabled on your computer that blocks NT 4.0 drivers."
        },
        [1931] = {
            id = "ERROR_CONTEXT_EXPIRED",
            description = "The context has expired and can no longer be used."
        },
        [1932] = {
            id = "ERROR_PER_USER_TRUST_QUOTA_EXCEEDED",
            description = "The current user's delegated trust creation quota has been exceeded."
        },
        [1933] = {
            id = "ERROR_ALL_USER_TRUST_QUOTA_EXCEEDED",
            description = "The total delegated trust creation quota has been exceeded."
        },
        [1934] = {
            id = "ERROR_USER_DELETE_TRUST_QUOTA_EXCEEDED",
            description = "The current user's delegated trust deletion quota has been exceeded."
        },
        [1935] = {
            id = "ERROR_AUTHENTICATION_FIREWALL_FAILED",
            description = "The computer you are signing into is protected by an authentication firewall. The specified account is not allowed to authenticate to the computer."
        },
        [1936] = {
            id = "ERROR_REMOTE_PRINT_CONNECTIONS_BLOCKED",
            description = "Remote connections to the Print Spooler are blocked by a policy set on your machine."
        },
        [1937] = {
            id = "ERROR_NTLM_BLOCKED",
            description = "Authentication failed because NTLM authentication has been disabled."
        },
        [1938] = {
            id = "ERROR_PASSWORD_CHANGE_REQUIRED",
            description = "Logon Failure: EAS policy requires that the user change their password before this operation can be performed."
        },
        [2000] = {
            id = "ERROR_INVALID_PIXEL_FORMAT",
            description = "The pixel format is invalid."
        },
        [2001] = {
            id = "ERROR_BAD_DRIVER",
            description = "The specified driver is invalid."
        },
        [2002] = {
            id = "ERROR_INVALID_WINDOW_STYLE",
            description = "The window style or class attribute is invalid for this operation."
        },
        [2003] = {
            id = "ERROR_METAFILE_NOT_SUPPORTED",
            description = "The requested metafile operation is not supported."
        },
        [2004] = {
            id = "ERROR_TRANSFORM_NOT_SUPPORTED",
            description = "The requested transformation operation is not supported."
        },
        [2005] = {
            id = "ERROR_CLIPPING_NOT_SUPPORTED",
            description = "The requested clipping operation is not supported."
        },
        [2010] = {
            id = "ERROR_INVALID_CMM",
            description = "The specified color management module is invalid."
        },
        [2011] = {
            id = "ERROR_INVALID_PROFILE",
            description = "The specified color profile is invalid."
        },
        [2012] = {
            id = "ERROR_TAG_NOT_FOUND",
            description = "The specified tag was not found."
        },
        [2013] = {
            id = "ERROR_TAG_NOT_PRESENT",
            description = "A required tag is not present."
        },
        [2014] = {
            id = "ERROR_DUPLICATE_TAG",
            description = "The specified tag is already present."
        },
        [2015] = {
            id = "ERROR_PROFILE_NOT_ASSOCIATED_WITH_DEVICE",
            description = "The specified color profile is not associated with the specified device."
        },
        [2016] = {
            id = "ERROR_PROFILE_NOT_FOUND",
            description = "The specified color profile was not found."
        },
        [2017] = {
            id = "ERROR_INVALID_COLORSPACE",
            description = "The specified color space is invalid."
        },
        [2018] = {
            id = "ERROR_ICM_NOT_ENABLED",
            description = "Image Color Management is not enabled."
        },
        [2019] = {
            id = "ERROR_DELETING_ICM_XFORM",
            description = "There was an error while deleting the color transform."
        },
        [2020] = {
            id = "ERROR_INVALID_TRANSFORM",
            description = "The specified color transform is invalid."
        },
        [2021] = {
            id = "ERROR_COLORSPACE_MISMATCH",
            description = "The specified transform does not match the bitmap's color space."
        },
        [2022] = {
            id = "ERROR_INVALID_COLORINDEX",
            description = "The specified named color index is not present in the profile."
        },
        [2023] = {
            id = "ERROR_PROFILE_DOES_NOT_MATCH_DEVICE",
            description = "The specified profile is intended for a device of a different type than the specified device."
        },
        [2108] = {
            id = "ERROR_CONNECTED_OTHER_PASSWORD",
            description = "The network connection was made successfully, but the user had to be prompted for a password other than the one originally specified."
        },
        [2109] = {
            id = "ERROR_CONNECTED_OTHER_PASSWORD_DEFAULT",
            description = "The network connection was made successfully using default credentials."
        },
        [2202] = {
            id = "ERROR_BAD_USERNAME",
            description = "The specified username is invalid."
        },
        [2250] = {
            id = "ERROR_NOT_CONNECTED",
            description = "This network connection does not exist."
        },
        [2401] = {
            id = "ERROR_OPEN_FILES",
            description = "This network connection has files open or requests pending."
        },
        [2402] = {
            id = "ERROR_ACTIVE_CONNECTIONS",
            description = "Active connections still exist."
        },
        [2404] = {
            id = "ERROR_DEVICE_IN_USE",
            description = "The device is in use by an active process and cannot be disconnected."
        },
        [3000] = {
            id = "ERROR_UNKNOWN_PRINT_MONITOR",
            description = "The specified print monitor is unknown."
        },
        [3001] = {
            id = "ERROR_PRINTER_DRIVER_IN_USE",
            description = "The specified printer driver is currently in use."
        },
        [3002] = {
            id = "ERROR_SPOOL_FILE_NOT_FOUND",
            description = "The spool file was not found."
        },
        [3003] = {
            id = "ERROR_SPL_NO_STARTDOC",
            description = "A StartDocPrinter call was not issued."
        },
        [3004] = {
            id = "ERROR_SPL_NO_ADDJOB",
            description = "An AddJob call was not issued."
        },
        [3005] = {
            id = "ERROR_PRINT_PROCESSOR_ALREADY_INSTALLED",
            description = "The specified print processor has already been installed."
        },
        [3006] = {
            id = "ERROR_PRINT_MONITOR_ALREADY_INSTALLED",
            description = "The specified print monitor has already been installed."
        },
        [3007] = {
            id = "ERROR_INVALID_PRINT_MONITOR",
            description = "The specified print monitor does not have the required functions."
        },
        [3008] = {
            id = "ERROR_PRINT_MONITOR_IN_USE",
            description = "The specified print monitor is currently in use."
        },
        [3009] = {
            id = "ERROR_PRINTER_HAS_JOBS_QUEUED",
            description = "The requested operation is not allowed when there are jobs queued to the printer."
        },
        [3010] = {
            id = "ERROR_SUCCESS_REBOOT_REQUIRED",
            description = "The requested operation is successful. Changes will not be effective until the system is rebooted."
        },
        [3011] = {
            id = "ERROR_SUCCESS_RESTART_REQUIRED",
            description = "The requested operation is successful. Changes will not be effective until the service is restarted."
        },
        [3012] = {
            id = "ERROR_PRINTER_NOT_FOUND",
            description = "No printers were found."
        },
        [3013] = {
            id = "ERROR_PRINTER_DRIVER_WARNED",
            description = "The printer driver is known to be unreliable."
        },
        [3014] = {
            id = "ERROR_PRINTER_DRIVER_BLOCKED",
            description = "The printer driver is known to harm the system."
        },
        [3015] = {
            id = "ERROR_PRINTER_DRIVER_PACKAGE_IN_USE",
            description = "The specified printer driver package is currently in use."
        },
        [3016] = {
            id = "ERROR_CORE_DRIVER_PACKAGE_NOT_FOUND",
            description = "Unable to find a core driver package that is required by the printer driver package."
        },
        [3017] = {
            id = "ERROR_FAIL_REBOOT_REQUIRED",
            description = "The requested operation failed. A system reboot is required to roll back changes made."
        },
        [3018] = {
            id = "ERROR_FAIL_REBOOT_INITIATED",
            description = "The requested operation failed. A system reboot has been initiated to roll back changes made."
        },
        [3019] = {
            id = "ERROR_PRINTER_DRIVER_DOWNLOAD_NEEDED",
            description = "The specified printer driver was not found on the system and needs to be downloaded."
        },
        [3020] = {
            id = "ERROR_PRINT_JOB_RESTART_REQUIRED",
            description = "The requested print job has failed to print. A print system update requires the job to be resubmitted."
        },
        [3021] = {
            id = "ERROR_INVALID_PRINTER_DRIVER_MANIFEST",
            description = "The printer driver does not contain a valid manifest, or contains too many manifests."
        },
        [3022] = {
            id = "ERROR_PRINTER_NOT_SHAREABLE",
            description = "The specified printer cannot be shared."
        },
        [3050] = {
            id = "ERROR_REQUEST_PAUSED",
            description = "The operation was paused."
        },
        [3950] = {
            id = "ERROR_IO_REISSUE_AS_CACHED",
            description = "Reissue the given operation as a cached IO operation."
        },
        [4000] = {
            id = "ERROR_WINS_INTERNAL",
            description = "WINS encountered an error while processing the command."
        },
        [4001] = {
            id = "ERROR_CAN_NOT_DEL_LOCAL_WINS",
            description = "The local WINS cannot be deleted."
        },
        [4002] = {
            id = "ERROR_STATIC_INIT",
            description = "The importation from the file failed."
        },
        [4003] = {
            id = "ERROR_INC_BACKUP",
            description = "The backup failed. Was a full backup done before?"
        },
        [4004] = {
            id = "ERROR_FULL_BACKUP",
            description = "The backup failed. Check the directory to which you are backing the database."
        },
        [4005] = {
            id = "ERROR_REC_NON_EXISTENT",
            description = "The name does not exist in the WINS database."
        },
        [4006] = {
            id = "ERROR_RPL_NOT_ALLOWED",
            description = "Replication with a nonconfigured partner is not allowed."
        },
        [4050] = {
            id = "PEERDIST_ERROR_CONTENTINFO_VERSION_UNSUPPORTED",
            description = "The version of the supplied content information is not supported."
        },
        [4051] = {
            id = "PEERDIST_ERROR_CANNOT_PARSE_CONTENTINFO",
            description = "The supplied content information is malformed."
        },
        [4052] = {
            id = "PEERDIST_ERROR_MISSING_DATA",
            description = "The requested data cannot be found in local or peer caches."
        },
        [4053] = {
            id = "PEERDIST_ERROR_NO_MORE",
            description = "No more data is available or required."
        },
        [4054] = {
            id = "PEERDIST_ERROR_NOT_INITIALIZED",
            description = "The supplied object has not been initialized."
        },
        [4055] = {
            id = "PEERDIST_ERROR_ALREADY_INITIALIZED",
            description = "The supplied object has already been initialized."
        },
        [4056] = {
            id = "PEERDIST_ERROR_SHUTDOWN_IN_PROGRESS",
            description = "A shutdown operation is already in progress."
        },
        [4057] = {
            id = "PEERDIST_ERROR_INVALIDATED",
            description = "The supplied object has already been invalidated."
        },
        [4058] = {
            id = "PEERDIST_ERROR_ALREADY_EXISTS",
            description = "An element already exists and was not replaced."
        },
        [4059] = {
            id = "PEERDIST_ERROR_OPERATION_NOTFOUND",
            description = "Can not cancel the requested operation as it has already been completed."
        },
        [4060] = {
            id = "PEERDIST_ERROR_ALREADY_COMPLETED",
            description = "Can not perform the reqested operation because it has already been carried out."
        },
        [4061] = {
            id = "PEERDIST_ERROR_OUT_OF_BOUNDS",
            description = "An operation accessed data beyond the bounds of valid data."
        },
        [4062] = {
            id = "PEERDIST_ERROR_VERSION_UNSUPPORTED",
            description = "The requested version is not supported."
        },
        [4063] = {
            id = "PEERDIST_ERROR_INVALID_CONFIGURATION",
            description = "A configuration value is invalid."
        },
        [4064] = {
            id = "PEERDIST_ERROR_NOT_LICENSED",
            description = "The SKU is not licensed."
        },
        [4065] = {
            id = "PEERDIST_ERROR_SERVICE_UNAVAILABLE",
            description = "PeerDist Service is still initializing and will be available shortly."
        },
        [4066] = {
            id = "PEERDIST_ERROR_TRUST_FAILURE",
            description = "Communication with one or more computers will be temporarily blocked due to recent errors."
        },
        [4100] = {
            id = "ERROR_DHCP_ADDRESS_CONFLICT",
            description = "The DHCP client has obtained an IP address that is already in use on the network. The local interface will be disabled until the DHCP client can obtain a new address."
        },
        [4200] = {
            id = "ERROR_WMI_GUID_NOT_FOUND",
            description = "The GUID passed was not recognized as valid by a WMI data provider."
        },
        [4201] = {
            id = "ERROR_WMI_INSTANCE_NOT_FOUND",
            description = "The instance name passed was not recognized as valid by a WMI data provider."
        },
        [4202] = {
            id = "ERROR_WMI_ITEMID_NOT_FOUND",
            description = "The data item ID passed was not recognized as valid by a WMI data provider."
        },
        [4203] = {
            id = "ERROR_WMI_TRY_AGAIN",
            description = "The WMI request could not be completed and should be retried."
        },
        [4204] = {
            id = "ERROR_WMI_DP_NOT_FOUND",
            description = "The WMI data provider could not be located."
        },
        [4205] = {
            id = "ERROR_WMI_UNRESOLVED_INSTANCE_REF",
            description = "The WMI data provider references an instance set that has not been registered."
        },
        [4206] = {
            id = "ERROR_WMI_ALREADY_ENABLED",
            description = "The WMI data block or event notification has already been enabled."
        },
        [4207] = {
            id = "ERROR_WMI_GUID_DISCONNECTED",
            description = "The WMI data block is no longer available."
        },
        [4208] = {
            id = "ERROR_WMI_SERVER_UNAVAILABLE",
            description = "The WMI data service is not available."
        },
        [4209] = {
            id = "ERROR_WMI_DP_FAILED",
            description = "The WMI data provider failed to carry out the request."
        },
        [4210] = {
            id = "ERROR_WMI_INVALID_MOF",
            description = "The WMI MOF information is not valid."
        },
        [4211] = {
            id = "ERROR_WMI_INVALID_REGINFO",
            description = "The WMI registration information is not valid."
        },
        [4212] = {
            id = "ERROR_WMI_ALREADY_DISABLED",
            description = "The WMI data block or event notification has already been disabled."
        },
        [4213] = {
            id = "ERROR_WMI_READ_ONLY",
            description = "The WMI data item or data block is read only."
        },
        [4214] = {
            id = "ERROR_WMI_SET_FAILURE",
            description = "The WMI data item or data block could not be changed."
        },
        [4250] = {
            id = "ERROR_NOT_APPCONTAINER",
            description = "This operation is only valid in the context of an app container."
        },
        [4251] = {
            id = "ERROR_APPCONTAINER_REQUIRED",
            description = "This application can only run in the context of an app container."
        },
        [4252] = {
            id = "ERROR_NOT_SUPPORTED_IN_APPCONTAINER",
            description = "This functionality is not supported in the context of an app container."
        },
        [4253] = {
            id = "ERROR_INVALID_PACKAGE_SID_LENGTH",
            description = "The length of the SID supplied is not a valid length for app container SIDs."
        },
        [4300] = {
            id = "ERROR_INVALID_MEDIA",
            description = "The media identifier does not represent a valid medium."
        },
        [4301] = {
            id = "ERROR_INVALID_LIBRARY",
            description = "The library identifier does not represent a valid library."
        },
        [4302] = {
            id = "ERROR_INVALID_MEDIA_POOL",
            description = "The media pool identifier does not represent a valid media pool."
        },
        [4303] = {
            id = "ERROR_DRIVE_MEDIA_MISMATCH",
            description = "The drive and medium are not compatible or exist in different libraries."
        },
        [4304] = {
            id = "ERROR_MEDIA_OFFLINE",
            description = "The medium currently exists in an offline library and must be online to perform this operation."
        },
        [4305] = {
            id = "ERROR_LIBRARY_OFFLINE",
            description = "The operation cannot be performed on an offline library."
        },
        [4306] = {
            id = "ERROR_EMPTY",
            description = "The library, drive, or media pool is empty."
        },
        [4307] = {
            id = "ERROR_NOT_EMPTY",
            description = "The library, drive, or media pool must be empty to perform this operation."
        },
        [4308] = {
            id = "ERROR_MEDIA_UNAVAILABLE",
            description = "No media is currently available in this media pool or library."
        },
        [4309] = {
            id = "ERROR_RESOURCE_DISABLED",
            description = "A resource required for this operation is disabled."
        },
        [4310] = {
            id = "ERROR_INVALID_CLEANER",
            description = "The media identifier does not represent a valid cleaner."
        },
        [4311] = {
            id = "ERROR_UNABLE_TO_CLEAN",
            description = "The drive cannot be cleaned or does not support cleaning."
        },
        [4312] = {
            id = "ERROR_OBJECT_NOT_FOUND",
            description = "The object identifier does not represent a valid object."
        },
        [4313] = {
            id = "ERROR_DATABASE_FAILURE",
            description = "Unable to read from or write to the database."
        },
        [4314] = {
            id = "ERROR_DATABASE_FULL",
            description = "The database is full."
        },
        [4315] = {
            id = "ERROR_MEDIA_INCOMPATIBLE",
            description = "The medium is not compatible with the device or media pool."
        },
        [4316] = {
            id = "ERROR_RESOURCE_NOT_PRESENT",
            description = "The resource required for this operation does not exist."
        },
        [4317] = {
            id = "ERROR_INVALID_OPERATION",
            description = "The operation identifier is not valid."
        },
        [4318] = {
            id = "ERROR_MEDIA_NOT_AVAILABLE",
            description = "The media is not mounted or ready for use."
        },
        [4319] = {
            id = "ERROR_DEVICE_NOT_AVAILABLE",
            description = "The device is not ready for use."
        },
        [4320] = {
            id = "ERROR_REQUEST_REFUSED",
            description = "The operator or administrator has refused the request."
        },
        [4321] = {
            id = "ERROR_INVALID_DRIVE_OBJECT",
            description = "The drive identifier does not represent a valid drive."
        },
        [4322] = {
            id = "ERROR_LIBRARY_FULL",
            description = "Library is full. No slot is available for use."
        },
        [4323] = {
            id = "ERROR_MEDIUM_NOT_ACCESSIBLE",
            description = "The transport cannot access the medium."
        },
        [4324] = {
            id = "ERROR_UNABLE_TO_LOAD_MEDIUM",
            description = "Unable to load the medium into the drive."
        },
        [4325] = {
            id = "ERROR_UNABLE_TO_INVENTORY_DRIVE",
            description = "Unable to retrieve the drive status."
        },
        [4326] = {
            id = "ERROR_UNABLE_TO_INVENTORY_SLOT",
            description = "Unable to retrieve the slot status."
        },
        [4327] = {
            id = "ERROR_UNABLE_TO_INVENTORY_TRANSPORT",
            description = "Unable to retrieve status about the transport."
        },
        [4328] = {
            id = "ERROR_TRANSPORT_FULL",
            description = "Cannot use the transport because it is already in use."
        },
        [4329] = {
            id = "ERROR_CONTROLLING_IEPORT",
            description = "Unable to open or close the inject/eject port."
        },
        [4330] = {
            id = "ERROR_UNABLE_TO_EJECT_MOUNTED_MEDIA",
            description = "Unable to eject the medium because it is in a drive."
        },
        [4331] = {
            id = "ERROR_CLEANER_SLOT_SET",
            description = "A cleaner slot is already reserved."
        },
        [4332] = {
            id = "ERROR_CLEANER_SLOT_NOT_SET",
            description = "A cleaner slot is not reserved."
        },
        [4333] = {
            id = "ERROR_CLEANER_CARTRIDGE_SPENT",
            description = "The cleaner cartridge has performed the maximum number of drive cleanings."
        },
        [4334] = {
            id = "ERROR_UNEXPECTED_OMID",
            description = "Unexpected on-medium identifier."
        },
        [4335] = {
            id = "ERROR_CANT_DELETE_LAST_ITEM",
            description = "The last remaining item in this group or resource cannot be deleted."
        },
        [4336] = {
            id = "ERROR_MESSAGE_EXCEEDS_MAX_SIZE",
            description = "The message provided exceeds the maximum size allowed for this parameter."
        },
        [4337] = {
            id = "ERROR_VOLUME_CONTAINS_SYS_FILES",
            description = "The volume contains system or paging files."
        },
        [4338] = {
            id = "ERROR_INDIGENOUS_TYPE",
            description = "The media type cannot be removed from this library since at least one drive in the library reports it can support this media type."
        },
        [4339] = {
            id = "ERROR_NO_SUPPORTING_DRIVES",
            description = "This offline media cannot be mounted on this system since no enabled drives are present which can be used."
        },
        [4340] = {
            id = "ERROR_CLEANER_CARTRIDGE_INSTALLED",
            description = "A cleaner cartridge is present in the tape library."
        },
        [4341] = {
            id = "ERROR_IEPORT_FULL",
            description = "Cannot use the inject/eject port because it is not empty."
        },
        [4350] = {
            id = "ERROR_FILE_OFFLINE",
            description = "This file is currently not available for use on this computer."
        },
        [4351] = {
            id = "ERROR_REMOTE_STORAGE_NOT_ACTIVE",
            description = "The remote storage service is not operational at this time."
        },
        [4352] = {
            id = "ERROR_REMOTE_STORAGE_MEDIA_ERROR",
            description = "The remote storage service encountered a media error."
        },
        [4390] = {
            id = "ERROR_NOT_A_REPARSE_POINT",
            description = "The file or directory is not a reparse point."
        },
        [4391] = {
            id = "ERROR_REPARSE_ATTRIBUTE_CONFLICT",
            description = "The reparse point attribute cannot be set because it conflicts with an existing attribute."
        },
        [4392] = {
            id = "ERROR_INVALID_REPARSE_DATA",
            description = "The data present in the reparse point buffer is invalid."
        },
        [4393] = {
            id = "ERROR_REPARSE_TAG_INVALID",
            description = "The tag present in the reparse point buffer is invalid."
        },
        [4394] = {
            id = "ERROR_REPARSE_TAG_MISMATCH",
            description = "There is a mismatch between the tag specified in the request and the tag present in the reparse point."
        },
        [4400] = {
            id = "ERROR_APP_DATA_NOT_FOUND",
            description = "Fast Cache data not found."
        },
        [4401] = {
            id = "ERROR_APP_DATA_EXPIRED",
            description = "Fast Cache data expired."
        },
        [4402] = {
            id = "ERROR_APP_DATA_CORRUPT",
            description = "Fast Cache data corrupt."
        },
        [4403] = {
            id = "ERROR_APP_DATA_LIMIT_EXCEEDED",
            description = "Fast Cache data has exceeded its max size and cannot be updated."
        },
        [4404] = {
            id = "ERROR_APP_DATA_REBOOT_REQUIRED",
            description = "Fast Cache has been ReArmed and requires a reboot until it can be updated."
        },
        [4420] = {
            id = "ERROR_SECUREBOOT_ROLLBACK_DETECTED",
            description = "Secure Boot detected that rollback of protected data has been attempted."
        },
        [4421] = {
            id = "ERROR_SECUREBOOT_POLICY_VIOLATION",
            description = "The value is protected by Secure Boot policy and cannot be modified or deleted."
        },
        [4422] = {
            id = "ERROR_SECUREBOOT_INVALID_POLICY",
            description = "The Secure Boot policy is invalid."
        },
        [4423] = {
            id = "ERROR_SECUREBOOT_POLICY_PUBLISHER_NOT_FOUND",
            description = "A new Secure Boot policy did not contain the current publisher on its update list."
        },
        [4424] = {
            id = "ERROR_SECUREBOOT_POLICY_NOT_SIGNED",
            description = "The Secure Boot policy is either not signed or is signed by a non-trusted signer."
        },
        [4425] = {
            id = "ERROR_SECUREBOOT_NOT_ENABLED",
            description = "Secure Boot is not enabled on this machine."
        },
        [4426] = {
            id = "ERROR_SECUREBOOT_FILE_REPLACED",
            description = "Secure Boot requires that certain files and drivers are not replaced by other files or drivers."
        },
        [4440] = {
            id = "ERROR_OFFLOAD_READ_FLT_NOT_SUPPORTED",
            description = "The copy offload read operation is not supported by a filter."
        },
        [4441] = {
            id = "ERROR_OFFLOAD_WRITE_FLT_NOT_SUPPORTED",
            description = "The copy offload write operation is not supported by a filter."
        },
        [4442] = {
            id = "ERROR_OFFLOAD_READ_FILE_NOT_SUPPORTED",
            description = "The copy offload read operation is not supported for the file."
        },
        [4443] = {
            id = "ERROR_OFFLOAD_WRITE_FILE_NOT_SUPPORTED",
            description = "The copy offload write operation is not supported for the file."
        },
        [4500] = {
            id = "ERROR_VOLUME_NOT_SIS_ENABLED",
            description = "Single Instance Storage is not available on this volume."
        },
        [5001] = {
            id = "ERROR_DEPENDENT_RESOURCE_EXISTS",
            description = "The operation cannot be completed because other resources are dependent on this resource."
        },
        [5002] = {
            id = "ERROR_DEPENDENCY_NOT_FOUND",
            description = "The cluster resource dependency cannot be found."
        },
        [5003] = {
            id = "ERROR_DEPENDENCY_ALREADY_EXISTS",
            description = "The cluster resource cannot be made dependent on the specified resource because it is already dependent."
        },
        [5004] = {
            id = "ERROR_RESOURCE_NOT_ONLINE",
            description = "The cluster resource is not online."
        },
        [5005] = {
            id = "ERROR_HOST_NODE_NOT_AVAILABLE",
            description = "A cluster node is not available for this operation."
        },
        [5006] = {
            id = "ERROR_RESOURCE_NOT_AVAILABLE",
            description = "The cluster resource is not available."
        },
        [5007] = {
            id = "ERROR_RESOURCE_NOT_FOUND",
            description = "The cluster resource could not be found."
        },
        [5008] = {
            id = "ERROR_SHUTDOWN_CLUSTER",
            description = "The cluster is being shut down."
        },
        [5009] = {
            id = "ERROR_CANT_EVICT_ACTIVE_NODE",
            description = "A cluster node cannot be evicted from the cluster unless the node is down or it is the last node."
        },
        [5010] = {
            id = "ERROR_OBJECT_ALREADY_EXISTS",
            description = "The object already exists."
        },
        [5011] = {
            id = "ERROR_OBJECT_IN_LIST",
            description = "The object is already in the list."
        },
        [5012] = {
            id = "ERROR_GROUP_NOT_AVAILABLE",
            description = "The cluster group is not available for any new requests."
        },
        [5013] = {
            id = "ERROR_GROUP_NOT_FOUND",
            description = "The cluster group could not be found."
        },
        [5014] = {
            id = "ERROR_GROUP_NOT_ONLINE",
            description = "The operation could not be completed because the cluster group is not online."
        },
        [5015] = {
            id = "ERROR_HOST_NODE_NOT_RESOURCE_OWNER",
            description = "The operation failed because either the specified cluster node is not the owner of the resource, or the node is not a possible owner of the resource."
        },
        [5016] = {
            id = "ERROR_HOST_NODE_NOT_GROUP_OWNER",
            description = "The operation failed because either the specified cluster node is not the owner of the group, or the node is not a possible owner of the group."
        },
        [5017] = {
            id = "ERROR_RESMON_CREATE_FAILED",
            description = "The cluster resource could not be created in the specified resource monitor."
        },
        [5018] = {
            id = "ERROR_RESMON_ONLINE_FAILED",
            description = "The cluster resource could not be brought online by the resource monitor."
        },
        [5019] = {
            id = "ERROR_RESOURCE_ONLINE",
            description = "The operation could not be completed because the cluster resource is online."
        },
        [5020] = {
            id = "ERROR_QUORUM_RESOURCE",
            description = "The cluster resource could not be deleted or brought offline because it is the quorum resource."
        },
        [5021] = {
            id = "ERROR_NOT_QUORUM_CAPABLE",
            description = "The cluster could not make the specified resource a quorum resource because it is not capable of being a quorum resource."
        },
        [5022] = {
            id = "ERROR_CLUSTER_SHUTTING_DOWN",
            description = "The cluster software is shutting down."
        },
        [5023] = {
            id = "ERROR_INVALID_STATE",
            description = "The group or resource is not in the correct state to perform the requested operation."
        },
        [5024] = {
            id = "ERROR_RESOURCE_PROPERTIES_STORED",
            description = "The properties were stored but not all changes will take effect until the next time the resource is brought online."
        },
        [5025] = {
            id = "ERROR_NOT_QUORUM_CLASS",
            description = "The cluster could not make the specified resource a quorum resource because it does not belong to a shared storage class."
        },
        [5026] = {
            id = "ERROR_CORE_RESOURCE",
            description = "The cluster resource could not be deleted since it is a core resource."
        },
        [5027] = {
            id = "ERROR_QUORUM_RESOURCE_ONLINE_FAILED",
            description = "The quorum resource failed to come online."
        },
        [5028] = {
            id = "ERROR_QUORUMLOG_OPEN_FAILED",
            description = "The quorum log could not be created or mounted successfully."
        },
        [5029] = {
            id = "ERROR_CLUSTERLOG_CORRUPT",
            description = "The cluster log is corrupt."
        },
        [5030] = {
            id = "ERROR_CLUSTERLOG_RECORD_EXCEEDS_MAXSIZE",
            description = "The record could not be written to the cluster log since it exceeds the maximum size."
        },
        [5031] = {
            id = "ERROR_CLUSTERLOG_EXCEEDS_MAXSIZE",
            description = "The cluster log exceeds its maximum size."
        },
        [5032] = {
            id = "ERROR_CLUSTERLOG_CHKPOINT_NOT_FOUND",
            description = "No checkpoint record was found in the cluster log."
        },
        [5033] = {
            id = "ERROR_CLUSTERLOG_NOT_ENOUGH_SPACE",
            description = "The minimum required disk space needed for logging is not available."
        },
        [5034] = {
            id = "ERROR_QUORUM_OWNER_ALIVE",
            description = "The cluster node failed to take control of the quorum resource because the resource is owned by another active node."
        },
        [5035] = {
            id = "ERROR_NETWORK_NOT_AVAILABLE",
            description = "A cluster network is not available for this operation."
        },
        [5036] = {
            id = "ERROR_NODE_NOT_AVAILABLE",
            description = "A cluster node is not available for this operation."
        },
        [5037] = {
            id = "ERROR_ALL_NODES_NOT_AVAILABLE",
            description = "All cluster nodes must be running to perform this operation."
        },
        [5038] = {
            id = "ERROR_RESOURCE_FAILED",
            description = "A cluster resource failed."
        },
        [5039] = {
            id = "ERROR_CLUSTER_INVALID_NODE",
            description = "The cluster node is not valid."
        },
        [5040] = {
            id = "ERROR_CLUSTER_NODE_EXISTS",
            description = "The cluster node already exists."
        },
        [5041] = {
            id = "ERROR_CLUSTER_JOIN_IN_PROGRESS",
            description = "A node is in the process of joining the cluster."
        },
        [5042] = {
            id = "ERROR_CLUSTER_NODE_NOT_FOUND",
            description = "The cluster node was not found."
        },
        [5043] = {
            id = "ERROR_CLUSTER_LOCAL_NODE_NOT_FOUND",
            description = "The cluster local node information was not found."
        },
        [5044] = {
            id = "ERROR_CLUSTER_NETWORK_EXISTS",
            description = "The cluster network already exists."
        },
        [5045] = {
            id = "ERROR_CLUSTER_NETWORK_NOT_FOUND",
            description = "The cluster network was not found."
        },
        [5046] = {
            id = "ERROR_CLUSTER_NETINTERFACE_EXISTS",
            description = "The cluster network interface already exists."
        },
        [5047] = {
            id = "ERROR_CLUSTER_NETINTERFACE_NOT_FOUND",
            description = "The cluster network interface was not found."
        },
        [5048] = {
            id = "ERROR_CLUSTER_INVALID_REQUEST",
            description = "The cluster request is not valid for this object."
        },
        [5049] = {
            id = "ERROR_CLUSTER_INVALID_NETWORK_PROVIDER",
            description = "The cluster network provider is not valid."
        },
        [5050] = {
            id = "ERROR_CLUSTER_NODE_DOWN",
            description = "The cluster node is down."
        },
        [5051] = {
            id = "ERROR_CLUSTER_NODE_UNREACHABLE",
            description = "The cluster node is not reachable."
        },
        [5052] = {
            id = "ERROR_CLUSTER_NODE_NOT_MEMBER",
            description = "The cluster node is not a member of the cluster."
        },
        [5053] = {
            id = "ERROR_CLUSTER_JOIN_NOT_IN_PROGRESS",
            description = "A cluster join operation is not in progress."
        },
        [5054] = {
            id = "ERROR_CLUSTER_INVALID_NETWORK",
            description = "The cluster network is not valid."
        },
        [5056] = {
            id = "ERROR_CLUSTER_NODE_UP",
            description = "The cluster node is up."
        },
        [5057] = {
            id = "ERROR_CLUSTER_IPADDR_IN_USE",
            description = "The cluster IP address is already in use."
        },
        [5058] = {
            id = "ERROR_CLUSTER_NODE_NOT_PAUSED",
            description = "The cluster node is not paused."
        },
        [5059] = {
            id = "ERROR_CLUSTER_NO_SECURITY_CONTEXT",
            description = "No cluster security context is available."
        },
        [5060] = {
            id = "ERROR_CLUSTER_NETWORK_NOT_INTERNAL",
            description = "The cluster network is not configured for internal cluster communication."
        },
        [5061] = {
            id = "ERROR_CLUSTER_NODE_ALREADY_UP",
            description = "The cluster node is already up."
        },
        [5062] = {
            id = "ERROR_CLUSTER_NODE_ALREADY_DOWN",
            description = "The cluster node is already down."
        },
        [5063] = {
            id = "ERROR_CLUSTER_NETWORK_ALREADY_ONLINE",
            description = "The cluster network is already online."
        },
        [5064] = {
            id = "ERROR_CLUSTER_NETWORK_ALREADY_OFFLINE",
            description = "The cluster network is already offline."
        },
        [5065] = {
            id = "ERROR_CLUSTER_NODE_ALREADY_MEMBER",
            description = "The cluster node is already a member of the cluster."
        },
        [5066] = {
            id = "ERROR_CLUSTER_LAST_INTERNAL_NETWORK",
            description = "The cluster network is the only one configured for internal cluster communication between two or more active cluster nodes. The internal communication capability cannot be removed from the network."
        },
        [5067] = {
            id = "ERROR_CLUSTER_NETWORK_HAS_DEPENDENTS",
            description = "One or more cluster resources depend on the network to provide service to clients. The client access capability cannot be removed from the network."
        },
        [5068] = {
            id = "ERROR_INVALID_OPERATION_ON_QUORUM",
            description = "This operation cannot be performed on the cluster resource as it the quorum resource. You may not bring the quorum resource offline or modify its possible owners list."
        },
        [5069] = {
            id = "ERROR_DEPENDENCY_NOT_ALLOWED",
            description = "The cluster quorum resource is not allowed to have any dependencies."
        },
        [5070] = {
            id = "ERROR_CLUSTER_NODE_PAUSED",
            description = "The cluster node is paused."
        },
        [5071] = {
            id = "ERROR_NODE_CANT_HOST_RESOURCE",
            description = "The cluster resource cannot be brought online. The owner node cannot run this resource."
        },
        [5072] = {
            id = "ERROR_CLUSTER_NODE_NOT_READY",
            description = "The cluster node is not ready to perform the requested operation."
        },
        [5073] = {
            id = "ERROR_CLUSTER_NODE_SHUTTING_DOWN",
            description = "The cluster node is shutting down."
        },
        [5074] = {
            id = "ERROR_CLUSTER_JOIN_ABORTED",
            description = "The cluster join operation was aborted."
        },
        [5075] = {
            id = "ERROR_CLUSTER_INCOMPATIBLE_VERSIONS",
            description = "The cluster join operation failed due to incompatible software versions between the joining node and its sponsor."
        },
        [5076] = {
            id = "ERROR_CLUSTER_MAXNUM_OF_RESOURCES_EXCEEDED",
            description = "This resource cannot be created because the cluster has reached the limit on the number of resources it can monitor."
        },
        [5077] = {
            id = "ERROR_CLUSTER_SYSTEM_CONFIG_CHANGED",
            description = "The system configuration changed during the cluster join or form operation. The join or form operation was aborted."
        },
        [5078] = {
            id = "ERROR_CLUSTER_RESOURCE_TYPE_NOT_FOUND",
            description = "The specified resource type was not found."
        },
        [5079] = {
            id = "ERROR_CLUSTER_RESTYPE_NOT_SUPPORTED",
            description = "The specified node does not support a resource of this type. This may be due to version inconsistencies or due to the absence of the resource DLL on this node."
        },
        [5080] = {
            id = "ERROR_CLUSTER_RESNAME_NOT_FOUND",
            description = "The specified resource name is not supported by this resource DLL. This may be due to a bad (or changed) name supplied to the resource DLL."
        },
        [5081] = {
            id = "ERROR_CLUSTER_NO_RPC_PACKAGES_REGISTERED",
            description = "No authentication package could be registered with the RPC server."
        },
        [5082] = {
            id = "ERROR_CLUSTER_OWNER_NOT_IN_PREFLIST",
            description = "You cannot bring the group online because the owner of the group is not in the preferred list for the group. To change the owner node for the group, move the group."
        },
        [5083] = {
            id = "ERROR_CLUSTER_DATABASE_SEQMISMATCH",
            description = "The join operation failed because the cluster database sequence number has changed or is incompatible with the locker node. This may happen during a join operation if the cluster database was changing during the join."
        },
        [5084] = {
            id = "ERROR_RESMON_INVALID_STATE",
            description = "The resource monitor will not allow the fail operation to be performed while the resource is in its current state. This may happen if the resource is in a pending state."
        },
        [5085] = {
            id = "ERROR_CLUSTER_GUM_NOT_LOCKER",
            description = "A non locker code got a request to reserve the lock for making global updates."
        },
        [5086] = {
            id = "ERROR_QUORUM_DISK_NOT_FOUND",
            description = "The quorum disk could not be located by the cluster service."
        },
        [5087] = {
            id = "ERROR_DATABASE_BACKUP_CORRUPT",
            description = "The backed up cluster database is possibly corrupt."
        },
        [5088] = {
            id = "ERROR_CLUSTER_NODE_ALREADY_HAS_DFS_ROOT",
            description = "A DFS root already exists in this cluster node."
        },
        [5089] = {
            id = "ERROR_RESOURCE_PROPERTY_UNCHANGEABLE",
            description = "An attempt to modify a resource property failed because it conflicts with another existing property."
        },
        [5890] = {
            id = "ERROR_CLUSTER_MEMBERSHIP_INVALID_STATE",
            description = "An operation was attempted that is incompatible with the current membership state of the node."
        },
        [5891] = {
            id = "ERROR_CLUSTER_QUORUMLOG_NOT_FOUND",
            description = "The quorum resource does not contain the quorum log."
        },
        [5892] = {
            id = "ERROR_CLUSTER_MEMBERSHIP_HALT",
            description = "The membership engine requested shutdown of the cluster service on this node."
        },
        [5893] = {
            id = "ERROR_CLUSTER_INSTANCE_ID_MISMATCH",
            description = "The join operation failed because the cluster instance ID of the joining node does not match the cluster instance ID of the sponsor node."
        },
        [5894] = {
            id = "ERROR_CLUSTER_NETWORK_NOT_FOUND_FOR_IP",
            description = "A matching cluster network for the specified IP address could not be found."
        },
        [5895] = {
            id = "ERROR_CLUSTER_PROPERTY_DATA_TYPE_MISMATCH",
            description = "The actual data type of the property did not match the expected data type of the property."
        },
        [5896] = {
            id = "ERROR_CLUSTER_EVICT_WITHOUT_CLEANUP",
            description = "The cluster node was evicted from the cluster successfully, but the node was not cleaned up. To determine what cleanup steps failed and how to recover, see the Failover Clustering application event log using Event Viewer."
        },
        [5897] = {
            id = "ERROR_CLUSTER_PARAMETER_MISMATCH",
            description = "Two or more parameter values specified for a resource's properties are in conflict."
        },
        [5898] = {
            id = "ERROR_NODE_CANNOT_BE_CLUSTERED",
            description = "This computer cannot be made a member of a cluster."
        },
        [5899] = {
            id = "ERROR_CLUSTER_WRONG_OS_VERSION",
            description = "This computer cannot be made a member of a cluster because it does not have the correct version of Windows installed."
        },
        [5900] = {
            id = "ERROR_CLUSTER_CANT_CREATE_DUP_CLUSTER_NAME",
            description = "A cluster cannot be created with the specified cluster name because that cluster name is already in use. Specify a different name for the cluster."
        },
        [5901] = {
            id = "ERROR_CLUSCFG_ALREADY_COMMITTED",
            description = "The cluster configuration action has already been committed."
        },
        [5902] = {
            id = "ERROR_CLUSCFG_ROLLBACK_FAILED",
            description = "The cluster configuration action could not be rolled back."
        },
        [5903] = {
            id = "ERROR_CLUSCFG_SYSTEM_DISK_DRIVE_LETTER_CONFLICT",
            description = "The drive letter assigned to a system disk on one node conflicted with the drive letter assigned to a disk on another node."
        },
        [5904] = {
            id = "ERROR_CLUSTER_OLD_VERSION",
            description = "One or more nodes in the cluster are running a version of Windows that does not support this operation."
        },
        [5905] = {
            id = "ERROR_CLUSTER_MISMATCHED_COMPUTER_ACCT_NAME",
            description = "The name of the corresponding computer account doesn't match the Network Name for this resource."
        },
        [5906] = {
            id = "ERROR_CLUSTER_NO_NET_ADAPTERS",
            description = "No network adapters are available."
        },
        [5907] = {
            id = "ERROR_CLUSTER_POISONED",
            description = "The cluster node has been poisoned."
        },
        [5908] = {
            id = "ERROR_CLUSTER_GROUP_MOVING",
            description = "The group is unable to accept the request since it is moving to another node."
        },
        [5909] = {
            id = "ERROR_CLUSTER_RESOURCE_TYPE_BUSY",
            description = "The resource type cannot accept the request since is too busy performing another operation."
        },
        [5910] = {
            id = "ERROR_RESOURCE_CALL_TIMED_OUT",
            description = "The call to the cluster resource DLL timed out."
        },
        [5911] = {
            id = "ERROR_INVALID_CLUSTER_IPV6_ADDRESS",
            description = "The address is not valid for an IPv6 Address resource. A global IPv6 address is required, and it must match a cluster network. Compatibility addresses are not permitted."
        },
        [5912] = {
            id = "ERROR_CLUSTER_INTERNAL_INVALID_FUNCTION",
            description = "An internal cluster error occurred. A call to an invalid function was attempted."
        },
        [5913] = {
            id = "ERROR_CLUSTER_PARAMETER_OUT_OF_BOUNDS",
            description = "A parameter value is out of acceptable range."
        },
        [5914] = {
            id = "ERROR_CLUSTER_PARTIAL_SEND",
            description = "A network error occurred while sending data to another node in the cluster. The number of bytes transmitted was less than required."
        },
        [5915] = {
            id = "ERROR_CLUSTER_REGISTRY_INVALID_FUNCTION",
            description = "An invalid cluster registry operation was attempted."
        },
        [5916] = {
            id = "ERROR_CLUSTER_INVALID_STRING_TERMINATION",
            description = "An input string of characters is not properly terminated."
        },
        [5917] = {
            id = "ERROR_CLUSTER_INVALID_STRING_FORMAT",
            description = "An input string of characters is not in a valid format for the data it represents."
        },
        [5918] = {
            id = "ERROR_CLUSTER_DATABASE_TRANSACTION_IN_PROGRESS",
            description = "An internal cluster error occurred. A cluster database transaction was attempted while a transaction was already in progress."
        },
        [5919] = {
            id = "ERROR_CLUSTER_DATABASE_TRANSACTION_NOT_IN_PROGRESS",
            description = "An internal cluster error occurred. There was an attempt to commit a cluster database transaction while no transaction was in progress."
        },
        [5920] = {
            id = "ERROR_CLUSTER_NULL_DATA",
            description = "An internal cluster error occurred. Data was not properly initialized."
        },
        [5921] = {
            id = "ERROR_CLUSTER_PARTIAL_READ",
            description = "An error occurred while reading from a stream of data. An unexpected number of bytes was returned."
        },
        [5922] = {
            id = "ERROR_CLUSTER_PARTIAL_WRITE",
            description = "An error occurred while writing to a stream of data. The required number of bytes could not be written."
        },
        [5923] = {
            id = "ERROR_CLUSTER_CANT_DESERIALIZE_DATA",
            description = "An error occurred while deserializing a stream of cluster data."
        },
        [5924] = {
            id = "ERROR_DEPENDENT_RESOURCE_PROPERTY_CONFLICT",
            description = "One or more property values for this resource are in conflict with one or more property values associated with its dependent resource(s)."
        },
        [5925] = {
            id = "ERROR_CLUSTER_NO_QUORUM",
            description = "A quorum of cluster nodes was not present to form a cluster."
        },
        [5926] = {
            id = "ERROR_CLUSTER_INVALID_IPV6_NETWORK",
            description = "The cluster network is not valid for an IPv6 Address resource, or it does not match the configured address."
        },
        [5927] = {
            id = "ERROR_CLUSTER_INVALID_IPV6_TUNNEL_NETWORK",
            description = "The cluster network is not valid for an IPv6 Tunnel resource. Check the configuration of the IP Address resource on which the IPv6 Tunnel resource depends."
        },
        [5928] = {
            id = "ERROR_QUORUM_NOT_ALLOWED_IN_THIS_GROUP",
            description = "Quorum resource cannot reside in the Available Storage group."
        },
        [5929] = {
            id = "ERROR_DEPENDENCY_TREE_TOO_COMPLEX",
            description = "The dependencies for this resource are nested too deeply."
        },
        [5930] = {
            id = "ERROR_EXCEPTION_IN_RESOURCE_CALL",
            description = "The call into the resource DLL raised an unhandled exception."
        },
        [5931] = {
            id = "ERROR_CLUSTER_RHS_FAILED_INITIALIZATION",
            description = "The RHS process failed to initialize."
        },
        [5932] = {
            id = "ERROR_CLUSTER_NOT_INSTALLED",
            description = "The Failover Clustering feature is not installed on this node."
        },
        [5933] = {
            id = "ERROR_CLUSTER_RESOURCES_MUST_BE_ONLINE_ON_THE_SAME_NODE",
            description = "The resources must be online on the same node for this operation."
        },
        [5934] = {
            id = "ERROR_CLUSTER_MAX_NODES_IN_CLUSTER",
            description = "A new node can not be added since this cluster is already at its maximum number of nodes."
        },
        [5935] = {
            id = "ERROR_CLUSTER_TOO_MANY_NODES",
            description = "This cluster can not be created since the specified number of nodes exceeds the maximum allowed limit."
        },
        [5936] = {
            id = "ERROR_CLUSTER_OBJECT_ALREADY_USED",
            description = "An attempt to use the specified cluster name failed because an enabled computer object with the given name already exists in the domain."
        },
        [5937] = {
            id = "ERROR_NONCORE_GROUPS_FOUND",
            description = "This cluster cannot be destroyed. It has non-core application groups which must be deleted before the cluster can be destroyed."
        },
        [5938] = {
            id = "ERROR_FILE_SHARE_RESOURCE_CONFLICT",
            description = "File share associated with file share witness resource cannot be hosted by this cluster or any of its nodes."
        },
        [5939] = {
            id = "ERROR_CLUSTER_EVICT_INVALID_REQUEST",
            description = "Eviction of this node is invalid at this time. Due to quorum requirements node eviction will result in cluster shutdown. If it is the last node in the cluster, destroy cluster command should be used."
        },
        [5940] = {
            id = "ERROR_CLUSTER_SINGLETON_RESOURCE",
            description = "Only one instance of this resource type is allowed in the cluster."
        },
        [5941] = {
            id = "ERROR_CLUSTER_GROUP_SINGLETON_RESOURCE",
            description = "Only one instance of this resource type is allowed per resource group."
        },
        [5942] = {
            id = "ERROR_CLUSTER_RESOURCE_PROVIDER_FAILED",
            description = "The resource failed to come online due to the failure of one or more provider resources."
        },
        [5943] = {
            id = "ERROR_CLUSTER_RESOURCE_CONFIGURATION_ERROR",
            description = "The resource has indicated that it cannot come online on any node."
        },
        [5944] = {
            id = "ERROR_CLUSTER_GROUP_BUSY",
            description = "The current operation cannot be performed on this group at this time."
        },
        [5945] = {
            id = "ERROR_CLUSTER_NOT_SHARED_VOLUME",
            description = "The directory or file is not located on a cluster shared volume."
        },
        [5946] = {
            id = "ERROR_CLUSTER_INVALID_SECURITY_DESCRIPTOR",
            description = "The Security Descriptor does not meet the requirements for a cluster."
        },
        [5947] = {
            id = "ERROR_CLUSTER_SHARED_VOLUMES_IN_USE",
            description = "There is one or more shared volumes resources configured in the cluster. Those resources must be moved to available storage in order for operation to succeed."
        },
        [5948] = {
            id = "ERROR_CLUSTER_USE_SHARED_VOLUMES_API",
            description = "This group or resource cannot be directly manipulated. Use shared volume APIs to perform desired operation."
        },
        [5949] = {
            id = "ERROR_CLUSTER_BACKUP_IN_PROGRESS",
            description = "Back up is in progress. Please wait for backup completion before trying this operation again."
        },
        [5950] = {
            id = "ERROR_NON_CSV_PATH",
            description = "The path does not belong to a cluster shared volume."
        },
        [5951] = {
            id = "ERROR_CSV_VOLUME_NOT_LOCAL",
            description = "The cluster shared volume is not locally mounted on this node."
        },
        [5952] = {
            id = "ERROR_CLUSTER_WATCHDOG_TERMINATING",
            description = "The cluster watchdog is terminating."
        },
        [5953] = {
            id = "ERROR_CLUSTER_RESOURCE_VETOED_MOVE_INCOMPATIBLE_NODES",
            description = "A resource vetoed a move between two nodes because they are incompatible."
        },
        [5954] = {
            id = "ERROR_CLUSTER_INVALID_NODE_WEIGHT",
            description = "The request is invalid either because node weight cannot be changed while the cluster is in disk-only quorum mode, or because changing the node weight would violate the minimum cluster quorum requirements."
        },
        [5955] = {
            id = "ERROR_CLUSTER_RESOURCE_VETOED_CALL",
            description = "The resource vetoed the call."
        },
        [5956] = {
            id = "ERROR_RESMON_SYSTEM_RESOURCES_LACKING",
            description = "Resource could not start or run because it could not reserve sufficient system resources."
        },
        [5957] = {
            id = "ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_DESTINATION",
            description = "A resource vetoed a move between two nodes because the destination currently does not have enough resources to complete the operation."
        },
        [5958] = {
            id = "ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_SOURCE",
            description = "A resource vetoed a move between two nodes because the source currently does not have enough resources to complete the operation."
        },
        [5959] = {
            id = "ERROR_CLUSTER_GROUP_QUEUED",
            description = "The requested operation can not be completed because the group is queued for an operation."
        },
        [5960] = {
            id = "ERROR_CLUSTER_RESOURCE_LOCKED_STATUS",
            description = "The requested operation can not be completed because a resource has locked status."
        },
        [5961] = {
            id = "ERROR_CLUSTER_SHARED_VOLUME_FAILOVER_NOT_ALLOWED",
            description = "The resource cannot move to another node because a cluster shared volume vetoed the operation."
        },
        [5962] = {
            id = "ERROR_CLUSTER_NODE_DRAIN_IN_PROGRESS",
            description = "A node drain is already in progress.\n\nThis value was also named ERROR_CLUSTER_NODE_EVACUATION_IN_PROGRESS"
        },
        [5963] = {
            id = "ERROR_CLUSTER_DISK_NOT_CONNECTED",
            description = "Clustered storage is not connected to the node."
        },
        [5964] = {
            id = "ERROR_DISK_NOT_CSV_CAPABLE",
            description = "The disk is not configured in a way to be used with CSV. CSV disks must have at least one partition that is formatted with NTFS."
        },
        [5965] = {
            id = "ERROR_RESOURCE_NOT_IN_AVAILABLE_STORAGE",
            description = "The resource must be part of the Available Storage group to complete this action."
        },
        [5966] = {
            id = "ERROR_CLUSTER_SHARED_VOLUME_REDIRECTED",
            description = "CSVFS failed operation as volume is in redirected mode."
        },
        [5967] = {
            id = "ERROR_CLUSTER_SHARED_VOLUME_NOT_REDIRECTED",
            description = "CSVFS failed operation as volume is not in redirected mode."
        },
        [5968] = {
            id = "ERROR_CLUSTER_CANNOT_RETURN_PROPERTIES",
            description = "Cluster properties cannot be returned at this time."
        },
        [5969] = {
            id = "ERROR_CLUSTER_RESOURCE_CONTAINS_UNSUPPORTED_DIFF_AREA_FOR_SHARED_VOLUMES",
            description = "The clustered disk resource contains software snapshot diff area that are not supported for Cluster Shared Volumes."
        },
        [5970] = {
            id = "ERROR_CLUSTER_RESOURCE_IS_IN_MAINTENANCE_MODE",
            description = "The operation cannot be completed because the resource is in maintenance mode."
        },
        [5971] = {
            id = "ERROR_CLUSTER_AFFINITY_CONFLICT",
            description = "The operation cannot be completed because of cluster affinity conflicts."
        },
        [5972] = {
            id = "ERROR_CLUSTER_RESOURCE_IS_REPLICA_VIRTUAL_MACHINE",
            description = "The operation cannot be completed because the resource is a replica virtual machine."
        },
        [6000] = {
            id = "ERROR_ENCRYPTION_FAILED",
            description = "The specified file could not be encrypted."
        },
        [6001] = {
            id = "ERROR_DECRYPTION_FAILED",
            description = "The specified file could not be decrypted."
        },
        [6002] = {
            id = "ERROR_FILE_ENCRYPTED",
            description = "The specified file is encrypted and the user does not have the ability to decrypt it."
        },
        [6003] = {
            id = "ERROR_NO_RECOVERY_POLICY",
            description = "There is no valid encryption recovery policy configured for this system."
        },
        [6004] = {
            id = "ERROR_NO_EFS",
            description = "The required encryption driver is not loaded for this system."
        },
        [6005] = {
            id = "ERROR_WRONG_EFS",
            description = "The file was encrypted with a different encryption driver than is currently loaded."
        },
        [6006] = {
            id = "ERROR_NO_USER_KEYS",
            description = "There are no EFS keys defined for the user."
        },
        [6007] = {
            id = "ERROR_FILE_NOT_ENCRYPTED",
            description = "The specified file is not encrypted."
        },
        [6008] = {
            id = "ERROR_NOT_EXPORT_FORMAT",
            description = "The specified file is not in the defined EFS export format."
        },
        [6009] = {
            id = "ERROR_FILE_READ_ONLY",
            description = "The specified file is read only."
        },
        [6010] = {
            id = "ERROR_DIR_EFS_DISALLOWED",
            description = "The directory has been disabled for encryption."
        },
        [6011] = {
            id = "ERROR_EFS_SERVER_NOT_TRUSTED",
            description = "The server is not trusted for remote encryption operation."
        },
        [6012] = {
            id = "ERROR_BAD_RECOVERY_POLICY",
            description = "Recovery policy configured for this system contains invalid recovery certificate."
        },
        [6013] = {
            id = "ERROR_EFS_ALG_BLOB_TOO_BIG",
            description = "The encryption algorithm used on the source file needs a bigger key buffer than the one on the destination file."
        },
        [6014] = {
            id = "ERROR_VOLUME_NOT_SUPPORT_EFS",
            description = "The disk partition does not support file encryption."
        },
        [6015] = {
            id = "ERROR_EFS_DISABLED",
            description = "This machine is disabled for file encryption."
        },
        [6016] = {
            id = "ERROR_EFS_VERSION_NOT_SUPPORT",
            description = "A newer system is required to decrypt this encrypted file."
        },
        [6017] = {
            id = "ERROR_CS_ENCRYPTION_INVALID_SERVER_RESPONSE",
            description = "The remote server sent an invalid response for a file being opened with Client Side Encryption."
        },
        [6018] = {
            id = "ERROR_CS_ENCRYPTION_UNSUPPORTED_SERVER",
            description = "Client Side Encryption is not supported by the remote server even though it claims to support it."
        },
        [6019] = {
            id = "ERROR_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE",
            description = "File is encrypted and should be opened in Client Side Encryption mode."
        },
        [6020] = {
            id = "ERROR_CS_ENCRYPTION_NEW_ENCRYPTED_FILE",
            description = "A new encrypted file is being created and a $EFS needs to be provided."
        },
        [6021] = {
            id = "ERROR_CS_ENCRYPTION_FILE_NOT_CSE",
            description = "The SMB client requested a CSE FSCTL on a non-CSE file."
        },
        [6022] = {
            id = "ERROR_ENCRYPTION_POLICY_DENIES_OPERATION",
            description = "The requested operation was blocked by policy. For more information, contact your system administrator."
        },
        [6118] = {
            id = "ERROR_NO_BROWSER_SERVERS_FOUND",
            description = "The list of servers for this workgroup is not currently available."
        },
        [6200] = {
            id = "SCHED_E_SERVICE_NOT_LOCALSYSTEM",
            description = "The Task Scheduler service must be configured to run in the System account to function properly. Individual tasks may be configured to run in other accounts."
        },
        [6600] = {
            id = "ERROR_LOG_SECTOR_INVALID",
            description = "Log service encountered an invalid log sector."
        },
        [6601] = {
            id = "ERROR_LOG_SECTOR_PARITY_INVALID",
            description = "Log service encountered a log sector with invalid block parity."
        },
        [6602] = {
            id = "ERROR_LOG_SECTOR_REMAPPED",
            description = "Log service encountered a remapped log sector."
        },
        [6603] = {
            id = "ERROR_LOG_BLOCK_INCOMPLETE",
            description = "Log service encountered a partial or incomplete log block."
        },
        [6604] = {
            id = "ERROR_LOG_INVALID_RANGE",
            description = "Log service encountered an attempt access data outside the active log range."
        },
        [6605] = {
            id = "ERROR_LOG_BLOCKS_EXHAUSTED",
            description = "Log service user marshalling buffers are exhausted."
        },
        [6606] = {
            id = "ERROR_LOG_READ_CONTEXT_INVALID",
            description = "Log service encountered an attempt read from a marshalling area with an invalid read context."
        },
        [6607] = {
            id = "ERROR_LOG_RESTART_INVALID",
            description = "Log service encountered an invalid log restart area."
        },
        [6608] = {
            id = "ERROR_LOG_BLOCK_VERSION",
            description = "Log service encountered an invalid log block version."
        },
        [6609] = {
            id = "ERROR_LOG_BLOCK_INVALID",
            description = "Log service encountered an invalid log block."
        },
        [6610] = {
            id = "ERROR_LOG_READ_MODE_INVALID",
            description = "Log service encountered an attempt to read the log with an invalid read mode."
        },
        [6611] = {
            id = "ERROR_LOG_NO_RESTART",
            description = "Log service encountered a log stream with no restart area."
        },
        [6612] = {
            id = "ERROR_LOG_METADATA_CORRUPT",
            description = "Log service encountered a corrupted metadata file."
        },
        [6613] = {
            id = "ERROR_LOG_METADATA_INVALID",
            description = "Log service encountered a metadata file that could not be created by the log file system."
        },
        [6614] = {
            id = "ERROR_LOG_METADATA_INCONSISTENT",
            description = "Log service encountered a metadata file with inconsistent data."
        },
        [6615] = {
            id = "ERROR_LOG_RESERVATION_INVALID",
            description = "Log service encountered an attempt to erroneous allocate or dispose reservation space."
        },
        [6616] = {
            id = "ERROR_LOG_CANT_DELETE",
            description = "Log service cannot delete log file or file system container."
        },
        [6617] = {
            id = "ERROR_LOG_CONTAINER_LIMIT_EXCEEDED",
            description = "Log service has reached the maximum allowable containers allocated to a log file."
        },
        [6618] = {
            id = "ERROR_LOG_START_OF_LOG",
            description = "Log service has attempted to read or write backward past the start of the log."
        },
        [6619] = {
            id = "ERROR_LOG_POLICY_ALREADY_INSTALLED",
            description = "Log policy could not be installed because a policy of the same type is already present."
        },
        [6620] = {
            id = "ERROR_LOG_POLICY_NOT_INSTALLED",
            description = "Log policy in question was not installed at the time of the request."
        },
        [6621] = {
            id = "ERROR_LOG_POLICY_INVALID",
            description = "The installed set of policies on the log is invalid."
        },
        [6622] = {
            id = "ERROR_LOG_POLICY_CONFLICT",
            description = "A policy on the log in question prevented the operation from completing."
        },
        [6623] = {
            id = "ERROR_LOG_PINNED_ARCHIVE_TAIL",
            description = "Log space cannot be reclaimed because the log is pinned by the archive tail."
        },
        [6624] = {
            id = "ERROR_LOG_RECORD_NONEXISTENT",
            description = "Log record is not a record in the log file."
        },
        [6625] = {
            id = "ERROR_LOG_RECORDS_RESERVED_INVALID",
            description = "Number of reserved log records or the adjustment of the number of reserved log records is invalid."
        },
        [6626] = {
            id = "ERROR_LOG_SPACE_RESERVED_INVALID",
            description = "Reserved log space or the adjustment of the log space is invalid."
        },
        [6627] = {
            id = "ERROR_LOG_TAIL_INVALID",
            description = "An new or existing archive tail or base of the active log is invalid."
        },
        [6628] = {
            id = "ERROR_LOG_FULL",
            description = "Log space is exhausted."
        },
        [6629] = {
            id = "ERROR_COULD_NOT_RESIZE_LOG",
            description = "The log could not be set to the requested size."
        },
        [6630] = {
            id = "ERROR_LOG_MULTIPLEXED",
            description = "Log is multiplexed, no direct writes to the physical log is allowed."
        },
        [6631] = {
            id = "ERROR_LOG_DEDICATED",
            description = "The operation failed because the log is a dedicated log."
        },
        [6632] = {
            id = "ERROR_LOG_ARCHIVE_NOT_IN_PROGRESS",
            description = "The operation requires an archive context."
        },
        [6633] = {
            id = "ERROR_LOG_ARCHIVE_IN_PROGRESS",
            description = "Log archival is in progress."
        },
        [6634] = {
            id = "ERROR_LOG_EPHEMERAL",
            description = "The operation requires a non-ephemeral log, but the log is ephemeral."
        },
        [6635] = {
            id = "ERROR_LOG_NOT_ENOUGH_CONTAINERS",
            description = "The log must have at least two containers before it can be read from or written to."
        },
        [6636] = {
            id = "ERROR_LOG_CLIENT_ALREADY_REGISTERED",
            description = "A log client has already registered on the stream."
        },
        [6637] = {
            id = "ERROR_LOG_CLIENT_NOT_REGISTERED",
            description = "A log client has not been registered on the stream."
        },
        [6638] = {
            id = "ERROR_LOG_FULL_HANDLER_IN_PROGRESS",
            description = "A request has already been made to handle the log full condition."
        },
        [6639] = {
            id = "ERROR_LOG_CONTAINER_READ_FAILED",
            description = "Log service encountered an error when attempting to read from a log container."
        },
        [6640] = {
            id = "ERROR_LOG_CONTAINER_WRITE_FAILED",
            description = "Log service encountered an error when attempting to write to a log container."
        },
        [6641] = {
            id = "ERROR_LOG_CONTAINER_OPEN_FAILED",
            description = "Log service encountered an error when attempting open a log container."
        },
        [6642] = {
            id = "ERROR_LOG_CONTAINER_STATE_INVALID",
            description = "Log service encountered an invalid container state when attempting a requested action."
        },
        [6643] = {
            id = "ERROR_LOG_STATE_INVALID",
            description = "Log service is not in the correct state to perform a requested action."
        },
        [6644] = {
            id = "ERROR_LOG_PINNED",
            description = "Log space cannot be reclaimed because the log is pinned."
        },
        [6645] = {
            id = "ERROR_LOG_METADATA_FLUSH_FAILED",
            description = "Log metadata flush failed."
        },
        [6646] = {
            id = "ERROR_LOG_INCONSISTENT_SECURITY",
            description = "Security on the log and its containers is inconsistent."
        },
        [6647] = {
            id = "ERROR_LOG_APPENDED_FLUSH_FAILED",
            description = "Records were appended to the log or reservation changes were made, but the log could not be flushed."
        },
        [6648] = {
            id = "ERROR_LOG_PINNED_RESERVATION",
            description = "The log is pinned due to reservation consuming most of the log space. Free some reserved records to make space available."
        },
        [6700] = {
            id = "ERROR_INVALID_TRANSACTION",
            description = "The transaction handle associated with this operation is not valid."
        },
        [6701] = {
            id = "ERROR_TRANSACTION_NOT_ACTIVE",
            description = "The requested operation was made in the context of a transaction that is no longer active."
        },
        [6702] = {
            id = "ERROR_TRANSACTION_REQUEST_NOT_VALID",
            description = "The requested operation is not valid on the Transaction object in its current state."
        },
        [6703] = {
            id = "ERROR_TRANSACTION_NOT_REQUESTED",
            description = "The caller has called a response API, but the response is not expected because the TM did not issue the corresponding request to the caller."
        },
        [6704] = {
            id = "ERROR_TRANSACTION_ALREADY_ABORTED",
            description = "It is too late to perform the requested operation, since the Transaction has already been aborted."
        },
        [6705] = {
            id = "ERROR_TRANSACTION_ALREADY_COMMITTED",
            description = "It is too late to perform the requested operation, since the Transaction has already been committed."
        },
        [6706] = {
            id = "ERROR_TM_INITIALIZATION_FAILED",
            description = "The Transaction Manager was unable to be successfully initialized. Transacted operations are not supported."
        },
        [6707] = {
            id = "ERROR_RESOURCEMANAGER_READ_ONLY",
            description = "The specified ResourceManager made no changes or updates to the resource under this transaction."
        },
        [6708] = {
            id = "ERROR_TRANSACTION_NOT_JOINED",
            description = "The resource manager has attempted to prepare a transaction that it has not successfully joined."
        },
        [6709] = {
            id = "ERROR_TRANSACTION_SUPERIOR_EXISTS",
            description = "The Transaction object already has a superior enlistment, and the caller attempted an operation that would have created a new superior. Only a single superior enlistment is allow."
        },
        [6710] = {
            id = "ERROR_CRM_PROTOCOL_ALREADY_EXISTS",
            description = "The RM tried to register a protocol that already exists."
        },
        [6711] = {
            id = "ERROR_TRANSACTION_PROPAGATION_FAILED",
            description = "The attempt to propagate the Transaction failed."
        },
        [6712] = {
            id = "ERROR_CRM_PROTOCOL_NOT_FOUND",
            description = "The requested propagation protocol was not registered as a CRM."
        },
        [6713] = {
            id = "ERROR_TRANSACTION_INVALID_MARSHALL_BUFFER",
            description = "The buffer passed in to PushTransaction or PullTransaction is not in a valid format."
        },
        [6714] = {
            id = "ERROR_CURRENT_TRANSACTION_NOT_VALID",
            description = "The current transaction context associated with the thread is not a valid handle to a transaction object."
        },
        [6715] = {
            id = "ERROR_TRANSACTION_NOT_FOUND",
            description = "The specified Transaction object could not be opened, because it was not found."
        },
        [6716] = {
            id = "ERROR_RESOURCEMANAGER_NOT_FOUND",
            description = "The specified ResourceManager object could not be opened, because it was not found."
        },
        [6717] = {
            id = "ERROR_ENLISTMENT_NOT_FOUND",
            description = "The specified Enlistment object could not be opened, because it was not found."
        },
        [6718] = {
            id = "ERROR_TRANSACTIONMANAGER_NOT_FOUND",
            description = "The specified TransactionManager object could not be opened, because it was not found."
        },
        [6719] = {
            id = "ERROR_TRANSACTIONMANAGER_NOT_ONLINE",
            description = "The object specified could not be created or opened, because its associated TransactionManager is not online. The TransactionManager must be brought fully Online by calling RecoverTransactionManager to recover to the end of its LogFile before objects in its Transaction or ResourceManager namespaces can be opened. In addition, errors in writing records to its LogFile can cause a TransactionManager to go offline."
        },
        [6720] = {
            id = "ERROR_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION",
            description = "The specified TransactionManager was unable to create the objects contained in its logfile in the Ob namespace. Therefore, the TransactionManager was unable to recover."
        },
        [6721] = {
            id = "ERROR_TRANSACTION_NOT_ROOT",
            description = "The call to create a superior Enlistment on this Transaction object could not be completed, because the Transaction object specified for the enlistment is a subordinate branch of the Transaction. Only the root of the Transaction can be enlisted on as a superior."
        },
        [6722] = {
            id = "ERROR_TRANSACTION_OBJECT_EXPIRED",
            description = "Because the associated transaction manager or resource manager has been closed, the handle is no longer valid."
        },
        [6723] = {
            id = "ERROR_TRANSACTION_RESPONSE_NOT_ENLISTED",
            description = "The specified operation could not be performed on this Superior enlistment, because the enlistment was not created with the corresponding completion response in the NotificationMask."
        },
        [6724] = {
            id = "ERROR_TRANSACTION_RECORD_TOO_LONG",
            description = "The specified operation could not be performed, because the record that would be logged was too long. This can occur because of two conditions: either there are too many Enlistments on this Transaction, or the combined RecoveryInformation being logged on behalf of those Enlistments is too long."
        },
        [6725] = {
            id = "ERROR_IMPLICIT_TRANSACTION_NOT_SUPPORTED",
            description = "Implicit transaction are not supported."
        },
        [6726] = {
            id = "ERROR_TRANSACTION_INTEGRITY_VIOLATED",
            description = "The kernel transaction manager had to abort or forget the transaction because it blocked forward progress."
        },
        [6727] = {
            id = "ERROR_TRANSACTIONMANAGER_IDENTITY_MISMATCH",
            description = "The TransactionManager identity that was supplied did not match the one recorded in the TransactionManager's log file."
        },
        [6728] = {
            id = "ERROR_RM_CANNOT_BE_FROZEN_FOR_SNAPSHOT",
            description = "This snapshot operation cannot continue because a transactional resource manager cannot be frozen in its current state. Please try again."
        },
        [6729] = {
            id = "ERROR_TRANSACTION_MUST_WRITETHROUGH",
            description = "The transaction cannot be enlisted on with the specified EnlistmentMask, because the transaction has already completed the PrePrepare phase. In order to ensure correctness, the ResourceManager must switch to a write- through mode and cease caching data within this transaction. Enlisting for only subsequent transaction phases may still succeed."
        },
        [6730] = {
            id = "ERROR_TRANSACTION_NO_SUPERIOR",
            description = "The transaction does not have a superior enlistment."
        },
        [6731] = {
            id = "ERROR_HEURISTIC_DAMAGE_POSSIBLE",
            description = "The attempt to commit the Transaction completed, but it is possible that some portion of the transaction tree did not commit successfully due to heuristics. Therefore it is possible that some data modified in the transaction may not have committed, resulting in transactional inconsistency. If possible, check the consistency of the associated data."
        },
        [6800] = {
            id = "ERROR_TRANSACTIONAL_CONFLICT",
            description = "The function attempted to use a name that is reserved for use by another transaction."
        },
        [6801] = {
            id = "ERROR_RM_NOT_ACTIVE",
            description = "Transaction support within the specified resource manager is not started or was shut down due to an error."
        },
        [6802] = {
            id = "ERROR_RM_METADATA_CORRUPT",
            description = "The metadata of the RM has been corrupted. The RM will not function."
        },
        [6803] = {
            id = "ERROR_DIRECTORY_NOT_RM",
            description = "The specified directory does not contain a resource manager."
        },
        [6805] = {
            id = "ERROR_TRANSACTIONS_UNSUPPORTED_REMOTE",
            description = "The remote server or share does not support transacted file operations."
        },
        [6806] = {
            id = "ERROR_LOG_RESIZE_INVALID_SIZE",
            description = "The requested log size is invalid."
        },
        [6807] = {
            id = "ERROR_OBJECT_NO_LONGER_EXISTS",
            description = "The object (file, stream, link) corresponding to the handle has been deleted by a Transaction Savepoint Rollback."
        },
        [6808] = {
            id = "ERROR_STREAM_MINIVERSION_NOT_FOUND",
            description = "The specified file miniversion was not found for this transacted file open."
        },
        [6809] = {
            id = "ERROR_STREAM_MINIVERSION_NOT_VALID",
            description = "The specified file miniversion was found but has been invalidated. Most likely cause is a transaction savepoint rollback."
        },
        [6810] = {
            id = "ERROR_MINIVERSION_INACCESSIBLE_FROM_SPECIFIED_TRANSACTION",
            description = "A miniversion may only be opened in the context of the transaction that created it."
        },
        [6811] = {
            id = "ERROR_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT",
            description = "It is not possible to open a miniversion with modify access."
        },
        [6812] = {
            id = "ERROR_CANT_CREATE_MORE_STREAM_MINIVERSIONS",
            description = "It is not possible to create any more miniversions for this stream."
        },
        [6814] = {
            id = "ERROR_REMOTE_FILE_VERSION_MISMATCH",
            description = "The remote server sent mismatching version number or Fid for a file opened with transactions."
        },
        [6815] = {
            id = "ERROR_HANDLE_NO_LONGER_VALID",
            description = "The handle has been invalidated by a transaction. The most likely cause is the presence of memory mapping on a file or an open handle when the transaction ended or rolled back to savepoint."
        },
        [6816] = {
            id = "ERROR_NO_TXF_METADATA",
            description = "There is no transaction metadata on the file."
        },
        [6817] = {
            id = "ERROR_LOG_CORRUPTION_DETECTED",
            description = "The log data is corrupt."
        },
        [6818] = {
            id = "ERROR_CANT_RECOVER_WITH_HANDLE_OPEN",
            description = "The file can't be recovered because there is a handle still open on it."
        },
        [6819] = {
            id = "ERROR_RM_DISCONNECTED",
            description = "The transaction outcome is unavailable because the resource manager responsible for it has disconnected."
        },
        [6820] = {
            id = "ERROR_ENLISTMENT_NOT_SUPERIOR",
            description = "The request was rejected because the enlistment in question is not a superior enlistment."
        },
        [6821] = {
            id = "ERROR_RECOVERY_NOT_NEEDED",
            description = "The transactional resource manager is already consistent. Recovery is not needed."
        },
        [6822] = {
            id = "ERROR_RM_ALREADY_STARTED",
            description = "The transactional resource manager has already been started."
        },
        [6823] = {
            id = "ERROR_FILE_IDENTITY_NOT_PERSISTENT",
            description = "The file cannot be opened transactionally, because its identity depends on the outcome of an unresolved transaction."
        },
        [6824] = {
            id = "ERROR_CANT_BREAK_TRANSACTIONAL_DEPENDENCY",
            description = "The operation cannot be performed because another transaction is depending on the fact that this property will not change."
        },
        [6825] = {
            id = "ERROR_CANT_CROSS_RM_BOUNDARY",
            description = "The operation would involve a single file with two transactional resource managers and is therefore not allowed."
        },
        [6826] = {
            id = "ERROR_TXF_DIR_NOT_EMPTY",
            description = "The $Txf directory must be empty for this operation to succeed."
        },
        [6827] = {
            id = "ERROR_INDOUBT_TRANSACTIONS_EXIST",
            description = "The operation would leave a transactional resource manager in an inconsistent state and is therefore not allowed."
        },
        [6828] = {
            id = "ERROR_TM_VOLATILE",
            description = "The operation could not be completed because the transaction manager does not have a log."
        },
        [6829] = {
            id = "ERROR_ROLLBACK_TIMER_EXPIRED",
            description = "A rollback could not be scheduled because a previously scheduled rollback has already executed or been queued for execution."
        },
        [6830] = {
            id = "ERROR_TXF_ATTRIBUTE_CORRUPT",
            description = "The transactional metadata attribute on the file or directory is corrupt and unreadable."
        },
        [6831] = {
            id = "ERROR_EFS_NOT_ALLOWED_IN_TRANSACTION",
            description = "The encryption operation could not be completed because a transaction is active."
        },
        [6832] = {
            id = "ERROR_TRANSACTIONAL_OPEN_NOT_ALLOWED",
            description = "This object is not allowed to be opened in a transaction."
        },
        [6833] = {
            id = "ERROR_LOG_GROWTH_FAILED",
            description = "An attempt to create space in the transactional resource manager's log failed. The failure status has been recorded in the event log."
        },
        [6834] = {
            id = "ERROR_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE",
            description = "Memory mapping (creating a mapped section) a remote file under a transaction is not supported."
        },
        [6835] = {
            id = "ERROR_TXF_METADATA_ALREADY_PRESENT",
            description = "Transaction metadata is already present on this file and cannot be superseded."
        },
        [6836] = {
            id = "ERROR_TRANSACTION_SCOPE_CALLBACKS_NOT_SET",
            description = "A transaction scope could not be entered because the scope handler has not been initialized."
        },
        [6837] = {
            id = "ERROR_TRANSACTION_REQUIRED_PROMOTION",
            description = "Promotion was required in order to allow the resource manager to enlist, but the transaction was set to disallow it."
        },
        [6838] = {
            id = "ERROR_CANNOT_EXECUTE_FILE_IN_TRANSACTION",
            description = "This file is open for modification in an unresolved transaction and may be opened for execute only by a transacted reader."
        },
        [6839] = {
            id = "ERROR_TRANSACTIONS_NOT_FROZEN",
            description = "The request to thaw frozen transactions was ignored because transactions had not previously been frozen."
        },
        [6840] = {
            id = "ERROR_TRANSACTION_FREEZE_IN_PROGRESS",
            description = "Transactions cannot be frozen because a freeze is already in progress."
        },
        [6841] = {
            id = "ERROR_NOT_SNAPSHOT_VOLUME",
            description = "The target volume is not a snapshot volume. This operation is only valid on a volume mounted as a snapshot."
        },
        [6842] = {
            id = "ERROR_NO_SAVEPOINT_WITH_OPEN_FILES",
            description = "The savepoint operation failed because files are open on the transaction. This is not permitted."
        },
        [6843] = {
            id = "ERROR_DATA_LOST_REPAIR",
            description = "Windows has discovered corruption in a file, and that file has since been repaired. Data loss may have occurred."
        },
        [6844] = {
            id = "ERROR_SPARSE_NOT_ALLOWED_IN_TRANSACTION",
            description = "The sparse operation could not be completed because a transaction is active on the file."
        },
        [6845] = {
            id = "ERROR_TM_IDENTITY_MISMATCH",
            description = "The call to create a TransactionManager object failed because the Tm Identity stored in the logfile does not match the Tm Identity that was passed in as an argument."
        },
        [6846] = {
            id = "ERROR_FLOATED_SECTION",
            description = "I/O was attempted on a section object that has been floated as a result of a transaction ending. There is no valid data."
        },
        [6847] = {
            id = "ERROR_CANNOT_ACCEPT_TRANSACTED_WORK",
            description = "The transactional resource manager cannot currently accept transacted work due to a transient condition such as low resources."
        },
        [6848] = {
            id = "ERROR_CANNOT_ABORT_TRANSACTIONS",
            description = "The transactional resource manager had too many tranactions outstanding that could not be aborted. The transactional resource manger has been shut down."
        },
        [6849] = {
            id = "ERROR_BAD_CLUSTERS",
            description = "The operation could not be completed due to bad clusters on disk."
        },
        [6850] = {
            id = "ERROR_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION",
            description = "The compression operation could not be completed because a transaction is active on the file."
        },
        [6851] = {
            id = "ERROR_VOLUME_DIRTY",
            description = "The operation could not be completed because the volume is dirty. Please run chkdsk and try again."
        },
        [6852] = {
            id = "ERROR_NO_LINK_TRACKING_IN_TRANSACTION",
            description = "The link tracking operation could not be completed because a transaction is active."
        },
        [6853] = {
            id = "ERROR_OPERATION_NOT_SUPPORTED_IN_TRANSACTION",
            description = "This operation cannot be performed in a transaction."
        },
        [6854] = {
            id = "ERROR_EXPIRED_HANDLE",
            description = "The handle is no longer properly associated with its transaction. It may have been opened in a transactional resource manager that was subsequently forced to restart. Please close the handle and open a new one."
        },
        [6855] = {
            id = "ERROR_TRANSACTION_NOT_ENLISTED",
            description = "The specified operation could not be performed because the resource manager is not enlisted in the transaction."
        },
        [7001] = {
            id = "ERROR_CTX_WINSTATION_NAME_INVALID",
            description = "The specified session name is invalid."
        },
        [7002] = {
            id = "ERROR_CTX_INVALID_PD",
            description = "The specified protocol driver is invalid."
        },
        [7003] = {
            id = "ERROR_CTX_PD_NOT_FOUND",
            description = "The specified protocol driver was not found in the system path."
        },
        [7004] = {
            id = "ERROR_CTX_WD_NOT_FOUND",
            description = "The specified terminal connection driver was not found in the system path."
        },
        [7005] = {
            id = "ERROR_CTX_CANNOT_MAKE_EVENTLOG_ENTRY",
            description = "A registry key for event logging could not be created for this session."
        },
        [7006] = {
            id = "ERROR_CTX_SERVICE_NAME_COLLISION",
            description = "A service with the same name already exists on the system."
        },
        [7007] = {
            id = "ERROR_CTX_CLOSE_PENDING",
            description = "A close operation is pending on the session."
        },
        [7008] = {
            id = "ERROR_CTX_NO_OUTBUF",
            description = "There are no free output buffers available."
        },
        [7009] = {
            id = "ERROR_CTX_MODEM_INF_NOT_FOUND",
            description = "The MODEM.INF file was not found."
        },
        [7010] = {
            id = "ERROR_CTX_INVALID_MODEMNAME",
            description = "The modem name was not found in MODEM.INF."
        },
        [7011] = {
            id = "ERROR_CTX_MODEM_RESPONSE_ERROR",
            description = "The modem did not accept the command sent to it. Verify that the configured modem name matches the attached modem."
        },
        [7012] = {
            id = "ERROR_CTX_MODEM_RESPONSE_TIMEOUT",
            description = "The modem did not respond to the command sent to it. Verify that the modem is properly cabled and powered on."
        },
        [7013] = {
            id = "ERROR_CTX_MODEM_RESPONSE_NO_CARRIER",
            description = "Carrier detect has failed or carrier has been dropped due to disconnect."
        },
        [7014] = {
            id = "ERROR_CTX_MODEM_RESPONSE_NO_DIALTONE",
            description = "Dial tone not detected within the required time. Verify that the phone cable is properly attached and functional."
        },
        [7015] = {
            id = "ERROR_CTX_MODEM_RESPONSE_BUSY",
            description = "Busy signal detected at remote site on callback."
        },
        [7016] = {
            id = "ERROR_CTX_MODEM_RESPONSE_VOICE",
            description = "Voice detected at remote site on callback."
        },
        [7017] = {
            id = "ERROR_CTX_TD_ERROR",
            description = "Transport driver error."
        },
        [7022] = {
            id = "ERROR_CTX_WINSTATION_NOT_FOUND",
            description = "The specified session cannot be found."
        },
        [7023] = {
            id = "ERROR_CTX_WINSTATION_ALREADY_EXISTS",
            description = "The specified session name is already in use."
        },
        [7024] = {
            id = "ERROR_CTX_WINSTATION_BUSY",
            description = "The task you are trying to do can't be completed because Remote Desktop Services is currently busy. Please try again in a few minutes. Other users should still be able to log on."
        },
        [7025] = {
            id = "ERROR_CTX_BAD_VIDEO_MODE",
            description = "An attempt has been made to connect to a session whose video mode is not supported by the current client."
        },
        [7035] = {
            id = "ERROR_CTX_GRAPHICS_INVALID",
            description = "The application attempted to enable DOS graphics mode. DOS graphics mode is not supported."
        },
        [7037] = {
            id = "ERROR_CTX_LOGON_DISABLED",
            description = "Your interactive logon privilege has been disabled. Please contact your administrator."
        },
        [7038] = {
            id = "ERROR_CTX_NOT_CONSOLE",
            description = "The requested operation can be performed only on the system console. This is most often the result of a driver or system DLL requiring direct console access."
        },
        [7040] = {
            id = "ERROR_CTX_CLIENT_QUERY_TIMEOUT",
            description = "The client failed to respond to the server connect message."
        },
        [7041] = {
            id = "ERROR_CTX_CONSOLE_DISCONNECT",
            description = "Disconnecting the console session is not supported."
        },
        [7042] = {
            id = "ERROR_CTX_CONSOLE_CONNECT",
            description = "Reconnecting a disconnected session to the console is not supported."
        },
        [7044] = {
            id = "ERROR_CTX_SHADOW_DENIED",
            description = "The request to control another session remotely was denied."
        },
        [7045] = {
            id = "ERROR_CTX_WINSTATION_ACCESS_DENIED",
            description = "The requested session access is denied."
        },
        [7049] = {
            id = "ERROR_CTX_INVALID_WD",
            description = "The specified terminal connection driver is invalid."
        },
        [7050] = {
            id = "ERROR_CTX_SHADOW_INVALID",
            description = "The requested session cannot be controlled remotely. This may be because the session is disconnected or does not currently have a user logged on."
        },
        [7051] = {
            id = "ERROR_CTX_SHADOW_DISABLED",
            description = "The requested session is not configured to allow remote control."
        },
        [7052] = {
            id = "ERROR_CTX_CLIENT_LICENSE_IN_USE",
            description = "Your request to connect to this Terminal Server has been rejected. Your Terminal Server client license number is currently being used by another user. Please call your system administrator to obtain a unique license number."
        },
        [7053] = {
            id = "ERROR_CTX_CLIENT_LICENSE_NOT_SET",
            description = "Your request to connect to this Terminal Server has been rejected. Your Terminal Server client license number has not been entered for this copy of the Terminal Server client. Please contact your system administrator."
        },
        [7054] = {
            id = "ERROR_CTX_LICENSE_NOT_AVAILABLE",
            description = "The number of connections to this computer is limited and all connections are in use right now. Try connecting later or contact your system administrator."
        },
        [7055] = {
            id = "ERROR_CTX_LICENSE_CLIENT_INVALID",
            description = "The client you are using is not licensed to use this system. Your logon request is denied."
        },
        [7056] = {
            id = "ERROR_CTX_LICENSE_EXPIRED",
            description = "The system license has expired. Your logon request is denied."
        },
        [7057] = {
            id = "ERROR_CTX_SHADOW_NOT_RUNNING",
            description = "Remote control could not be terminated because the specified session is not currently being remotely controlled."
        },
        [7058] = {
            id = "ERROR_CTX_SHADOW_ENDED_BY_MODE_CHANGE",
            description = "The remote control of the console was terminated because the display mode was changed. Changing the display mode in a remote control session is not supported."
        },
        [7059] = {
            id = "ERROR_ACTIVATION_COUNT_EXCEEDED",
            description = "Activation has already been reset the maximum number of times for this installation. Your activation timer will not be cleared."
        },
        [7060] = {
            id = "ERROR_CTX_WINSTATIONS_DISABLED",
            description = "Remote logins are currently disabled."
        },
        [7061] = {
            id = "ERROR_CTX_ENCRYPTION_LEVEL_REQUIRED",
            description = "You do not have the proper encryption level to access this Session."
        },
        [7062] = {
            id = "ERROR_CTX_SESSION_IN_USE",
            description = "The user %s\\%s is currently logged on to this computer. Only the current user or an administrator can log on to this computer."
        },
        [7063] = {
            id = "ERROR_CTX_NO_FORCE_LOGOFF",
            description = "The user %s\\%s is already logged on to the console of this computer. You do not have permission to log in at this time. To resolve this issue, contact %s\\%s and have them log off."
        },
        [7064] = {
            id = "ERROR_CTX_ACCOUNT_RESTRICTION",
            description = "Unable to log you on because of an account restriction."
        },
        [7065] = {
            id = "ERROR_RDP_PROTOCOL_ERROR",
            description = "The RDP protocol component %2 detected an error in the protocol stream and has disconnected the client."
        },
        [7066] = {
            id = "ERROR_CTX_CDM_CONNECT",
            description = "The Client Drive Mapping Service Has Connected on Terminal Connection."
        },
        [7067] = {
            id = "ERROR_CTX_CDM_DISCONNECT",
            description = "The Client Drive Mapping Service Has Disconnected on Terminal Connection."
        },
        [7068] = {
            id = "ERROR_CTX_SECURITY_LAYER_ERROR",
            description = "The Terminal Server security layer detected an error in the protocol stream and has disconnected the client."
        },
        [7069] = {
            id = "ERROR_TS_INCOMPATIBLE_SESSIONS",
            description = "The target session is incompatible with the current session."
        },
        [7070] = {
            id = "ERROR_TS_VIDEO_SUBSYSTEM_ERROR",
            description = "Windows can't connect to your session because a problem occurred in the Windows video subsystem. Try connecting again later, or contact the server administrator for assistance."
        },
        [8001] = {
            id = "FRS_ERR_INVALID_API_SEQUENCE",
            description = "The file replication service API was called incorrectly."
        },
        [8002] = {
            id = "FRS_ERR_STARTING_SERVICE",
            description = "The file replication service cannot be started."
        },
        [8003] = {
            id = "FRS_ERR_STOPPING_SERVICE",
            description = "The file replication service cannot be stopped."
        },
        [8004] = {
            id = "FRS_ERR_INTERNAL_API",
            description = "The file replication service API terminated the request. The event log may have more information."
        },
        [8005] = {
            id = "FRS_ERR_INTERNAL",
            description = "The file replication service terminated the request. The event log may have more information."
        },
        [8006] = {
            id = "FRS_ERR_SERVICE_COMM",
            description = "The file replication service cannot be contacted. The event log may have more information."
        },
        [8007] = {
            id = "FRS_ERR_INSUFFICIENT_PRIV",
            description = "The file replication service cannot satisfy the request because the user has insufficient privileges. The event log may have more information."
        },
        [8008] = {
            id = "FRS_ERR_AUTHENTICATION",
            description = "The file replication service cannot satisfy the request because authenticated RPC is not available. The event log may have more information."
        },
        [8009] = {
            id = "FRS_ERR_PARENT_INSUFFICIENT_PRIV",
            description = "The file replication service cannot satisfy the request because the user has insufficient privileges on the domain controller. The event log may have more information."
        },
        [8010] = {
            id = "FRS_ERR_PARENT_AUTHENTICATION",
            description = "The file replication service cannot satisfy the request because authenticated RPC is not available on the domain controller. The event log may have more information."
        },
        [8011] = {
            id = "FRS_ERR_CHILD_TO_PARENT_COMM",
            description = "The file replication service cannot communicate with the file replication service on the domain controller. The event log may have more information."
        },
        [8012] = {
            id = "FRS_ERR_PARENT_TO_CHILD_COMM",
            description = "The file replication service on the domain controller cannot communicate with the file replication service on this computer. The event log may have more information."
        },
        [8013] = {
            id = "FRS_ERR_SYSVOL_POPULATE",
            description = "The file replication service cannot populate the system volume because of an internal error. The event log may have more information."
        },
        [8014] = {
            id = "FRS_ERR_SYSVOL_POPULATE_TIMEOUT",
            description = "The file replication service cannot populate the system volume because of an internal timeout. The event log may have more information."
        },
        [8015] = {
            id = "FRS_ERR_SYSVOL_IS_BUSY",
            description = "The file replication service cannot process the request. The system volume is busy with a previous request."
        },
        [8016] = {
            id = "FRS_ERR_SYSVOL_DEMOTE",
            description = "The file replication service cannot stop replicating the system volume because of an internal error. The event log may have more information."
        },
        [8017] = {
            id = "FRS_ERR_INVALID_SERVICE_PARAMETER",
            description = "The file replication service detected an invalid parameter."
        },
        [8200] = {
            id = "ERROR_DS_NOT_INSTALLED",
            description = "An error occurred while installing the directory service. For more information, see the event log."
        },
        [8201] = {
            id = "ERROR_DS_MEMBERSHIP_EVALUATED_LOCALLY",
            description = "The directory service evaluated group memberships locally."
        },
        [8202] = {
            id = "ERROR_DS_NO_ATTRIBUTE_OR_VALUE",
            description = "The specified directory service attribute or value does not exist."
        },
        [8203] = {
            id = "ERROR_DS_INVALID_ATTRIBUTE_SYNTAX",
            description = "The attribute syntax specified to the directory service is invalid."
        },
        [8204] = {
            id = "ERROR_DS_ATTRIBUTE_TYPE_UNDEFINED",
            description = "The attribute type specified to the directory service is not defined."
        },
        [8205] = {
            id = "ERROR_DS_ATTRIBUTE_OR_VALUE_EXISTS",
            description = "The specified directory service attribute or value already exists."
        },
        [8206] = {
            id = "ERROR_DS_BUSY",
            description = "The directory service is busy."
        },
        [8207] = {
            id = "ERROR_DS_UNAVAILABLE",
            description = "The directory service is unavailable."
        },
        [8208] = {
            id = "ERROR_DS_NO_RIDS_ALLOCATED",
            description = "The directory service was unable to allocate a relative identifier."
        },
        [8209] = {
            id = "ERROR_DS_NO_MORE_RIDS",
            description = "The directory service has exhausted the pool of relative identifiers."
        },
        [8210] = {
            id = "ERROR_DS_INCORRECT_ROLE_OWNER",
            description = "The requested operation could not be performed because the directory service is not the master for that type of operation."
        },
        [8211] = {
            id = "ERROR_DS_RIDMGR_INIT_ERROR",
            description = "The directory service was unable to initialize the subsystem that allocates relative identifiers."
        },
        [8212] = {
            id = "ERROR_DS_OBJ_CLASS_VIOLATION",
            description = "The requested operation did not satisfy one or more constraints associated with the class of the object."
        },
        [8213] = {
            id = "ERROR_DS_CANT_ON_NON_LEAF",
            description = "The directory service can perform the requested operation only on a leaf object."
        },
        [8214] = {
            id = "ERROR_DS_CANT_ON_RDN",
            description = "The directory service cannot perform the requested operation on the RDN attribute of an object."
        },
        [8215] = {
            id = "ERROR_DS_CANT_MOD_OBJ_CLASS",
            description = "The directory service detected an attempt to modify the object class of an object."
        },
        [8216] = {
            id = "ERROR_DS_CROSS_DOM_MOVE_ERROR",
            description = "The requested cross-domain move operation could not be performed."
        },
        [8217] = {
            id = "ERROR_DS_GC_NOT_AVAILABLE",
            description = "Unable to contact the global catalog server."
        },
        [8218] = {
            id = "ERROR_SHARED_POLICY",
            description = "The policy object is shared and can only be modified at the root."
        },
        [8219] = {
            id = "ERROR_POLICY_OBJECT_NOT_FOUND",
            description = "The policy object does not exist."
        },
        [8220] = {
            id = "ERROR_POLICY_ONLY_IN_DS",
            description = "The requested policy information is only in the directory service."
        },
        [8221] = {
            id = "ERROR_PROMOTION_ACTIVE",
            description = "A domain controller promotion is currently active."
        },
        [8222] = {
            id = "ERROR_NO_PROMOTION_ACTIVE",
            description = "A domain controller promotion is not currently active."
        },
        [8224] = {
            id = "ERROR_DS_OPERATIONS_ERROR",
            description = "An operations error occurred."
        },
        [8225] = {
            id = "ERROR_DS_PROTOCOL_ERROR",
            description = "A protocol error occurred."
        },
        [8226] = {
            id = "ERROR_DS_TIMELIMIT_EXCEEDED",
            description = "The time limit for this request was exceeded."
        },
        [8227] = {
            id = "ERROR_DS_SIZELIMIT_EXCEEDED",
            description = "The size limit for this request was exceeded."
        },
        [8228] = {
            id = "ERROR_DS_ADMIN_LIMIT_EXCEEDED",
            description = "The administrative limit for this request was exceeded."
        },
        [8229] = {
            id = "ERROR_DS_COMPARE_FALSE",
            description = "The compare response was false."
        },
        [8230] = {
            id = "ERROR_DS_COMPARE_TRUE",
            description = "The compare response was true."
        },
        [8231] = {
            id = "ERROR_DS_AUTH_METHOD_NOT_SUPPORTED",
            description = "The requested authentication method is not supported by the server."
        },
        [8232] = {
            id = "ERROR_DS_STRONG_AUTH_REQUIRED",
            description = "A more secure authentication method is required for this server."
        },
        [8233] = {
            id = "ERROR_DS_INAPPROPRIATE_AUTH",
            description = "Inappropriate authentication."
        },
        [8234] = {
            id = "ERROR_DS_AUTH_UNKNOWN",
            description = "The authentication mechanism is unknown."
        },
        [8235] = {
            id = "ERROR_DS_REFERRAL",
            description = "A referral was returned from the server."
        },
        [8236] = {
            id = "ERROR_DS_UNAVAILABLE_CRIT_EXTENSION",
            description = "The server does not support the requested critical extension."
        },
        [8237] = {
            id = "ERROR_DS_CONFIDENTIALITY_REQUIRED",
            description = "This request requires a secure connection."
        },
        [8238] = {
            id = "ERROR_DS_INAPPROPRIATE_MATCHING",
            description = "Inappropriate matching."
        },
        [8239] = {
            id = "ERROR_DS_CONSTRAINT_VIOLATION",
            description = "A constraint violation occurred."
        },
        [8240] = {
            id = "ERROR_DS_NO_SUCH_OBJECT",
            description = "There is no such object on the server."
        },
        [8241] = {
            id = "ERROR_DS_ALIAS_PROBLEM",
            description = "There is an alias problem."
        },
        [8242] = {
            id = "ERROR_DS_INVALID_DN_SYNTAX",
            description = "An invalid dn syntax has been specified."
        },
        [8243] = {
            id = "ERROR_DS_IS_LEAF",
            description = "The object is a leaf object."
        },
        [8244] = {
            id = "ERROR_DS_ALIAS_DEREF_PROBLEM",
            description = "There is an alias dereferencing problem."
        },
        [8245] = {
            id = "ERROR_DS_UNWILLING_TO_PERFORM",
            description = "The server is unwilling to process the request."
        },
        [8246] = {
            id = "ERROR_DS_LOOP_DETECT",
            description = "A loop has been detected."
        },
        [8247] = {
            id = "ERROR_DS_NAMING_VIOLATION",
            description = "There is a naming violation."
        },
        [8248] = {
            id = "ERROR_DS_OBJECT_RESULTS_TOO_LARGE",
            description = "The result set is too large."
        },
        [8249] = {
            id = "ERROR_DS_AFFECTS_MULTIPLE_DSAS",
            description = "The operation affects multiple DSAs."
        },
        [8250] = {
            id = "ERROR_DS_SERVER_DOWN",
            description = "The server is not operational."
        },
        [8251] = {
            id = "ERROR_DS_LOCAL_ERROR",
            description = "A local error has occurred."
        },
        [8252] = {
            id = "ERROR_DS_ENCODING_ERROR",
            description = "An encoding error has occurred."
        },
        [8253] = {
            id = "ERROR_DS_DECODING_ERROR",
            description = "A decoding error has occurred."
        },
        [8254] = {
            id = "ERROR_DS_FILTER_UNKNOWN",
            description = "The search filter cannot be recognized."
        },
        [8255] = {
            id = "ERROR_DS_PARAM_ERROR",
            description = "One or more parameters are illegal."
        },
        [8256] = {
            id = "ERROR_DS_NOT_SUPPORTED",
            description = "The specified method is not supported."
        },
        [8257] = {
            id = "ERROR_DS_NO_RESULTS_RETURNED",
            description = "No results were returned."
        },
        [8258] = {
            id = "ERROR_DS_CONTROL_NOT_FOUND",
            description = "The specified control is not supported by the server."
        },
        [8259] = {
            id = "ERROR_DS_CLIENT_LOOP",
            description = "A referral loop was detected by the client."
        },
        [8260] = {
            id = "ERROR_DS_REFERRAL_LIMIT_EXCEEDED",
            description = "The preset referral limit was exceeded."
        },
        [8261] = {
            id = "ERROR_DS_SORT_CONTROL_MISSING",
            description = "The search requires a SORT control."
        },
        [8262] = {
            id = "ERROR_DS_OFFSET_RANGE_ERROR",
            description = "The search results exceed the offset range specified."
        },
        [8263] = {
            id = "ERROR_DS_RIDMGR_DISABLED",
            description = "The directory service detected the subsystem that allocates relative identifiers is disabled. This can occur as a protective mechanism when the system determines a significant portion of relative identifiers (RIDs) have been exhausted. Please see http://go.microsoft.com/fwlink/p/?linkid=228610 for recommended diagnostic steps and the procedure to re-enable account creation."
        },
        [8301] = {
            id = "ERROR_DS_ROOT_MUST_BE_NC",
            description = "The root object must be the head of a naming context. The root object cannot have an instantiated parent."
        },
        [8302] = {
            id = "ERROR_DS_ADD_REPLICA_INHIBITED",
            description = "The add replica operation cannot be performed. The naming context must be writeable in order to create the replica."
        },
        [8303] = {
            id = "ERROR_DS_ATT_NOT_DEF_IN_SCHEMA",
            description = "A reference to an attribute that is not defined in the schema occurred."
        },
        [8304] = {
            id = "ERROR_DS_MAX_OBJ_SIZE_EXCEEDED",
            description = "The maximum size of an object has been exceeded."
        },
        [8305] = {
            id = "ERROR_DS_OBJ_STRING_NAME_EXISTS",
            description = "An attempt was made to add an object to the directory with a name that is already in use."
        },
        [8306] = {
            id = "ERROR_DS_NO_RDN_DEFINED_IN_SCHEMA",
            description = "An attempt was made to add an object of a class that does not have an RDN defined in the schema."
        },
        [8307] = {
            id = "ERROR_DS_RDN_DOESNT_MATCH_SCHEMA",
            description = "An attempt was made to add an object using an RDN that is not the RDN defined in the schema."
        },
        [8308] = {
            id = "ERROR_DS_NO_REQUESTED_ATTS_FOUND",
            description = "None of the requested attributes were found on the objects."
        },
        [8309] = {
            id = "ERROR_DS_USER_BUFFER_TO_SMALL",
            description = "The user buffer is too small."
        },
        [8310] = {
            id = "ERROR_DS_ATT_IS_NOT_ON_OBJ",
            description = "The attribute specified in the operation is not present on the object."
        },
        [8311] = {
            id = "ERROR_DS_ILLEGAL_MOD_OPERATION",
            description = "Illegal modify operation. Some aspect of the modification is not permitted."
        },
        [8312] = {
            id = "ERROR_DS_OBJ_TOO_LARGE",
            description = "The specified object is too large."
        },
        [8313] = {
            id = "ERROR_DS_BAD_INSTANCE_TYPE",
            description = "The specified instance type is not valid."
        },
        [8314] = {
            id = "ERROR_DS_MASTERDSA_REQUIRED",
            description = "The operation must be performed at a master DSA."
        },
        [8315] = {
            id = "ERROR_DS_OBJECT_CLASS_REQUIRED",
            description = "The object class attribute must be specified."
        },
        [8316] = {
            id = "ERROR_DS_MISSING_REQUIRED_ATT",
            description = "A required attribute is missing."
        },
        [8317] = {
            id = "ERROR_DS_ATT_NOT_DEF_FOR_CLASS",
            description = "An attempt was made to modify an object to include an attribute that is not legal for its class."
        },
        [8318] = {
            id = "ERROR_DS_ATT_ALREADY_EXISTS",
            description = "The specified attribute is already present on the object."
        },
        [8320] = {
            id = "ERROR_DS_CANT_ADD_ATT_VALUES",
            description = "The specified attribute is not present, or has no values."
        },
        [8321] = {
            id = "ERROR_DS_SINGLE_VALUE_CONSTRAINT",
            description = "Multiple values were specified for an attribute that can have only one value."
        },
        [8322] = {
            id = "ERROR_DS_RANGE_CONSTRAINT",
            description = "A value for the attribute was not in the acceptable range of values."
        },
        [8323] = {
            id = "ERROR_DS_ATT_VAL_ALREADY_EXISTS",
            description = "The specified value already exists."
        },
        [8324] = {
            id = "ERROR_DS_CANT_REM_MISSING_ATT",
            description = "The attribute cannot be removed because it is not present on the object."
        },
        [8325] = {
            id = "ERROR_DS_CANT_REM_MISSING_ATT_VAL",
            description = "The attribute value cannot be removed because it is not present on the object."
        },
        [8326] = {
            id = "ERROR_DS_ROOT_CANT_BE_SUBREF",
            description = "The specified root object cannot be a subref."
        },
        [8327] = {
            id = "ERROR_DS_NO_CHAINING",
            description = "Chaining is not permitted."
        },
        [8328] = {
            id = "ERROR_DS_NO_CHAINED_EVAL",
            description = "Chained evaluation is not permitted."
        },
        [8329] = {
            id = "ERROR_DS_NO_PARENT_OBJECT",
            description = "The operation could not be performed because the object's parent is either uninstantiated or deleted."
        },
        [8330] = {
            id = "ERROR_DS_PARENT_IS_AN_ALIAS",
            description = "Having a parent that is an alias is not permitted. Aliases are leaf objects."
        },
        [8331] = {
            id = "ERROR_DS_CANT_MIX_MASTER_AND_REPS",
            description = "The object and parent must be of the same type, either both masters or both replicas."
        },
        [8332] = {
            id = "ERROR_DS_CHILDREN_EXIST",
            description = "The operation cannot be performed because child objects exist. This operation can only be performed on a leaf object."
        },
        [8333] = {
            id = "ERROR_DS_OBJ_NOT_FOUND",
            description = "Directory object not found."
        },
        [8334] = {
            id = "ERROR_DS_ALIASED_OBJ_MISSING",
            description = "The aliased object is missing."
        },
        [8335] = {
            id = "ERROR_DS_BAD_NAME_SYNTAX",
            description = "The object name has bad syntax."
        },
        [8336] = {
            id = "ERROR_DS_ALIAS_POINTS_TO_ALIAS",
            description = "It is not permitted for an alias to refer to another alias."
        },
        [8337] = {
            id = "ERROR_DS_CANT_DEREF_ALIAS",
            description = "The alias cannot be dereferenced."
        },
        [8338] = {
            id = "ERROR_DS_OUT_OF_SCOPE",
            description = "The operation is out of scope."
        },
        [8339] = {
            id = "ERROR_DS_OBJECT_BEING_REMOVED",
            description = "The operation cannot continue because the object is in the process of being removed."
        },
        [8340] = {
            id = "ERROR_DS_CANT_DELETE_DSA_OBJ",
            description = "The DSA object cannot be deleted."
        },
        [8341] = {
            id = "ERROR_DS_GENERIC_ERROR",
            description = "A directory service error has occurred."
        },
        [8342] = {
            id = "ERROR_DS_DSA_MUST_BE_INT_MASTER",
            description = "The operation can only be performed on an internal master DSA object."
        },
        [8343] = {
            id = "ERROR_DS_CLASS_NOT_DSA",
            description = "The object must be of class DSA."
        },
        [8344] = {
            id = "ERROR_DS_INSUFF_ACCESS_RIGHTS",
            description = "Insufficient access rights to perform the operation."
        },
        [8345] = {
            id = "ERROR_DS_ILLEGAL_SUPERIOR",
            description = "The object cannot be added because the parent is not on the list of possible superiors."
        },
        [8346] = {
            id = "ERROR_DS_ATTRIBUTE_OWNED_BY_SAM",
            description = "Access to the attribute is not permitted because the attribute is owned by the Security Accounts Manager (SAM)."
        },
        [8347] = {
            id = "ERROR_DS_NAME_TOO_MANY_PARTS",
            description = "The name has too many parts."
        },
        [8348] = {
            id = "ERROR_DS_NAME_TOO_LONG",
            description = "The name is too long."
        },
        [8349] = {
            id = "ERROR_DS_NAME_VALUE_TOO_LONG",
            description = "The name value is too long."
        },
        [8350] = {
            id = "ERROR_DS_NAME_UNPARSEABLE",
            description = "The directory service encountered an error parsing a name."
        },
        [8351] = {
            id = "ERROR_DS_NAME_TYPE_UNKNOWN",
            description = "The directory service cannot get the attribute type for a name."
        },
        [8352] = {
            id = "ERROR_DS_NOT_AN_OBJECT",
            description = "The name does not identify an object; the name identifies a phantom."
        },
        [8353] = {
            id = "ERROR_DS_SEC_DESC_TOO_SHORT",
            description = "The security descriptor is too short."
        },
        [8354] = {
            id = "ERROR_DS_SEC_DESC_INVALID",
            description = "The security descriptor is invalid."
        },
        [8355] = {
            id = "ERROR_DS_NO_DELETED_NAME",
            description = "Failed to create name for deleted object."
        },
        [8356] = {
            id = "ERROR_DS_SUBREF_MUST_HAVE_PARENT",
            description = "The parent of a new subref must exist."
        },
        [8357] = {
            id = "ERROR_DS_NCNAME_MUST_BE_NC",
            description = "The object must be a naming context."
        },
        [8358] = {
            id = "ERROR_DS_CANT_ADD_SYSTEM_ONLY",
            description = "It is not permitted to add an attribute which is owned by the system."
        },
        [8359] = {
            id = "ERROR_DS_CLASS_MUST_BE_CONCRETE",
            description = "The class of the object must be structural; you cannot instantiate an abstract class."
        },
        [8360] = {
            id = "ERROR_DS_INVALID_DMD",
            description = "The schema object could not be found."
        },
        [8361] = {
            id = "ERROR_DS_OBJ_GUID_EXISTS",
            description = "A local object with this GUID (dead or alive) already exists."
        },
        [8362] = {
            id = "ERROR_DS_NOT_ON_BACKLINK",
            description = "The operation cannot be performed on a back link."
        },
        [8363] = {
            id = "ERROR_DS_NO_CROSSREF_FOR_NC",
            description = "The cross reference for the specified naming context could not be found."
        },
        [8364] = {
            id = "ERROR_DS_SHUTTING_DOWN",
            description = "The operation could not be performed because the directory service is shutting down."
        },
        [8365] = {
            id = "ERROR_DS_UNKNOWN_OPERATION",
            description = "The directory service request is invalid."
        },
        [8366] = {
            id = "ERROR_DS_INVALID_ROLE_OWNER",
            description = "The role owner attribute could not be read."
        },
        [8367] = {
            id = "ERROR_DS_COULDNT_CONTACT_FSMO",
            description = "The requested FSMO operation failed. The current FSMO holder could not be contacted."
        },
        [8368] = {
            id = "ERROR_DS_CROSS_NC_DN_RENAME",
            description = "Modification of a DN across a naming context is not permitted."
        },
        [8369] = {
            id = "ERROR_DS_CANT_MOD_SYSTEM_ONLY",
            description = "The attribute cannot be modified because it is owned by the system."
        },
        [8370] = {
            id = "ERROR_DS_REPLICATOR_ONLY",
            description = "Only the replicator can perform this function."
        },
        [8371] = {
            id = "ERROR_DS_OBJ_CLASS_NOT_DEFINED",
            description = "The specified class is not defined."
        },
        [8372] = {
            id = "ERROR_DS_OBJ_CLASS_NOT_SUBCLASS",
            description = "The specified class is not a subclass."
        },
        [8373] = {
            id = "ERROR_DS_NAME_REFERENCE_INVALID",
            description = "The name reference is invalid."
        },
        [8374] = {
            id = "ERROR_DS_CROSS_REF_EXISTS",
            description = "A cross reference already exists."
        },
        [8375] = {
            id = "ERROR_DS_CANT_DEL_MASTER_CROSSREF",
            description = "It is not permitted to delete a master cross reference."
        },
        [8376] = {
            id = "ERROR_DS_SUBTREE_NOTIFY_NOT_NC_HEAD",
            description = "Subtree notifications are only supported on NC heads."
        },
        [8377] = {
            id = "ERROR_DS_NOTIFY_FILTER_TOO_COMPLEX",
            description = "Notification filter is too complex."
        },
        [8378] = {
            id = "ERROR_DS_DUP_RDN",
            description = "Schema update failed: duplicate RDN."
        },
        [8379] = {
            id = "ERROR_DS_DUP_OID",
            description = "Schema update failed: duplicate OID."
        },
        [8380] = {
            id = "ERROR_DS_DUP_MAPI_ID",
            description = "Schema update failed: duplicate MAPI identifier."
        },
        [8381] = {
            id = "ERROR_DS_DUP_SCHEMA_ID_GUID",
            description = "Schema update failed: duplicate schema-id GUID."
        },
        [8382] = {
            id = "ERROR_DS_DUP_LDAP_DISPLAY_NAME",
            description = "Schema update failed: duplicate LDAP display name."
        },
        [8383] = {
            id = "ERROR_DS_SEMANTIC_ATT_TEST",
            description = "Schema update failed: range-lower less than range upper."
        },
        [8384] = {
            id = "ERROR_DS_SYNTAX_MISMATCH",
            description = "Schema update failed: syntax mismatch."
        },
        [8385] = {
            id = "ERROR_DS_EXISTS_IN_MUST_HAVE",
            description = "Schema deletion failed: attribute is used in must-contain."
        },
        [8386] = {
            id = "ERROR_DS_EXISTS_IN_MAY_HAVE",
            description = "Schema deletion failed: attribute is used in may-contain."
        },
        [8387] = {
            id = "ERROR_DS_NONEXISTENT_MAY_HAVE",
            description = "Schema update failed: attribute in may-contain does not exist."
        },
        [8388] = {
            id = "ERROR_DS_NONEXISTENT_MUST_HAVE",
            description = "Schema update failed: attribute in must-contain does not exist."
        },
        [8389] = {
            id = "ERROR_DS_AUX_CLS_TEST_FAIL",
            description = "Schema update failed: class in aux-class list does not exist or is not an auxiliary class."
        },
        [8390] = {
            id = "ERROR_DS_NONEXISTENT_POSS_SUP",
            description = "Schema update failed: class in poss-superiors does not exist."
        },
        [8391] = {
            id = "ERROR_DS_SUB_CLS_TEST_FAIL",
            description = "Schema update failed: class in subclassof list does not exist or does not satisfy hierarchy rules."
        },
        [8392] = {
            id = "ERROR_DS_BAD_RDN_ATT_ID_SYNTAX",
            description = "Schema update failed: Rdn-Att-Id has wrong syntax."
        },
        [8393] = {
            id = "ERROR_DS_EXISTS_IN_AUX_CLS",
            description = "Schema deletion failed: class is used as auxiliary class."
        },
        [8394] = {
            id = "ERROR_DS_EXISTS_IN_SUB_CLS",
            description = "Schema deletion failed: class is used as sub class."
        },
        [8395] = {
            id = "ERROR_DS_EXISTS_IN_POSS_SUP",
            description = "Schema deletion failed: class is used as poss superior."
        },
        [8396] = {
            id = "ERROR_DS_RECALCSCHEMA_FAILED",
            description = "Schema update failed in recalculating validation cache."
        },
        [8397] = {
            id = "ERROR_DS_TREE_DELETE_NOT_FINISHED",
            description = "The tree deletion is not finished. The request must be made again to continue deleting the tree."
        },
        [8398] = {
            id = "ERROR_DS_CANT_DELETE",
            description = "The requested delete operation could not be performed."
        },
        [8399] = {
            id = "ERROR_DS_ATT_SCHEMA_REQ_ID",
            description = "Cannot read the governs class identifier for the schema record."
        },
        [8400] = {
            id = "ERROR_DS_BAD_ATT_SCHEMA_SYNTAX",
            description = "The attribute schema has bad syntax."
        },
        [8401] = {
            id = "ERROR_DS_CANT_CACHE_ATT",
            description = "The attribute could not be cached."
        },
        [8402] = {
            id = "ERROR_DS_CANT_CACHE_CLASS",
            description = "The class could not be cached."
        },
        [8403] = {
            id = "ERROR_DS_CANT_REMOVE_ATT_CACHE",
            description = "The attribute could not be removed from the cache."
        },
        [8404] = {
            id = "ERROR_DS_CANT_REMOVE_CLASS_CACHE",
            description = "The class could not be removed from the cache."
        },
        [8405] = {
            id = "ERROR_DS_CANT_RETRIEVE_DN",
            description = "The distinguished name attribute could not be read."
        },
        [8406] = {
            id = "ERROR_DS_MISSING_SUPREF",
            description = "No superior reference has been configured for the directory service. The directory service is therefore unable to issue referrals to objects outside this forest."
        },
        [8407] = {
            id = "ERROR_DS_CANT_RETRIEVE_INSTANCE",
            description = "The instance type attribute could not be retrieved."
        },
        [8408] = {
            id = "ERROR_DS_CODE_INCONSISTENCY",
            description = "An internal error has occurred."
        },
        [8409] = {
            id = "ERROR_DS_DATABASE_ERROR",
            description = "A database error has occurred."
        },
        [8410] = {
            id = "ERROR_DS_GOVERNSID_MISSING",
            description = "The attribute GOVERNSID is missing."
        },
        [8411] = {
            id = "ERROR_DS_MISSING_EXPECTED_ATT",
            description = "An expected attribute is missing."
        },
        [8412] = {
            id = "ERROR_DS_NCNAME_MISSING_CR_REF",
            description = "The specified naming context is missing a cross reference."
        },
        [8413] = {
            id = "ERROR_DS_SECURITY_CHECKING_ERROR",
            description = "A security checking error has occurred."
        },
        [8414] = {
            id = "ERROR_DS_SCHEMA_NOT_LOADED",
            description = "The schema is not loaded."
        },
        [8415] = {
            id = "ERROR_DS_SCHEMA_ALLOC_FAILED",
            description = "Schema allocation failed. Please check if the machine is running low on memory."
        },
        [8416] = {
            id = "ERROR_DS_ATT_SCHEMA_REQ_SYNTAX",
            description = "Failed to obtain the required syntax for the attribute schema."
        },
        [8417] = {
            id = "ERROR_DS_GCVERIFY_ERROR",
            description = "The global catalog verification failed. The global catalog is not available or does not support the operation. Some part of the directory is currently not available."
        },
        [8418] = {
            id = "ERROR_DS_DRA_SCHEMA_MISMATCH",
            description = "The replication operation failed because of a schema mismatch between the servers involved."
        },
        [8419] = {
            id = "ERROR_DS_CANT_FIND_DSA_OBJ",
            description = "The DSA object could not be found."
        },
        [8420] = {
            id = "ERROR_DS_CANT_FIND_EXPECTED_NC",
            description = "The naming context could not be found."
        },
        [8421] = {
            id = "ERROR_DS_CANT_FIND_NC_IN_CACHE",
            description = "The naming context could not be found in the cache."
        },
        [8422] = {
            id = "ERROR_DS_CANT_RETRIEVE_CHILD",
            description = "The child object could not be retrieved."
        },
        [8423] = {
            id = "ERROR_DS_SECURITY_ILLEGAL_MODIFY",
            description = "The modification was not permitted for security reasons."
        },
        [8424] = {
            id = "ERROR_DS_CANT_REPLACE_HIDDEN_REC",
            description = "The operation cannot replace the hidden record."
        },
        [8425] = {
            id = "ERROR_DS_BAD_HIERARCHY_FILE",
            description = "The hierarchy file is invalid."
        },
        [8426] = {
            id = "ERROR_DS_BUILD_HIERARCHY_TABLE_FAILED",
            description = "The attempt to build the hierarchy table failed."
        },
        [8427] = {
            id = "ERROR_DS_CONFIG_PARAM_MISSING",
            description = "The directory configuration parameter is missing from the registry."
        },
        [8428] = {
            id = "ERROR_DS_COUNTING_AB_INDICES_FAILED",
            description = "The attempt to count the address book indices failed."
        },
        [8429] = {
            id = "ERROR_DS_HIERARCHY_TABLE_MALLOC_FAILED",
            description = "The allocation of the hierarchy table failed."
        },
        [8430] = {
            id = "ERROR_DS_INTERNAL_FAILURE",
            description = "The directory service encountered an internal failure."
        },
        [8431] = {
            id = "ERROR_DS_UNKNOWN_ERROR",
            description = "The directory service encountered an unknown failure."
        },
        [8432] = {
            id = "ERROR_DS_ROOT_REQUIRES_CLASS_TOP",
            description = "A root object requires a class of 'top'."
        },
        [8433] = {
            id = "ERROR_DS_REFUSING_FSMO_ROLES",
            description = "This directory server is shutting down, and cannot take ownership of new floating single-master operation roles."
        },
        [8434] = {
            id = "ERROR_DS_MISSING_FSMO_SETTINGS",
            description = "The directory service is missing mandatory configuration information, and is unable to determine the ownership of floating single-master operation roles."
        },
        [8435] = {
            id = "ERROR_DS_UNABLE_TO_SURRENDER_ROLES",
            description = "The directory service was unable to transfer ownership of one or more floating single-master operation roles to other servers."
        },
        [8436] = {
            id = "ERROR_DS_DRA_GENERIC",
            description = "The replication operation failed."
        },
        [8437] = {
            id = "ERROR_DS_DRA_INVALID_PARAMETER",
            description = "An invalid parameter was specified for this replication operation."
        },
        [8438] = {
            id = "ERROR_DS_DRA_BUSY",
            description = "The directory service is too busy to complete the replication operation at this time."
        },
        [8439] = {
            id = "ERROR_DS_DRA_BAD_DN",
            description = "The distinguished name specified for this replication operation is invalid."
        },
        [8440] = {
            id = "ERROR_DS_DRA_BAD_NC",
            description = "The naming context specified for this replication operation is invalid."
        },
        [8441] = {
            id = "ERROR_DS_DRA_DN_EXISTS",
            description = "The distinguished name specified for this replication operation already exists."
        },
        [8442] = {
            id = "ERROR_DS_DRA_INTERNAL_ERROR",
            description = "The replication system encountered an internal error."
        },
        [8443] = {
            id = "ERROR_DS_DRA_INCONSISTENT_DIT",
            description = "The replication operation encountered a database inconsistency."
        },
        [8444] = {
            id = "ERROR_DS_DRA_CONNECTION_FAILED",
            description = "The server specified for this replication operation could not be contacted."
        },
        [8445] = {
            id = "ERROR_DS_DRA_BAD_INSTANCE_TYPE",
            description = "The replication operation encountered an object with an invalid instance type."
        },
        [8446] = {
            id = "ERROR_DS_DRA_OUT_OF_MEM",
            description = "The replication operation failed to allocate memory."
        },
        [8447] = {
            id = "ERROR_DS_DRA_MAIL_PROBLEM",
            description = "The replication operation encountered an error with the mail system."
        },
        [8448] = {
            id = "ERROR_DS_DRA_REF_ALREADY_EXISTS",
            description = "The replication reference information for the target server already exists."
        },
        [8449] = {
            id = "ERROR_DS_DRA_REF_NOT_FOUND",
            description = "The replication reference information for the target server does not exist."
        },
        [8450] = {
            id = "ERROR_DS_DRA_OBJ_IS_REP_SOURCE",
            description = "The naming context cannot be removed because it is replicated to another server."
        },
        [8451] = {
            id = "ERROR_DS_DRA_DB_ERROR",
            description = "The replication operation encountered a database error."
        },
        [8452] = {
            id = "ERROR_DS_DRA_NO_REPLICA",
            description = "The naming context is in the process of being removed or is not replicated from the specified server."
        },
        [8453] = {
            id = "ERROR_DS_DRA_ACCESS_DENIED",
            description = "Replication access was denied."
        },
        [8454] = {
            id = "ERROR_DS_DRA_NOT_SUPPORTED",
            description = "The requested operation is not supported by this version of the directory service."
        },
        [8455] = {
            id = "ERROR_DS_DRA_RPC_CANCELLED",
            description = "The replication remote procedure call was cancelled."
        },
        [8456] = {
            id = "ERROR_DS_DRA_SOURCE_DISABLED",
            description = "The source server is currently rejecting replication requests."
        },
        [8457] = {
            id = "ERROR_DS_DRA_SINK_DISABLED",
            description = "The destination server is currently rejecting replication requests."
        },
        [8458] = {
            id = "ERROR_DS_DRA_NAME_COLLISION",
            description = "The replication operation failed due to a collision of object names."
        },
        [8459] = {
            id = "ERROR_DS_DRA_SOURCE_REINSTALLED",
            description = "The replication source has been reinstalled."
        },
        [8460] = {
            id = "ERROR_DS_DRA_MISSING_PARENT",
            description = "The replication operation failed because a required parent object is missing."
        },
        [8461] = {
            id = "ERROR_DS_DRA_PREEMPTED",
            description = "The replication operation was preempted."
        },
        [8462] = {
            id = "ERROR_DS_DRA_ABANDON_SYNC",
            description = "The replication synchronization attempt was abandoned because of a lack of updates."
        },
        [8463] = {
            id = "ERROR_DS_DRA_SHUTDOWN",
            description = "The replication operation was terminated because the system is shutting down."
        },
        [8464] = {
            id = "ERROR_DS_DRA_INCOMPATIBLE_PARTIAL_SET",
            description = "Synchronization attempt failed because the destination DC is currently waiting to synchronize new partial attributes from source. This condition is normal if a recent schema change modified the partial attribute set. The destination partial attribute set is not a subset of source partial attribute set."
        },
        [8465] = {
            id = "ERROR_DS_DRA_SOURCE_IS_PARTIAL_REPLICA",
            description = "The replication synchronization attempt failed because a master replica attempted to sync from a partial replica."
        },
        [8466] = {
            id = "ERROR_DS_DRA_EXTN_CONNECTION_FAILED",
            description = "The server specified for this replication operation was contacted, but that server was unable to contact an additional server needed to complete the operation."
        },
        [8467] = {
            id = "ERROR_DS_INSTALL_SCHEMA_MISMATCH",
            description = "The version of the directory service schema of the source forest is not compatible with the version of directory service on this computer."
        },
        [8468] = {
            id = "ERROR_DS_DUP_LINK_ID",
            description = "Schema update failed: An attribute with the same link identifier already exists."
        },
        [8469] = {
            id = "ERROR_DS_NAME_ERROR_RESOLVING",
            description = "Name translation: Generic processing error."
        },
        [8470] = {
            id = "ERROR_DS_NAME_ERROR_NOT_FOUND",
            description = "Name translation: Could not find the name or insufficient right to see name."
        },
        [8471] = {
            id = "ERROR_DS_NAME_ERROR_NOT_UNIQUE",
            description = "Name translation: Input name mapped to more than one output name."
        },
        [8472] = {
            id = "ERROR_DS_NAME_ERROR_NO_MAPPING",
            description = "Name translation: Input name found, but not the associated output format."
        },
        [8473] = {
            id = "ERROR_DS_NAME_ERROR_DOMAIN_ONLY",
            description = "Name translation: Unable to resolve completely, only the domain was found."
        },
        [8474] = {
            id = "ERROR_DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING",
            description = "Name translation: Unable to perform purely syntactical mapping at the client without going out to the wire."
        },
        [8475] = {
            id = "ERROR_DS_CONSTRUCTED_ATT_MOD",
            description = "Modification of a constructed attribute is not allowed."
        },
        [8476] = {
            id = "ERROR_DS_WRONG_OM_OBJ_CLASS",
            description = "The OM-Object-Class specified is incorrect for an attribute with the specified syntax."
        },
        [8477] = {
            id = "ERROR_DS_DRA_REPL_PENDING",
            description = "The replication request has been posted; waiting for reply."
        },
        [8478] = {
            id = "ERROR_DS_DS_REQUIRED",
            description = "The requested operation requires a directory service, and none was available."
        },
        [8479] = {
            id = "ERROR_DS_INVALID_LDAP_DISPLAY_NAME",
            description = "The LDAP display name of the class or attribute contains non-ASCII characters."
        },
        [8480] = {
            id = "ERROR_DS_NON_BASE_SEARCH",
            description = "The requested search operation is only supported for base searches."
        },
        [8481] = {
            id = "ERROR_DS_CANT_RETRIEVE_ATTS",
            description = "The search failed to retrieve attributes from the database."
        },
        [8482] = {
            id = "ERROR_DS_BACKLINK_WITHOUT_LINK",
            description = "The schema update operation tried to add a backward link attribute that has no corresponding forward link."
        },
        [8483] = {
            id = "ERROR_DS_EPOCH_MISMATCH",
            description = "Source and destination of a cross-domain move do not agree on the object's epoch number. Either source or destination does not have the latest version of the object."
        },
        [8484] = {
            id = "ERROR_DS_SRC_NAME_MISMATCH",
            description = "Source and destination of a cross-domain move do not agree on the object's current name. Either source or destination does not have the latest version of the object."
        },
        [8485] = {
            id = "ERROR_DS_SRC_AND_DST_NC_IDENTICAL",
            description = "Source and destination for the cross-domain move operation are identical. Caller should use local move operation instead of cross-domain move operation."
        },
        [8486] = {
            id = "ERROR_DS_DST_NC_MISMATCH",
            description = "Source and destination for a cross-domain move are not in agreement on the naming contexts in the forest. Either source or destination does not have the latest version of the Partitions container."
        },
        [8487] = {
            id = "ERROR_DS_NOT_AUTHORITIVE_FOR_DST_NC",
            description = "Destination of a cross-domain move is not authoritative for the destination naming context."
        },
        [8488] = {
            id = "ERROR_DS_SRC_GUID_MISMATCH",
            description = "Source and destination of a cross-domain move do not agree on the identity of the source object. Either source or destination does not have the latest version of the source object."
        },
        [8489] = {
            id = "ERROR_DS_CANT_MOVE_DELETED_OBJECT",
            description = "Object being moved across-domains is already known to be deleted by the destination server. The source server does not have the latest version of the source object."
        },
        [8490] = {
            id = "ERROR_DS_PDC_OPERATION_IN_PROGRESS",
            description = "Another operation which requires exclusive access to the PDC FSMO is already in progress."
        },
        [8491] = {
            id = "ERROR_DS_CROSS_DOMAIN_CLEANUP_REQD",
            description = "A cross-domain move operation failed such that two versions of the moved object exist - one each in the source and destination domains. The destination object needs to be removed to restore the system to a consistent state."
        },
        [8492] = {
            id = "ERROR_DS_ILLEGAL_XDOM_MOVE_OPERATION",
            description = "This object may not be moved across domain boundaries either because cross-domain moves for this class are disallowed, or the object has some special characteristics, e.g.: trust account or restricted RID, which prevent its move."
        },
        [8493] = {
            id = "ERROR_DS_CANT_WITH_ACCT_GROUP_MEMBERSHPS",
            description = "Can't move objects with memberships across domain boundaries as once moved, this would violate the membership conditions of the account group. Remove the object from any account group memberships and retry."
        },
        [8494] = {
            id = "ERROR_DS_NC_MUST_HAVE_NC_PARENT",
            description = "A naming context head must be the immediate child of another naming context head, not of an interior node."
        },
        [8495] = {
            id = "ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE",
            description = "The directory cannot validate the proposed naming context name because it does not hold a replica of the naming context above the proposed naming context. Please ensure that the domain naming master role is held by a server that is configured as a global catalog server, and that the server is up to date with its replication partners. (Applies only to Windows 2000 Domain Naming masters.)"
        },
        [8496] = {
            id = "ERROR_DS_DST_DOMAIN_NOT_NATIVE",
            description = "Destination domain must be in native mode."
        },
        [8497] = {
            id = "ERROR_DS_MISSING_INFRASTRUCTURE_CONTAINER",
            description = "The operation cannot be performed because the server does not have an infrastructure container in the domain of interest."
        },
        [8498] = {
            id = "ERROR_DS_CANT_MOVE_ACCOUNT_GROUP",
            description = "Cross-domain move of non-empty account groups is not allowed."
        },
        [8499] = {
            id = "ERROR_DS_CANT_MOVE_RESOURCE_GROUP",
            description = "Cross-domain move of non-empty resource groups is not allowed."
        },
        [8500] = {
            id = "ERROR_DS_INVALID_SEARCH_FLAG",
            description = "The search flags for the attribute are invalid. The ANR bit is valid only on attributes of Unicode or Teletex strings."
        },
        [8501] = {
            id = "ERROR_DS_NO_TREE_DELETE_ABOVE_NC",
            description = "Tree deletions starting at an object which has an NC head as a descendant are not allowed."
        },
        [8502] = {
            id = "ERROR_DS_COULDNT_LOCK_TREE_FOR_DELETE",
            description = "The directory service failed to lock a tree in preparation for a tree deletion because the tree was in use."
        },
        [8503] = {
            id = "ERROR_DS_COULDNT_IDENTIFY_OBJECTS_FOR_TREE_DELETE",
            description = "The directory service failed to identify the list of objects to delete while attempting a tree deletion."
        },
        [8504] = {
            id = "ERROR_DS_SAM_INIT_FAILURE",
            description = "Security Accounts Manager initialization failed because of the following error: %1. Error Status: 0x%2. Please shutdown this system and reboot into Directory Services Restore Mode, check the event log for more detailed information."
        },
        [8505] = {
            id = "ERROR_DS_SENSITIVE_GROUP_VIOLATION",
            description = "Only an administrator can modify the membership list of an administrative group."
        },
        [8506] = {
            id = "ERROR_DS_CANT_MOD_PRIMARYGROUPID",
            description = "Cannot change the primary group ID of a domain controller account."
        },
        [8507] = {
            id = "ERROR_DS_ILLEGAL_BASE_SCHEMA_MOD",
            description = "An attempt is made to modify the base schema."
        },
        [8508] = {
            id = "ERROR_DS_NONSAFE_SCHEMA_CHANGE",
            description = "Adding a new mandatory attribute to an existing class, deleting a mandatory attribute from an existing class, or adding an optional attribute to the special class Top that is not a backlink attribute (directly or through inheritance, for example, by adding or deleting an auxiliary class) is not allowed."
        },
        [8509] = {
            id = "ERROR_DS_SCHEMA_UPDATE_DISALLOWED",
            description = "Schema update is not allowed on this DC because the DC is not the schema FSMO Role Owner."
        },
        [8510] = {
            id = "ERROR_DS_CANT_CREATE_UNDER_SCHEMA",
            description = "An object of this class cannot be created under the schema container. You can only create attribute-schema and class-schema objects under the schema container."
        },
        [8511] = {
            id = "ERROR_DS_INSTALL_NO_SRC_SCH_VERSION",
            description = "The replica/child install failed to get the objectVersion attribute on the schema container on the source DC. Either the attribute is missing on the schema container or the credentials supplied do not have permission to read it."
        },
        [8512] = {
            id = "ERROR_DS_INSTALL_NO_SCH_VERSION_IN_INIFILE",
            description = "The replica/child install failed to read the objectVersion attribute in the SCHEMA section of the file schema.ini in the system32 directory."
        },
        [8513] = {
            id = "ERROR_DS_INVALID_GROUP_TYPE",
            description = "The specified group type is invalid."
        },
        [8514] = {
            id = "ERROR_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN",
            description = "You cannot nest global groups in a mixed domain if the group is security-enabled."
        },
        [8515] = {
            id = "ERROR_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN",
            description = "You cannot nest local groups in a mixed domain if the group is security-enabled."
        },
        [8516] = {
            id = "ERROR_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER",
            description = "A global group cannot have a local group as a member."
        },
        [8517] = {
            id = "ERROR_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER",
            description = "A global group cannot have a universal group as a member."
        },
        [8518] = {
            id = "ERROR_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER",
            description = "A universal group cannot have a local group as a member."
        },
        [8519] = {
            id = "ERROR_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER",
            description = "A global group cannot have a cross-domain member."
        },
        [8520] = {
            id = "ERROR_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER",
            description = "A local group cannot have another cross domain local group as a member."
        },
        [8521] = {
            id = "ERROR_DS_HAVE_PRIMARY_MEMBERS",
            description = "A group with primary members cannot change to a security-disabled group."
        },
        [8522] = {
            id = "ERROR_DS_STRING_SD_CONVERSION_FAILED",
            description = "The schema cache load failed to convert the string default SD on a class-schema object."
        },
        [8523] = {
            id = "ERROR_DS_NAMING_MASTER_GC",
            description = "Only DSAs configured to be Global Catalog servers should be allowed to hold the Domain Naming Master FSMO role. (Applies only to Windows 2000 servers.)"
        },
        [8524] = {
            id = "ERROR_DS_DNS_LOOKUP_FAILURE",
            description = "The DSA operation is unable to proceed because of a DNS lookup failure."
        },
        [8525] = {
            id = "ERROR_DS_COULDNT_UPDATE_SPNS",
            description = "While processing a change to the DNS Host Name for an object, the Service Principal Name values could not be kept in sync."
        },
        [8526] = {
            id = "ERROR_DS_CANT_RETRIEVE_SD",
            description = "The Security Descriptor attribute could not be read."
        },
        [8527] = {
            id = "ERROR_DS_KEY_NOT_UNIQUE",
            description = "The object requested was not found, but an object with that key was found."
        },
        [8528] = {
            id = "ERROR_DS_WRONG_LINKED_ATT_SYNTAX",
            description = "The syntax of the linked attribute being added is incorrect. Forward links can only have syntax 2.5.5.1, 2.5.5.7, and 2.5.5.14, and backlinks can only have syntax 2.5.5.1."
        },
        [8529] = {
            id = "ERROR_DS_SAM_NEED_BOOTKEY_PASSWORD",
            description = "Security Account Manager needs to get the boot password."
        },
        [8530] = {
            id = "ERROR_DS_SAM_NEED_BOOTKEY_FLOPPY",
            description = "Security Account Manager needs to get the boot key from floppy disk."
        },
        [8531] = {
            id = "ERROR_DS_CANT_START",
            description = "Directory Service cannot start."
        },
        [8532] = {
            id = "ERROR_DS_INIT_FAILURE",
            description = "Directory Services could not start."
        },
        [8533] = {
            id = "ERROR_DS_NO_PKT_PRIVACY_ON_CONNECTION",
            description = "The connection between client and server requires packet privacy or better."
        },
        [8534] = {
            id = "ERROR_DS_SOURCE_DOMAIN_IN_FOREST",
            description = "The source domain may not be in the same forest as destination."
        },
        [8535] = {
            id = "ERROR_DS_DESTINATION_DOMAIN_NOT_IN_FOREST",
            description = "The destination domain must be in the forest."
        },
        [8536] = {
            id = "ERROR_DS_DESTINATION_AUDITING_NOT_ENABLED",
            description = "The operation requires that destination domain auditing be enabled."
        },
        [8537] = {
            id = "ERROR_DS_CANT_FIND_DC_FOR_SRC_DOMAIN",
            description = "The operation couldn't locate a DC for the source domain."
        },
        [8538] = {
            id = "ERROR_DS_SRC_OBJ_NOT_GROUP_OR_USER",
            description = "The source object must be a group or user."
        },
        [8539] = {
            id = "ERROR_DS_SRC_SID_EXISTS_IN_FOREST",
            description = "The source object's SID already exists in destination forest."
        },
        [8540] = {
            id = "ERROR_DS_SRC_AND_DST_OBJECT_CLASS_MISMATCH",
            description = "The source and destination object must be of the same type."
        },
        [8541] = {
            id = "ERROR_SAM_INIT_FAILURE",
            description = "Security Accounts Manager initialization failed because of the following error: %1. Error Status: 0x%2. Click OK to shut down the system and reboot into Safe Mode. Check the event log for detailed information."
        },
        [8542] = {
            id = "ERROR_DS_DRA_SCHEMA_INFO_SHIP",
            description = "Schema information could not be included in the replication request."
        },
        [8543] = {
            id = "ERROR_DS_DRA_SCHEMA_CONFLICT",
            description = "The replication operation could not be completed due to a schema incompatibility."
        },
        [8544] = {
            id = "ERROR_DS_DRA_EARLIER_SCHEMA_CONFLICT",
            description = "The replication operation could not be completed due to a previous schema incompatibility."
        },
        [8545] = {
            id = "ERROR_DS_DRA_OBJ_NC_MISMATCH",
            description = "The replication update could not be applied because either the source or the destination has not yet received information regarding a recent cross-domain move operation."
        },
        [8546] = {
            id = "ERROR_DS_NC_STILL_HAS_DSAS",
            description = "The requested domain could not be deleted because there exist domain controllers that still host this domain."
        },
        [8547] = {
            id = "ERROR_DS_GC_REQUIRED",
            description = "The requested operation can be performed only on a global catalog server."
        },
        [8548] = {
            id = "ERROR_DS_LOCAL_MEMBER_OF_LOCAL_ONLY",
            description = "A local group can only be a member of other local groups in the same domain."
        },
        [8549] = {
            id = "ERROR_DS_NO_FPO_IN_UNIVERSAL_GROUPS",
            description = "Foreign security principals cannot be members of universal groups."
        },
        [8550] = {
            id = "ERROR_DS_CANT_ADD_TO_GC",
            description = "The attribute is not allowed to be replicated to the GC because of security reasons."
        },
        [8551] = {
            id = "ERROR_DS_NO_CHECKPOINT_WITH_PDC",
            description = "The checkpoint with the PDC could not be taken because there too many modifications being processed currently."
        },
        [8552] = {
            id = "ERROR_DS_SOURCE_AUDITING_NOT_ENABLED",
            description = "The operation requires that source domain auditing be enabled."
        },
        [8553] = {
            id = "ERROR_DS_CANT_CREATE_IN_NONDOMAIN_NC",
            description = "Security principal objects can only be created inside domain naming contexts."
        },
        [8554] = {
            id = "ERROR_DS_INVALID_NAME_FOR_SPN",
            description = "A Service Principal Name (SPN) could not be constructed because the provided hostname is not in the necessary format."
        },
        [8555] = {
            id = "ERROR_DS_FILTER_USES_CONTRUCTED_ATTRS",
            description = "A Filter was passed that uses constructed attributes."
        },
        [8556] = {
            id = "ERROR_DS_UNICODEPWD_NOT_IN_QUOTES",
            description = "The unicodePwd attribute value must be enclosed in double quotes."
        },
        [8557] = {
            id = "ERROR_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED",
            description = "Your computer could not be joined to the domain. You have exceeded the maximum number of computer accounts you are allowed to create in this domain. Contact your system administrator to have this limit reset or increased."
        },
        [8558] = {
            id = "ERROR_DS_MUST_BE_RUN_ON_DST_DC",
            description = "For security reasons, the operation must be run on the destination DC."
        },
        [8559] = {
            id = "ERROR_DS_SRC_DC_MUST_BE_SP4_OR_GREATER",
            description = "For security reasons, the source DC must be NT4SP4 or greater."
        },
        [8560] = {
            id = "ERROR_DS_CANT_TREE_DELETE_CRITICAL_OBJ",
            description = "Critical Directory Service System objects cannot be deleted during tree delete operations. The tree delete may have been partially performed."
        },
        [8561] = {
            id = "ERROR_DS_INIT_FAILURE_CONSOLE",
            description = "Directory Services could not start because of the following error: %1. Error Status: 0x%2. Please click OK to shutdown the system. You can use the recovery console to diagnose the system further."
        },
        [8562] = {
            id = "ERROR_DS_SAM_INIT_FAILURE_CONSOLE",
            description = "Security Accounts Manager initialization failed because of the following error: %1. Error Status: 0x%2. Please click OK to shutdown the system. You can use the recovery console to diagnose the system further."
        },
        [8563] = {
            id = "ERROR_DS_FOREST_VERSION_TOO_HIGH",
            description = "The version of the operating system is incompatible with the current AD DS forest functional level or AD LDS Configuration Set functional level. You must upgrade to a new version of the operating system before this server can become an AD DS Domain Controller or add an AD LDS Instance in this AD DS Forest or AD LDS Configuration Set."
        },
        [8564] = {
            id = "ERROR_DS_DOMAIN_VERSION_TOO_HIGH",
            description = "The version of the operating system installed is incompatible with the current domain functional level. You must upgrade to a new version of the operating system before this server can become a domain controller in this domain."
        },
        [8565] = {
            id = "ERROR_DS_FOREST_VERSION_TOO_LOW",
            description = "The version of the operating system installed on this server no longer supports the current AD DS Forest functional level or AD LDS Configuration Set functional level. You must raise the AD DS Forest functional level or AD LDS Configuration Set functional level before this server can become an AD DS Domain Controller or an AD LDS Instance in this Forest or Configuration Set."
        },
        [8566] = {
            id = "ERROR_DS_DOMAIN_VERSION_TOO_LOW",
            description = "The version of the operating system installed on this server no longer supports the current domain functional level. You must raise the domain functional level before this server can become a domain controller in this domain."
        },
        [8567] = {
            id = "ERROR_DS_INCOMPATIBLE_VERSION",
            description = "The version of the operating system installed on this server is incompatible with the functional level of the domain or forest."
        },
        [8568] = {
            id = "ERROR_DS_LOW_DSA_VERSION",
            description = "The functional level of the domain (or forest) cannot be raised to the requested value, because there exist one or more domain controllers in the domain (or forest) that are at a lower incompatible functional level."
        },
        [8569] = {
            id = "ERROR_DS_NO_BEHAVIOR_VERSION_IN_MIXEDDOMAIN",
            description = "The forest functional level cannot be raised to the requested value since one or more domains are still in mixed domain mode. All domains in the forest must be in native mode, for you to raise the forest functional level."
        },
        [8570] = {
            id = "ERROR_DS_NOT_SUPPORTED_SORT_ORDER",
            description = "The sort order requested is not supported."
        },
        [8571] = {
            id = "ERROR_DS_NAME_NOT_UNIQUE",
            description = "The requested name already exists as a unique identifier."
        },
        [8572] = {
            id = "ERROR_DS_MACHINE_ACCOUNT_CREATED_PRENT4",
            description = "The machine account was created pre-NT4. The account needs to be recreated."
        },
        [8573] = {
            id = "ERROR_DS_OUT_OF_VERSION_STORE",
            description = "The database is out of version store."
        },
        [8574] = {
            id = "ERROR_DS_INCOMPATIBLE_CONTROLS_USED",
            description = "Unable to continue operation because multiple conflicting controls were used."
        },
        [8575] = {
            id = "ERROR_DS_NO_REF_DOMAIN",
            description = "Unable to find a valid security descriptor reference domain for this partition."
        },
        [8576] = {
            id = "ERROR_DS_RESERVED_LINK_ID",
            description = "Schema update failed: The link identifier is reserved."
        },
        [8577] = {
            id = "ERROR_DS_LINK_ID_NOT_AVAILABLE",
            description = "Schema update failed: There are no link identifiers available."
        },
        [8578] = {
            id = "ERROR_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER",
            description = "An account group cannot have a universal group as a member."
        },
        [8579] = {
            id = "ERROR_DS_MODIFYDN_DISALLOWED_BY_INSTANCE_TYPE",
            description = "Rename or move operations on naming context heads or read-only objects are not allowed."
        },
        [8580] = {
            id = "ERROR_DS_NO_OBJECT_MOVE_IN_SCHEMA_NC",
            description = "Move operations on objects in the schema naming context are not allowed."
        },
        [8581] = {
            id = "ERROR_DS_MODIFYDN_DISALLOWED_BY_FLAG",
            description = "A system flag has been set on the object and does not allow the object to be moved or renamed."
        },
        [8582] = {
            id = "ERROR_DS_MODIFYDN_WRONG_GRANDPARENT",
            description = "This object is not allowed to change its grandparent container. Moves are not forbidden on this object, but are restricted to sibling containers."
        },
        [8583] = {
            id = "ERROR_DS_NAME_ERROR_TRUST_REFERRAL",
            description = "Unable to resolve completely, a referral to another forest is generated."
        },
        [8584] = {
            id = "ERROR_NOT_SUPPORTED_ON_STANDARD_SERVER",
            description = "The requested action is not supported on standard server."
        },
        [8585] = {
            id = "ERROR_DS_CANT_ACCESS_REMOTE_PART_OF_AD",
            description = "Could not access a partition of the directory service located on a remote server. Make sure at least one server is running for the partition in question."
        },
        [8586] = {
            id = "ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE_V2",
            description = "The directory cannot validate the proposed naming context (or partition) name because it does not hold a replica nor can it contact a replica of the naming context above the proposed naming context. Please ensure that the parent naming context is properly registered in DNS, and at least one replica of this naming context is reachable by the Domain Naming master."
        },
        [8587] = {
            id = "ERROR_DS_THREAD_LIMIT_EXCEEDED",
            description = "The thread limit for this request was exceeded."
        },
        [8588] = {
            id = "ERROR_DS_NOT_CLOSEST",
            description = "The Global catalog server is not in the closest site."
        },
        [8589] = {
            id = "ERROR_DS_CANT_DERIVE_SPN_WITHOUT_SERVER_REF",
            description = "The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the corresponding server object in the local DS database has no serverReference attribute."
        },
        [8590] = {
            id = "ERROR_DS_SINGLE_USER_MODE_FAILED",
            description = "The Directory Service failed to enter single user mode."
        },
        [8591] = {
            id = "ERROR_DS_NTDSCRIPT_SYNTAX_ERROR",
            description = "The Directory Service cannot parse the script because of a syntax error."
        },
        [8592] = {
            id = "ERROR_DS_NTDSCRIPT_PROCESS_ERROR",
            description = "The Directory Service cannot process the script because of an error."
        },
        [8593] = {
            id = "ERROR_DS_DIFFERENT_REPL_EPOCHS",
            description = "The directory service cannot perform the requested operation because the servers involved are of different replication epochs (which is usually related to a domain rename that is in progress)."
        },
        [8594] = {
            id = "ERROR_DS_DRS_EXTENSIONS_CHANGED",
            description = "The directory service binding must be renegotiated due to a change in the server extensions information."
        },
        [8595] = {
            id = "ERROR_DS_REPLICA_SET_CHANGE_NOT_ALLOWED_ON_DISABLED_CR",
            description = "Operation not allowed on a disabled cross ref."
        },
        [8596] = {
            id = "ERROR_DS_NO_MSDS_INTID",
            description = "Schema update failed: No values for msDS-IntId are available."
        },
        [8597] = {
            id = "ERROR_DS_DUP_MSDS_INTID",
            description = "Schema update failed: Duplicate msDS-INtId. Retry the operation."
        },
        [8598] = {
            id = "ERROR_DS_EXISTS_IN_RDNATTID",
            description = "Schema deletion failed: attribute is used in rDNAttID."
        },
        [8599] = {
            id = "ERROR_DS_AUTHORIZATION_FAILED",
            description = "The directory service failed to authorize the request."
        },
        [8600] = {
            id = "ERROR_DS_INVALID_SCRIPT",
            description = "The Directory Service cannot process the script because it is invalid."
        },
        [8601] = {
            id = "ERROR_DS_REMOTE_CROSSREF_OP_FAILED",
            description = "The remote create cross reference operation failed on the Domain Naming Master FSMO. The operation's error is in the extended data."
        },
        [8602] = {
            id = "ERROR_DS_CROSS_REF_BUSY",
            description = "A cross reference is in use locally with the same name."
        },
        [8603] = {
            id = "ERROR_DS_CANT_DERIVE_SPN_FOR_DELETED_DOMAIN",
            description = "The DS cannot derive a service principal name (SPN) with which to mutually authenticate the target server because the server's domain has been deleted from the forest."
        },
        [8604] = {
            id = "ERROR_DS_CANT_DEMOTE_WITH_WRITEABLE_NC",
            description = "Writeable NCs prevent this DC from demoting."
        },
        [8605] = {
            id = "ERROR_DS_DUPLICATE_ID_FOUND",
            description = "The requested object has a non-unique identifier and cannot be retrieved."
        },
        [8606] = {
            id = "ERROR_DS_INSUFFICIENT_ATTR_TO_CREATE_OBJECT",
            description = "Insufficient attributes were given to create an object. This object may not exist because it may have been deleted and already garbage collected."
        },
        [8607] = {
            id = "ERROR_DS_GROUP_CONVERSION_ERROR",
            description = "The group cannot be converted due to attribute restrictions on the requested group type."
        },
        [8608] = {
            id = "ERROR_DS_CANT_MOVE_APP_BASIC_GROUP",
            description = "Cross-domain move of non-empty basic application groups is not allowed."
        },
        [8609] = {
            id = "ERROR_DS_CANT_MOVE_APP_QUERY_GROUP",
            description = "Cross-domain move of non-empty query based application groups is not allowed."
        },
        [8610] = {
            id = "ERROR_DS_ROLE_NOT_VERIFIED",
            description = "The FSMO role ownership could not be verified because its directory partition has not replicated successfully with at least one replication partner."
        },
        [8611] = {
            id = "ERROR_DS_WKO_CONTAINER_CANNOT_BE_SPECIAL",
            description = "The target container for a redirection of a well known object container cannot already be a special container."
        },
        [8612] = {
            id = "ERROR_DS_DOMAIN_RENAME_IN_PROGRESS",
            description = "The Directory Service cannot perform the requested operation because a domain rename operation is in progress."
        },
        [8613] = {
            id = "ERROR_DS_EXISTING_AD_CHILD_NC",
            description = "The directory service detected a child partition below the requested partition name. The partition hierarchy must be created in a top down method."
        },
        [8614] = {
            id = "ERROR_DS_REPL_LIFETIME_EXCEEDED",
            description = "The directory service cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime."
        },
        [8615] = {
            id = "ERROR_DS_DISALLOWED_IN_SYSTEM_CONTAINER",
            description = "The requested operation is not allowed on an object under the system container."
        },
        [8616] = {
            id = "ERROR_DS_LDAP_SEND_QUEUE_FULL",
            description = "The LDAP servers network send queue has filled up because the client is not processing the results of its requests fast enough. No more requests will be processed until the client catches up. If the client does not catch up then it will be disconnected."
        },
        [8617] = {
            id = "ERROR_DS_DRA_OUT_SCHEDULE_WINDOW",
            description = "The scheduled replication did not take place because the system was too busy to execute the request within the schedule window. The replication queue is overloaded. Consider reducing the number of partners or decreasing the scheduled replication frequency."
        },
        [8618] = {
            id = "ERROR_DS_POLICY_NOT_KNOWN",
            description = "At this time, it cannot be determined if the branch replication policy is available on the hub domain controller. Please retry at a later time to account for replication latencies."
        },
        [8619] = {
            id = "ERROR_NO_SITE_SETTINGS_OBJECT",
            description = "The site settings object for the specified site does not exist."
        },
        [8620] = {
            id = "ERROR_NO_SECRETS",
            description = "The local account store does not contain secret material for the specified account."
        },
        [8621] = {
            id = "ERROR_NO_WRITABLE_DC_FOUND",
            description = "Could not find a writable domain controller in the domain."
        },
        [8622] = {
            id = "ERROR_DS_NO_SERVER_OBJECT",
            description = "The server object for the domain controller does not exist."
        },
        [8623] = {
            id = "ERROR_DS_NO_NTDSA_OBJECT",
            description = "The NTDS Settings object for the domain controller does not exist."
        },
        [8624] = {
            id = "ERROR_DS_NON_ASQ_SEARCH",
            description = "The requested search operation is not supported for ASQ searches."
        },
        [8625] = {
            id = "ERROR_DS_AUDIT_FAILURE",
            description = "A required audit event could not be generated for the operation."
        },
        [8626] = {
            id = "ERROR_DS_INVALID_SEARCH_FLAG_SUBTREE",
            description = "The search flags for the attribute are invalid. The subtree index bit is valid only on single valued attributes."
        },
        [8627] = {
            id = "ERROR_DS_INVALID_SEARCH_FLAG_TUPLE",
            description = "The search flags for the attribute are invalid. The tuple index bit is valid only on attributes of Unicode strings."
        },
        [8628] = {
            id = "ERROR_DS_HIERARCHY_TABLE_TOO_DEEP",
            description = "The address books are nested too deeply. Failed to build the hierarchy table."
        },
        [8629] = {
            id = "ERROR_DS_DRA_CORRUPT_UTD_VECTOR",
            description = "The specified up-to-date-ness vector is corrupt."
        },
        [8630] = {
            id = "ERROR_DS_DRA_SECRETS_DENIED",
            description = "The request to replicate secrets is denied."
        },
        [8631] = {
            id = "ERROR_DS_RESERVED_MAPI_ID",
            description = "Schema update failed: The MAPI identifier is reserved."
        },
        [8632] = {
            id = "ERROR_DS_MAPI_ID_NOT_AVAILABLE",
            description = "Schema update failed: There are no MAPI identifiers available."
        },
        [8633] = {
            id = "ERROR_DS_DRA_MISSING_KRBTGT_SECRET",
            description = "The replication operation failed because the required attributes of the local krbtgt object are missing."
        },
        [8634] = {
            id = "ERROR_DS_DOMAIN_NAME_EXISTS_IN_FOREST",
            description = "The domain name of the trusted domain already exists in the forest."
        },
        [8635] = {
            id = "ERROR_DS_FLAT_NAME_EXISTS_IN_FOREST",
            description = "The flat name of the trusted domain already exists in the forest."
        },
        [8636] = {
            id = "ERROR_INVALID_USER_PRINCIPAL_NAME",
            description = "The User Principal Name (UPN) is invalid."
        },
        [8637] = {
            id = "ERROR_DS_OID_MAPPED_GROUP_CANT_HAVE_MEMBERS",
            description = "OID mapped groups cannot have members."
        },
        [8638] = {
            id = "ERROR_DS_OID_NOT_FOUND",
            description = "The specified OID cannot be found."
        },
        [8639] = {
            id = "ERROR_DS_DRA_RECYCLED_TARGET",
            description = "The replication operation failed because the target object referred by a link value is recycled."
        },
        [8640] = {
            id = "ERROR_DS_DISALLOWED_NC_REDIRECT",
            description = "The redirect operation failed because the target object is in a NC different from the domain NC of the current domain controller."
        },
        [8641] = {
            id = "ERROR_DS_HIGH_ADLDS_FFL",
            description = "The functional level of the AD LDS configuration set cannot be lowered to the requested value."
        },
        [8642] = {
            id = "ERROR_DS_HIGH_DSA_VERSION",
            description = "The functional level of the domain (or forest) cannot be lowered to the requested value."
        },
        [8643] = {
            id = "ERROR_DS_LOW_ADLDS_FFL",
            description = "The functional level of the AD LDS configuration set cannot be raised to the requested value, because there exist one or more ADLDS instances that are at a lower incompatible functional level."
        },
        [8644] = {
            id = "ERROR_DOMAIN_SID_SAME_AS_LOCAL_WORKSTATION",
            description = "The domain join cannot be completed because the SID of the domain you attempted to join was identical to the SID of this machine. This is a symptom of an improperly cloned operating system install. You should run sysprep on this machine in order to generate a new machine SID. Please see http://go.microsoft.com/fwlink/p/?linkid=168895 for more information."
        },
        [8645] = {
            id = "ERROR_DS_UNDELETE_SAM_VALIDATION_FAILED",
            description = "The undelete operation failed because the Sam Account Name or Additional Sam Account Name of the object being undeleted conflicts with an existing live object."
        },
        [8646] = {
            id = "ERROR_INCORRECT_ACCOUNT_TYPE",
            description = "The system is not authoritative for the specified account and therefore cannot complete the operation. Please retry the operation using the provider associated with this account. If this is an online provider please use the provider's online site."
        },
        [9001] = {
            id = "DNS_ERROR_RCODE_FORMAT_ERROR",
            description = "DNS server unable to interpret format."
        },
        [9002] = {
            id = "DNS_ERROR_RCODE_SERVER_FAILURE",
            description = "DNS server failure."
        },
        [9003] = {
            id = "DNS_ERROR_RCODE_NAME_ERROR",
            description = "DNS name does not exist."
        },
        [9004] = {
            id = "DNS_ERROR_RCODE_NOT_IMPLEMENTED",
            description = "DNS request not supported by name server."
        },
        [9005] = {
            id = "DNS_ERROR_RCODE_REFUSED",
            description = "DNS operation refused."
        },
        [9006] = {
            id = "DNS_ERROR_RCODE_YXDOMAIN",
            description = "DNS name that ought not exist, does exist."
        },
        [9007] = {
            id = "DNS_ERROR_RCODE_YXRRSET",
            description = "DNS RR set that ought not exist, does exist."
        },
        [9008] = {
            id = "DNS_ERROR_RCODE_NXRRSET",
            description = "DNS RR set that ought to exist, does not exist."
        },
        [9009] = {
            id = "DNS_ERROR_RCODE_NOTAUTH",
            description = "DNS server not authoritative for zone."
        },
        [9010] = {
            id = "DNS_ERROR_RCODE_NOTZONE",
            description = "DNS name in update or prereq is not in zone."
        },
        [9016] = {
            id = "DNS_ERROR_RCODE_BADSIG",
            description = "DNS signature failed to verify."
        },
        [9017] = {
            id = "DNS_ERROR_RCODE_BADKEY",
            description = "DNS bad key."
        },
        [9018] = {
            id = "DNS_ERROR_RCODE_BADTIME",
            description = "DNS signature validity expired."
        },
        [9101] = {
            id = "DNS_ERROR_KEYMASTER_REQUIRED",
            description = "Only the DNS server acting as the key master for the zone may perform this operation."
        },
        [9102] = {
            id = "DNS_ERROR_NOT_ALLOWED_ON_SIGNED_ZONE",
            description = "This operation is not allowed on a zone that is signed or has signing keys."
        },
        [9103] = {
            id = "DNS_ERROR_NSEC3_INCOMPATIBLE_WITH_RSA_SHA1",
            description = "NSEC3 is not compatible with the RSA-SHA-1 algorithm. Choose a different algorithm or use NSEC.\n\nThis value was also named DNS_ERROR_INVALID_NSEC3_PARAMETERS"
        },
        [9104] = {
            id = "DNS_ERROR_NOT_ENOUGH_SIGNING_KEY_DESCRIPTORS",
            description = "The zone does not have enough signing keys. There must be at least one key signing key (KSK) and at least one zone signing key (ZSK)."
        },
        [9105] = {
            id = "DNS_ERROR_UNSUPPORTED_ALGORITHM",
            description = "The specified algorithm is not supported."
        },
        [9106] = {
            id = "DNS_ERROR_INVALID_KEY_SIZE",
            description = "The specified key size is not supported."
        },
        [9107] = {
            id = "DNS_ERROR_SIGNING_KEY_NOT_ACCESSIBLE",
            description = "One or more of the signing keys for a zone are not accessible to the DNS server. Zone signing will not be operational until this error is resolved."
        },
        [9108] = {
            id = "DNS_ERROR_KSP_DOES_NOT_SUPPORT_PROTECTION",
            description = "The specified key storage provider does not support DPAPI++ data protection. Zone signing will not be operational until this error is resolved."
        },
        [9109] = {
            id = "DNS_ERROR_UNEXPECTED_DATA_PROTECTION_ERROR",
            description = "An unexpected DPAPI++ error was encountered. Zone signing will not be operational until this error is resolved."
        },
        [9110] = {
            id = "DNS_ERROR_UNEXPECTED_CNG_ERROR",
            description = "An unexpected crypto error was encountered. Zone signing may not be operational until this error is resolved."
        },
        [9111] = {
            id = "DNS_ERROR_UNKNOWN_SIGNING_PARAMETER_VERSION",
            description = "The DNS server encountered a signing key with an unknown version. Zone signing will not be operational until this error is resolved."
        },
        [9112] = {
            id = "DNS_ERROR_KSP_NOT_ACCESSIBLE",
            description = "The specified key service provider cannot be opened by the DNS server."
        },
        [9113] = {
            id = "DNS_ERROR_TOO_MANY_SKDS",
            description = "The DNS server cannot accept any more signing keys with the specified algorithm and KSK flag value for this zone."
        },
        [9114] = {
            id = "DNS_ERROR_INVALID_ROLLOVER_PERIOD",
            description = "The specified rollover period is invalid."
        },
        [9115] = {
            id = "DNS_ERROR_INVALID_INITIAL_ROLLOVER_OFFSET",
            description = "The specified initial rollover offset is invalid."
        },
        [9116] = {
            id = "DNS_ERROR_ROLLOVER_IN_PROGRESS",
            description = "The specified signing key is already in process of rolling over keys."
        },
        [9117] = {
            id = "DNS_ERROR_STANDBY_KEY_NOT_PRESENT",
            description = "The specified signing key does not have a standby key to revoke."
        },
        [9118] = {
            id = "DNS_ERROR_NOT_ALLOWED_ON_ZSK",
            description = "This operation is not allowed on a zone signing key (ZSK)."
        },
        [9119] = {
            id = "DNS_ERROR_NOT_ALLOWED_ON_ACTIVE_SKD",
            description = "This operation is not allowed on an active signing key."
        },
        [9120] = {
            id = "DNS_ERROR_ROLLOVER_ALREADY_QUEUED",
            description = "The specified signing key is already queued for rollover."
        },
        [9121] = {
            id = "DNS_ERROR_NOT_ALLOWED_ON_UNSIGNED_ZONE",
            description = "This operation is not allowed on an unsigned zone."
        },
        [9122] = {
            id = "DNS_ERROR_BAD_KEYMASTER",
            description = "This operation could not be completed because the DNS server listed as the current key master for this zone is down or misconfigured. Resolve the problem on the current key master for this zone or use another DNS server to seize the key master role."
        },
        [9123] = {
            id = "DNS_ERROR_INVALID_SIGNATURE_VALIDITY_PERIOD",
            description = "The specified signature validity period is invalid."
        },
        [9124] = {
            id = "DNS_ERROR_INVALID_NSEC3_ITERATION_COUNT",
            description = "The specified NSEC3 iteration count is higher than allowed by the minimum key length used in the zone."
        },
        [9125] = {
            id = "DNS_ERROR_DNSSEC_IS_DISABLED",
            description = "This operation could not be completed because the DNS server has been configured with DNSSEC features disabled. Enable DNSSEC on the DNS server."
        },
        [9126] = {
            id = "DNS_ERROR_INVALID_XML",
            description = "This operation could not be completed because the XML stream received is empty or syntactically invalid."
        },
        [9127] = {
            id = "DNS_ERROR_NO_VALID_TRUST_ANCHORS",
            description = "This operation completed, but no trust anchors were added because all of the trust anchors received were either invalid, unsupported, expired, or would not become valid in less than 30 days."
        },
        [9128] = {
            id = "DNS_ERROR_ROLLOVER_NOT_POKEABLE",
            description = "The specified signing key is not waiting for parental DS update."
        },
        [9129] = {
            id = "DNS_ERROR_NSEC3_NAME_COLLISION",
            description = "Hash collision detected during NSEC3 signing. Specify a different user-provided salt, or use a randomly generated salt, and attempt to sign the zone again."
        },
        [9130] = {
            id = "DNS_ERROR_NSEC_INCOMPATIBLE_WITH_NSEC3_RSA_SHA1",
            description = "NSEC is not compatible with the NSEC3-RSA-SHA-1 algorithm. Choose a different algorithm or use NSEC3."
        },
        [9501] = {
            id = "DNS_INFO_NO_RECORDS",
            description = "No records found for given DNS query."
        },
        [9502] = {
            id = "DNS_ERROR_BAD_PACKET",
            description = "Bad DNS packet."
        },
        [9503] = {
            id = "DNS_ERROR_NO_PACKET",
            description = "No DNS packet."
        },
        [9504] = {
            id = "DNS_ERROR_RCODE",
            description = "DNS error, check rcode."
        },
        [9505] = {
            id = "DNS_ERROR_UNSECURE_PACKET",
            description = "Unsecured DNS packet."
        },
        [9506] = {
            id = "DNS_REQUEST_PENDING",
            description = "DNS query request is pending."
        },
        [9551] = {
            id = "DNS_ERROR_INVALID_TYPE",
            description = "Invalid DNS type."
        },
        [9552] = {
            id = "DNS_ERROR_INVALID_IP_ADDRESS",
            description = "Invalid IP address."
        },
        [9553] = {
            id = "DNS_ERROR_INVALID_PROPERTY",
            description = "Invalid property."
        },
        [9554] = {
            id = "DNS_ERROR_TRY_AGAIN_LATER",
            description = "Try DNS operation again later."
        },
        [9555] = {
            id = "DNS_ERROR_NOT_UNIQUE",
            description = "Record for given name and type is not unique."
        },
        [9556] = {
            id = "DNS_ERROR_NON_RFC_NAME",
            description = "DNS name does not comply with RFC specifications."
        },
        [9557] = {
            id = "DNS_STATUS_FQDN",
            description = "DNS name is a fully-qualified DNS name."
        },
        [9558] = {
            id = "DNS_STATUS_DOTTED_NAME",
            description = "DNS name is dotted (multi-label)."
        },
        [9559] = {
            id = "DNS_STATUS_SINGLE_PART_NAME",
            description = "DNS name is a single-part name."
        },
        [9560] = {
            id = "DNS_ERROR_INVALID_NAME_CHAR",
            description = "DNS name contains an invalid character."
        },
        [9561] = {
            id = "DNS_ERROR_NUMERIC_NAME",
            description = "DNS name is entirely numeric."
        },
        [9562] = {
            id = "DNS_ERROR_NOT_ALLOWED_ON_ROOT_SERVER",
            description = "The operation requested is not permitted on a DNS root server."
        },
        [9563] = {
            id = "DNS_ERROR_NOT_ALLOWED_UNDER_DELEGATION",
            description = "The record could not be created because this part of the DNS namespace has been delegated to another server."
        },
        [9564] = {
            id = "DNS_ERROR_CANNOT_FIND_ROOT_HINTS",
            description = "The DNS server could not find a set of root hints."
        },
        [9565] = {
            id = "DNS_ERROR_INCONSISTENT_ROOT_HINTS",
            description = "The DNS server found root hints but they were not consistent across all adapters."
        },
        [9566] = {
            id = "DNS_ERROR_DWORD_VALUE_TOO_SMALL",
            description = "The specified value is too small for this parameter."
        },
        [9567] = {
            id = "DNS_ERROR_DWORD_VALUE_TOO_LARGE",
            description = "The specified value is too large for this parameter."
        },
        [9568] = {
            id = "DNS_ERROR_BACKGROUND_LOADING",
            description = "This operation is not allowed while the DNS server is loading zones in the background. Please try again later."
        },
        [9569] = {
            id = "DNS_ERROR_NOT_ALLOWED_ON_RODC",
            description = "The operation requested is not permitted on against a DNS server running on a read-only DC."
        },
        [9570] = {
            id = "DNS_ERROR_NOT_ALLOWED_UNDER_DNAME",
            description = "No data is allowed to exist underneath a DNAME record."
        },
        [9571] = {
            id = "DNS_ERROR_DELEGATION_REQUIRED",
            description = "This operation requires credentials delegation."
        },
        [9572] = {
            id = "DNS_ERROR_INVALID_POLICY_TABLE",
            description = "Name resolution policy table has been corrupted. DNS resolution will fail until it is fixed. Contact your network administrator."
        },
        [9601] = {
            id = "DNS_ERROR_ZONE_DOES_NOT_EXIST",
            description = "DNS zone does not exist."
        },
        [9602] = {
            id = "DNS_ERROR_NO_ZONE_INFO",
            description = "DNS zone information not available."
        },
        [9603] = {
            id = "DNS_ERROR_INVALID_ZONE_OPERATION",
            description = "Invalid operation for DNS zone."
        },
        [9604] = {
            id = "DNS_ERROR_ZONE_CONFIGURATION_ERROR",
            description = "Invalid DNS zone configuration."
        },
        [9605] = {
            id = "DNS_ERROR_ZONE_HAS_NO_SOA_RECORD",
            description = "DNS zone has no start of authority (SOA) record."
        },
        [9606] = {
            id = "DNS_ERROR_ZONE_HAS_NO_NS_RECORDS",
            description = "DNS zone has no Name Server (NS) record."
        },
        [9607] = {
            id = "DNS_ERROR_ZONE_LOCKED",
            description = "DNS zone is locked."
        },
        [9608] = {
            id = "DNS_ERROR_ZONE_CREATION_FAILED",
            description = "DNS zone creation failed."
        },
        [9609] = {
            id = "DNS_ERROR_ZONE_ALREADY_EXISTS",
            description = "DNS zone already exists."
        },
        [9610] = {
            id = "DNS_ERROR_AUTOZONE_ALREADY_EXISTS",
            description = "DNS automatic zone already exists."
        },
        [9611] = {
            id = "DNS_ERROR_INVALID_ZONE_TYPE",
            description = "Invalid DNS zone type."
        },
        [9612] = {
            id = "DNS_ERROR_SECONDARY_REQUIRES_MASTER_IP",
            description = "Secondary DNS zone requires master IP address."
        },
        [9613] = {
            id = "DNS_ERROR_ZONE_NOT_SECONDARY",
            description = "DNS zone not secondary."
        },
        [9614] = {
            id = "DNS_ERROR_NEED_SECONDARY_ADDRESSES",
            description = "Need secondary IP address."
        },
        [9615] = {
            id = "DNS_ERROR_WINS_INIT_FAILED",
            description = "WINS initialization failed."
        },
        [9616] = {
            id = "DNS_ERROR_NEED_WINS_SERVERS",
            description = "Need WINS servers."
        },
        [9617] = {
            id = "DNS_ERROR_NBSTAT_INIT_FAILED",
            description = "NBTSTAT initialization call failed."
        },
        [9618] = {
            id = "DNS_ERROR_SOA_DELETE_INVALID",
            description = "Invalid delete of start of authority (SOA)."
        },
        [9619] = {
            id = "DNS_ERROR_FORWARDER_ALREADY_EXISTS",
            description = "A conditional forwarding zone already exists for that name."
        },
        [9620] = {
            id = "DNS_ERROR_ZONE_REQUIRES_MASTER_IP",
            description = "This zone must be configured with one or more master DNS server IP addresses."
        },
        [9621] = {
            id = "DNS_ERROR_ZONE_IS_SHUTDOWN",
            description = "The operation cannot be performed because this zone is shut down."
        },
        [9622] = {
            id = "DNS_ERROR_ZONE_LOCKED_FOR_SIGNING",
            description = "This operation cannot be performed because the zone is currently being signed. Please try again later."
        },
        [9651] = {
            id = "DNS_ERROR_PRIMARY_REQUIRES_DATAFILE",
            description = "Primary DNS zone requires datafile."
        },
        [9652] = {
            id = "DNS_ERROR_INVALID_DATAFILE_NAME",
            description = "Invalid datafile name for DNS zone."
        },
        [9653] = {
            id = "DNS_ERROR_DATAFILE_OPEN_FAILURE",
            description = "Failed to open datafile for DNS zone."
        },
        [9654] = {
            id = "DNS_ERROR_FILE_WRITEBACK_FAILED",
            description = "Failed to write datafile for DNS zone."
        },
        [9655] = {
            id = "DNS_ERROR_DATAFILE_PARSING",
            description = "Failure while reading datafile for DNS zone."
        },
        [9701] = {
            id = "DNS_ERROR_RECORD_DOES_NOT_EXIST",
            description = "DNS record does not exist."
        },
        [9702] = {
            id = "DNS_ERROR_RECORD_FORMAT",
            description = "DNS record format error."
        },
        [9703] = {
            id = "DNS_ERROR_NODE_CREATION_FAILED",
            description = "Node creation failure in DNS."
        },
        [9704] = {
            id = "DNS_ERROR_UNKNOWN_RECORD_TYPE",
            description = "Unknown DNS record type."
        },
        [9705] = {
            id = "DNS_ERROR_RECORD_TIMED_OUT",
            description = "DNS record timed out."
        },
        [9706] = {
            id = "DNS_ERROR_NAME_NOT_IN_ZONE",
            description = "Name not in DNS zone."
        },
        [9707] = {
            id = "DNS_ERROR_CNAME_LOOP",
            description = "CNAME loop detected."
        },
        [9708] = {
            id = "DNS_ERROR_NODE_IS_CNAME",
            description = "Node is a CNAME DNS record."
        },
        [9709] = {
            id = "DNS_ERROR_CNAME_COLLISION",
            description = "A CNAME record already exists for given name."
        },
        [9710] = {
            id = "DNS_ERROR_RECORD_ONLY_AT_ZONE_ROOT",
            description = "Record only at DNS zone root."
        },
        [9711] = {
            id = "DNS_ERROR_RECORD_ALREADY_EXISTS",
            description = "DNS record already exists."
        },
        [9712] = {
            id = "DNS_ERROR_SECONDARY_DATA",
            description = "Secondary DNS zone data error."
        },
        [9713] = {
            id = "DNS_ERROR_NO_CREATE_CACHE_DATA",
            description = "Could not create DNS cache data."
        },
        [9714] = {
            id = "DNS_ERROR_NAME_DOES_NOT_EXIST",
            description = "DNS name does not exist."
        },
        [9715] = {
            id = "DNS_WARNING_PTR_CREATE_FAILED",
            description = "Could not create pointer (PTR) record."
        },
        [9716] = {
            id = "DNS_WARNING_DOMAIN_UNDELETED",
            description = "DNS domain was undeleted."
        },
        [9717] = {
            id = "DNS_ERROR_DS_UNAVAILABLE",
            description = "The directory service is unavailable."
        },
        [9718] = {
            id = "DNS_ERROR_DS_ZONE_ALREADY_EXISTS",
            description = "DNS zone already exists in the directory service."
        },
        [9719] = {
            id = "DNS_ERROR_NO_BOOTFILE_IF_DS_ZONE",
            description = "DNS server not creating or reading the boot file for the directory service integrated DNS zone."
        },
        [9720] = {
            id = "DNS_ERROR_NODE_IS_DNAME",
            description = "Node is a DNAME DNS record."
        },
        [9721] = {
            id = "DNS_ERROR_DNAME_COLLISION",
            description = "A DNAME record already exists for given name."
        },
        [9722] = {
            id = "DNS_ERROR_ALIAS_LOOP",
            description = "An alias loop has been detected with either CNAME or DNAME records."
        },
        [9751] = {
            id = "DNS_INFO_AXFR_COMPLETE",
            description = "DNS AXFR (zone transfer) complete."
        },
        [9752] = {
            id = "DNS_ERROR_AXFR",
            description = "DNS zone transfer failed."
        },
        [9753] = {
            id = "DNS_INFO_ADDED_LOCAL_WINS",
            description = "Added local WINS server."
        },
        [9801] = {
            id = "DNS_STATUS_CONTINUE_NEEDED",
            description = "Secure update call needs to continue update request."
        },
        [9851] = {
            id = "DNS_ERROR_NO_TCPIP",
            description = "TCP/IP network protocol not installed."
        },
        [9852] = {
            id = "DNS_ERROR_NO_DNS_SERVERS",
            description = "No DNS servers configured for local system."
        },
        [9901] = {
            id = "DNS_ERROR_DP_DOES_NOT_EXIST",
            description = "The specified directory partition does not exist."
        },
        [9902] = {
            id = "DNS_ERROR_DP_ALREADY_EXISTS",
            description = "The specified directory partition already exists."
        },
        [9903] = {
            id = "DNS_ERROR_DP_NOT_ENLISTED",
            description = "This DNS server is not enlisted in the specified directory partition."
        },
        [9904] = {
            id = "DNS_ERROR_DP_ALREADY_ENLISTED",
            description = "This DNS server is already enlisted in the specified directory partition."
        },
        [9905] = {
            id = "DNS_ERROR_DP_NOT_AVAILABLE",
            description = "The directory partition is not available at this time. Please wait a few minutes and try again."
        },
        [9906] = {
            id = "DNS_ERROR_DP_FSMO_ERROR",
            description = "The operation failed because the domain naming master FSMO role could not be reached. The domain controller holding the domain naming master FSMO role is down or unable to service the request or is not running Windows Server 2003 or later."
        },
        [10004] = {
            id = "WSAEINTR",
            description = "A blocking operation was interrupted by a call to WSACancelBlockingCall."
        },
        [10009] = {
            id = "WSAEBADF",
            description = "The file handle supplied is not valid."
        },
        [10013] = {
            id = "WSAEACCES",
            description = "An attempt was made to access a socket in a way forbidden by its access permissions."
        },
        [10014] = {
            id = "WSAEFAULT",
            description = "The system detected an invalid pointer address in attempting to use a pointer argument in a call."
        },
        [10022] = {
            id = "WSAEINVAL",
            description = "An invalid argument was supplied."
        },
        [10024] = {
            id = "WSAEMFILE",
            description = "Too many open sockets."
        },
        [10035] = {
            id = "WSAEWOULDBLOCK",
            description = "A non-blocking socket operation could not be completed immediately."
        },
        [10036] = {
            id = "WSAEINPROGRESS",
            description = "A blocking operation is currently executing."
        },
        [10037] = {
            id = "WSAEALREADY",
            description = "An operation was attempted on a non-blocking socket that already had an operation in progress."
        },
        [10038] = {
            id = "WSAENOTSOCK",
            description = "An operation was attempted on something that is not a socket."
        },
        [10039] = {
            id = "WSAEDESTADDRREQ",
            description = "A required address was omitted from an operation on a socket."
        },
        [10040] = {
            id = "WSAEMSGSIZE",
            description = "A message sent on a datagram socket was larger than the internal message buffer or some other network limit, or the buffer used to receive a datagram into was smaller than the datagram itself."
        },
        [10041] = {
            id = "WSAEPROTOTYPE",
            description = "A protocol was specified in the socket function call that does not support the semantics of the socket type requested."
        },
        [10042] = {
            id = "WSAENOPROTOOPT",
            description = "An unknown, invalid, or unsupported option or level was specified in a getsockopt or setsockopt call."
        },
        [10043] = {
            id = "WSAEPROTONOSUPPORT",
            description = "The requested protocol has not been configured into the system, or no implementation for it exists."
        },
        [10044] = {
            id = "WSAESOCKTNOSUPPORT",
            description = "The support for the specified socket type does not exist in this address family."
        },
        [10045] = {
            id = "WSAEOPNOTSUPP",
            description = "The attempted operation is not supported for the type of object referenced."
        },
        [10046] = {
            id = "WSAEPFNOSUPPORT",
            description = "The protocol family has not been configured into the system or no implementation for it exists."
        },
        [10047] = {
            id = "WSAEAFNOSUPPORT",
            description = "An address incompatible with the requested protocol was used."
        },
        [10048] = {
            id = "WSAEADDRINUSE",
            description = "Only one usage of each socket address (protocol/network address/port) is normally permitted."
        },
        [10049] = {
            id = "WSAEADDRNOTAVAIL",
            description = "The requested address is not valid in its context."
        },
        [10050] = {
            id = "WSAENETDOWN",
            description = "A socket operation encountered a dead network."
        },
        [10051] = {
            id = "WSAENETUNREACH",
            description = "A socket operation was attempted to an unreachable network."
        },
        [10052] = {
            id = "WSAENETRESET",
            description = "The connection has been broken due to keep-alive activity detecting a failure while the operation was in progress."
        },
        [10053] = {
            id = "WSAECONNABORTED",
            description = "An established connection was aborted by the software in your host machine."
        },
        [10054] = {
            id = "WSAECONNRESET",
            description = "An existing connection was forcibly closed by the remote host."
        },
        [10055] = {
            id = "WSAENOBUFS",
            description = "An operation on a socket could not be performed because the system lacked sufficient buffer space or because a queue was full."
        },
        [10056] = {
            id = "WSAEISCONN",
            description = "A connect request was made on an already connected socket."
        },
        [10057] = {
            id = "WSAENOTCONN",
            description = "A request to send or receive data was disallowed because the socket is not connected and (when sending on a datagram socket using a sendto call) no address was supplied."
        },
        [10058] = {
            id = "WSAESHUTDOWN",
            description = "A request to send or receive data was disallowed because the socket had already been shut down in that direction with a previous shutdown call."
        },
        [10059] = {
            id = "WSAETOOMANYREFS",
            description = "Too many references to some kernel object."
        },
        [10060] = {
            id = "WSAETIMEDOUT",
            description = "A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond."
        },
        [10061] = {
            id = "WSAECONNREFUSED",
            description = "No connection could be made because the target machine actively refused it."
        },
        [10062] = {
            id = "WSAELOOP",
            description = "Cannot translate name."
        },
        [10063] = {
            id = "WSAENAMETOOLONG",
            description = "Name component or name was too long."
        },
        [10064] = {
            id = "WSAEHOSTDOWN",
            description = "A socket operation failed because the destination host was down."
        },
        [10065] = {
            id = "WSAEHOSTUNREACH",
            description = "A socket operation was attempted to an unreachable host."
        },
        [10066] = {
            id = "WSAENOTEMPTY",
            description = "Cannot remove a directory that is not empty."
        },
        [10067] = {
            id = "WSAEPROCLIM",
            description = "A Windows Sockets implementation may have a limit on the number of applications that may use it simultaneously."
        },
        [10068] = {
            id = "WSAEUSERS",
            description = "Ran out of quota."
        },
        [10069] = {
            id = "WSAEDQUOT",
            description = "Ran out of disk quota."
        },
        [10070] = {
            id = "WSAESTALE",
            description = "File handle reference is no longer available."
        },
        [10071] = {
            id = "WSAEREMOTE",
            description = "Item is not available locally."
        },
        [10091] = {
            id = "WSASYSNOTREADY",
            description = "WSAStartup cannot function at this time because the underlying system it uses to provide network services is currently unavailable."
        },
        [10092] = {
            id = "WSAVERNOTSUPPORTED",
            description = "The Windows Sockets version requested is not supported."
        },
        [10093] = {
            id = "WSANOTINITIALISED",
            description = "Either the application has not called WSAStartup, or WSAStartup failed."
        },
        [10101] = {
            id = "WSAEDISCON",
            description = "Returned by WSARecv or WSARecvFrom to indicate the remote party has initiated a graceful shutdown sequence."
        },
        [10102] = {
            id = "WSAENOMORE",
            description = "No more results can be returned by WSALookupServiceNext."
        },
        [10103] = {
            id = "WSAECANCELLED",
            description = "A call to WSALookupServiceEnd was made while this call was still processing. The call has been canceled."
        },
        [10104] = {
            id = "WSAEINVALIDPROCTABLE",
            description = "The procedure call table is invalid."
        },
        [10105] = {
            id = "WSAEINVALIDPROVIDER",
            description = "The requested service provider is invalid."
        },
        [10106] = {
            id = "WSAEPROVIDERFAILEDINIT",
            description = "The requested service provider could not be loaded or initialized."
        },
        [10107] = {
            id = "WSASYSCALLFAILURE",
            description = "A system call has failed."
        },
        [10108] = {
            id = "WSASERVICE_NOT_FOUND",
            description = "No such service is known. The service cannot be found in the specified name space."
        },
        [10109] = {
            id = "WSATYPE_NOT_FOUND",
            description = "The specified class was not found."
        },
        [10110] = {
            id = "WSA_E_NO_MORE",
            description = "No more results can be returned by WSALookupServiceNext."
        },
        [10111] = {
            id = "WSA_E_CANCELLED",
            description = "A call to WSALookupServiceEnd was made while this call was still processing. The call has been canceled."
        },
        [10112] = {
            id = "WSAEREFUSED",
            description = "A database query failed because it was actively refused."
        },
        [11001] = {
            id = "WSAHOST_NOT_FOUND",
            description = "No such host is known."
        },
        [11002] = {
            id = "WSATRY_AGAIN",
            description = "This is usually a temporary error during hostname resolution and means that the local server did not receive a response from an authoritative server."
        },
        [11003] = {
            id = "WSANO_RECOVERY",
            description = "A non-recoverable error occurred during a database lookup."
        },
        [11004] = {
            id = "WSANO_DATA",
            description = "The requested name is valid, but no data of the requested type was found."
        },
        [11005] = {
            id = "WSA_QOS_RECEIVERS",
            description = "At least one reserve has arrived."
        },
        [11006] = {
            id = "WSA_QOS_SENDERS",
            description = "At least one path has arrived."
        },
        [11007] = {
            id = "WSA_QOS_NO_SENDERS",
            description = "There are no senders."
        },
        [11008] = {
            id = "WSA_QOS_NO_RECEIVERS",
            description = "There are no receivers."
        },
        [11009] = {
            id = "WSA_QOS_REQUEST_CONFIRMED",
            description = "Reserve has been confirmed."
        },
        [11010] = {
            id = "WSA_QOS_ADMISSION_FAILURE",
            description = "Error due to lack of resources."
        },
        [11011] = {
            id = "WSA_QOS_POLICY_FAILURE",
            description = "Rejected for administrative reasons - bad credentials."
        },
        [11012] = {
            id = "WSA_QOS_BAD_STYLE",
            description = "Unknown or conflicting style."
        },
        [11013] = {
            id = "WSA_QOS_BAD_OBJECT",
            description = "Problem with some part of the filterspec or providerspecific buffer in general."
        },
        [11014] = {
            id = "WSA_QOS_TRAFFIC_CTRL_ERROR",
            description = "Problem with some part of the flowspec."
        },
        [11015] = {
            id = "WSA_QOS_GENERIC_ERROR",
            description = "General QOS error."
        },
        [11016] = {
            id = "WSA_QOS_ESERVICETYPE",
            description = "An invalid or unrecognized service type was found in the flowspec."
        },
        [11017] = {
            id = "WSA_QOS_EFLOWSPEC",
            description = "An invalid or inconsistent flowspec was found in the QOS structure."
        },
        [11018] = {
            id = "WSA_QOS_EPROVSPECBUF",
            description = "Invalid QOS provider-specific buffer."
        },
        [11019] = {
            id = "WSA_QOS_EFILTERSTYLE",
            description = "An invalid QOS filter style was used."
        },
        [11020] = {
            id = "WSA_QOS_EFILTERTYPE",
            description = "An invalid QOS filter type was used."
        },
        [11021] = {
            id = "WSA_QOS_EFILTERCOUNT",
            description = "An incorrect number of QOS FILTERSPECs were specified in the FLOWDESCRIPTOR."
        },
        [11022] = {
            id = "WSA_QOS_EOBJLENGTH",
            description = "An object with an invalid ObjectLength field was specified in the QOS provider-specific buffer."
        },
        [11023] = {
            id = "WSA_QOS_EFLOWCOUNT",
            description = "An incorrect number of flow descriptors was specified in the QOS structure."
        },
        [11024] = {
            id = "WSA_QOS_EUNKOWNPSOBJ",
            description = "An unrecognized object was found in the QOS provider-specific buffer."
        },
        [11025] = {
            id = "WSA_QOS_EPOLICYOBJ",
            description = "An invalid policy object was found in the QOS provider-specific buffer."
        },
        [11026] = {
            id = "WSA_QOS_EFLOWDESC",
            description = "An invalid QOS flow descriptor was found in the flow descriptor list."
        },
        [11027] = {
            id = "WSA_QOS_EPSFLOWSPEC",
            description = "An invalid or inconsistent flowspec was found in the QOS provider specific buffer."
        },
        [11028] = {
            id = "WSA_QOS_EPSFILTERSPEC",
            description = "An invalid FILTERSPEC was found in the QOS provider-specific buffer."
        },
        [11029] = {
            id = "WSA_QOS_ESDMODEOBJ",
            description = "An invalid shape discard mode object was found in the QOS provider specific buffer."
        },
        [11030] = {
            id = "WSA_QOS_ESHAPERATEOBJ",
            description = "An invalid shaping rate object was found in the QOS provider-specific buffer."
        },
        [11031] = {
            id = "WSA_QOS_RESERVED_PETYPE",
            description = "A reserved policy element was found in the QOS provider-specific buffer."
        },
        [11032] = {
            id = "WSA_SECURE_HOST_NOT_FOUND",
            description = "No such host is known securely."
        },
        [11033] = {
            id = "WSA_IPSEC_NAME_POLICY_ERROR",
            description = "Name based IPSEC policy could not be added."
        },
        [12000] = {
            id = "ERROR_INTERNET_*",
            description = "See Internet Error Codes and WinInet.h."
        },
        [13000] = {
            id = "ERROR_IPSEC_QM_POLICY_EXISTS",
            description = "The specified quick mode policy already exists."
        },
        [13001] = {
            id = "ERROR_IPSEC_QM_POLICY_NOT_FOUND",
            description = "The specified quick mode policy was not found."
        },
        [13002] = {
            id = "ERROR_IPSEC_QM_POLICY_IN_USE",
            description = "The specified quick mode policy is being used."
        },
        [13003] = {
            id = "ERROR_IPSEC_MM_POLICY_EXISTS",
            description = "The specified main mode policy already exists."
        },
        [13004] = {
            id = "ERROR_IPSEC_MM_POLICY_NOT_FOUND",
            description = "The specified main mode policy was not found."
        },
        [13005] = {
            id = "ERROR_IPSEC_MM_POLICY_IN_USE",
            description = "The specified main mode policy is being used."
        },
        [13006] = {
            id = "ERROR_IPSEC_MM_FILTER_EXISTS",
            description = "The specified main mode filter already exists."
        },
        [13007] = {
            id = "ERROR_IPSEC_MM_FILTER_NOT_FOUND",
            description = "The specified main mode filter was not found."
        },
        [13008] = {
            id = "ERROR_IPSEC_TRANSPORT_FILTER_EXISTS",
            description = "The specified transport mode filter already exists."
        },
        [13009] = {
            id = "ERROR_IPSEC_TRANSPORT_FILTER_NOT_FOUND",
            description = "The specified transport mode filter does not exist."
        },
        [13010] = {
            id = "ERROR_IPSEC_MM_AUTH_EXISTS",
            description = "The specified main mode authentication list exists."
        },
        [13011] = {
            id = "ERROR_IPSEC_MM_AUTH_NOT_FOUND",
            description = "The specified main mode authentication list was not found."
        },
        [13012] = {
            id = "ERROR_IPSEC_MM_AUTH_IN_USE",
            description = "The specified main mode authentication list is being used."
        },
        [13013] = {
            id = "ERROR_IPSEC_DEFAULT_MM_POLICY_NOT_FOUND",
            description = "The specified default main mode policy was not found."
        },
        [13014] = {
            id = "ERROR_IPSEC_DEFAULT_MM_AUTH_NOT_FOUND",
            description = "The specified default main mode authentication list was not found."
        },
        [13015] = {
            id = "ERROR_IPSEC_DEFAULT_QM_POLICY_NOT_FOUND",
            description = "The specified default quick mode policy was not found."
        },
        [13016] = {
            id = "ERROR_IPSEC_TUNNEL_FILTER_EXISTS",
            description = "The specified tunnel mode filter exists."
        },
        [13017] = {
            id = "ERROR_IPSEC_TUNNEL_FILTER_NOT_FOUND",
            description = "The specified tunnel mode filter was not found."
        },
        [13018] = {
            id = "ERROR_IPSEC_MM_FILTER_PENDING_DELETION",
            description = "The Main Mode filter is pending deletion."
        },
        [13019] = {
            id = "ERROR_IPSEC_TRANSPORT_FILTER_PENDING_DELETION",
            description = "The transport filter is pending deletion."
        },
        [13020] = {
            id = "ERROR_IPSEC_TUNNEL_FILTER_PENDING_DELETION",
            description = "The tunnel filter is pending deletion."
        },
        [13021] = {
            id = "ERROR_IPSEC_MM_POLICY_PENDING_DELETION",
            description = "The Main Mode policy is pending deletion."
        },
        [13022] = {
            id = "ERROR_IPSEC_MM_AUTH_PENDING_DELETION",
            description = "The Main Mode authentication bundle is pending deletion."
        },
        [13023] = {
            id = "ERROR_IPSEC_QM_POLICY_PENDING_DELETION",
            description = "The Quick Mode policy is pending deletion."
        },
        [13024] = {
            id = "WARNING_IPSEC_MM_POLICY_PRUNED",
            description = "The Main Mode policy was successfully added, but some of the requested offers are not supported."
        },
        [13025] = {
            id = "WARNING_IPSEC_QM_POLICY_PRUNED",
            description = "The Quick Mode policy was successfully added, but some of the requested offers are not supported."
        },
        [13800] = {
            id = "ERROR_IPSEC_IKE_NEG_STATUS_BEGIN",
            description = "ERROR_IPSEC_IKE_NEG_STATUS_BEGIN"
        },
        [13801] = {
            id = "ERROR_IPSEC_IKE_AUTH_FAIL",
            description = "IKE authentication credentials are unacceptable."
        },
        [13802] = {
            id = "ERROR_IPSEC_IKE_ATTRIB_FAIL",
            description = "IKE security attributes are unacceptable."
        },
        [13803] = {
            id = "ERROR_IPSEC_IKE_NEGOTIATION_PENDING",
            description = "IKE Negotiation in progress."
        },
        [13804] = {
            id = "ERROR_IPSEC_IKE_GENERAL_PROCESSING_ERROR",
            description = "General processing error."
        },
        [13805] = {
            id = "ERROR_IPSEC_IKE_TIMED_OUT",
            description = "Negotiation timed out."
        },
        [13806] = {
            id = "ERROR_IPSEC_IKE_NO_CERT",
            description = "IKE failed to find valid machine certificate. Contact your Network Security Administrator about installing a valid certificate in the appropriate Certificate Store."
        },
        [13807] = {
            id = "ERROR_IPSEC_IKE_SA_DELETED",
            description = "IKE SA deleted by peer before establishment completed."
        },
        [13808] = {
            id = "ERROR_IPSEC_IKE_SA_REAPED",
            description = "IKE SA deleted before establishment completed."
        },
        [13809] = {
            id = "ERROR_IPSEC_IKE_MM_ACQUIRE_DROP",
            description = "Negotiation request sat in Queue too long."
        },
        [13810] = {
            id = "ERROR_IPSEC_IKE_QM_ACQUIRE_DROP",
            description = "Negotiation request sat in Queue too long."
        },
        [13811] = {
            id = "ERROR_IPSEC_IKE_QUEUE_DROP_MM",
            description = "Negotiation request sat in Queue too long."
        },
        [13812] = {
            id = "ERROR_IPSEC_IKE_QUEUE_DROP_NO_MM",
            description = "Negotiation request sat in Queue too long."
        },
        [13813] = {
            id = "ERROR_IPSEC_IKE_DROP_NO_RESPONSE",
            description = "No response from peer."
        },
        [13814] = {
            id = "ERROR_IPSEC_IKE_MM_DELAY_DROP",
            description = "Negotiation took too long."
        },
        [13815] = {
            id = "ERROR_IPSEC_IKE_QM_DELAY_DROP",
            description = "Negotiation took too long."
        },
        [13816] = {
            id = "ERROR_IPSEC_IKE_ERROR",
            description = "Unknown error occurred."
        },
        [13817] = {
            id = "ERROR_IPSEC_IKE_CRL_FAILED",
            description = "Certificate Revocation Check failed."
        },
        [13818] = {
            id = "ERROR_IPSEC_IKE_INVALID_KEY_USAGE",
            description = "Invalid certificate key usage."
        },
        [13819] = {
            id = "ERROR_IPSEC_IKE_INVALID_CERT_TYPE",
            description = "Invalid certificate type."
        },
        [13820] = {
            id = "ERROR_IPSEC_IKE_NO_PRIVATE_KEY",
            description = "IKE negotiation failed because the machine certificate used does not have a private key. IPsec certificates require a private key. Contact your Network Security administrator about replacing with a certificate that has a private key."
        },
        [13821] = {
            id = "ERROR_IPSEC_IKE_SIMULTANEOUS_REKEY",
            description = "Simultaneous rekeys were detected."
        },
        [13822] = {
            id = "ERROR_IPSEC_IKE_DH_FAIL",
            description = "Failure in Diffie-Hellman computation."
        },
        [13823] = {
            id = "ERROR_IPSEC_IKE_CRITICAL_PAYLOAD_NOT_RECOGNIZED",
            description = "Don't know how to process critical payload."
        },
        [13824] = {
            id = "ERROR_IPSEC_IKE_INVALID_HEADER",
            description = "Invalid header."
        },
        [13825] = {
            id = "ERROR_IPSEC_IKE_NO_POLICY",
            description = "No policy configured."
        },
        [13826] = {
            id = "ERROR_IPSEC_IKE_INVALID_SIGNATURE",
            description = "Failed to verify signature."
        },
        [13827] = {
            id = "ERROR_IPSEC_IKE_KERBEROS_ERROR",
            description = "Failed to authenticate using Kerberos."
        },
        [13828] = {
            id = "ERROR_IPSEC_IKE_NO_PUBLIC_KEY",
            description = "Peer's certificate did not have a public key."
        },
        [13829] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR",
            description = "Error processing error payload."
        },
        [13830] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_SA",
            description = "Error processing SA payload."
        },
        [13831] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_PROP",
            description = "Error processing Proposal payload."
        },
        [13832] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_TRANS",
            description = "Error processing Transform payload."
        },
        [13833] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_KE",
            description = "Error processing KE payload."
        },
        [13834] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_ID",
            description = "Error processing ID payload."
        },
        [13835] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_CERT",
            description = "Error processing Cert payload."
        },
        [13836] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_CERT_REQ",
            description = "Error processing Certificate Request payload."
        },
        [13837] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_HASH",
            description = "Error processing Hash payload."
        },
        [13838] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_SIG",
            description = "Error processing Signature payload."
        },
        [13839] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_NONCE",
            description = "Error processing Nonce payload."
        },
        [13840] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_NOTIFY",
            description = "Error processing Notify payload."
        },
        [13841] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_DELETE",
            description = "Error processing Delete Payload."
        },
        [13842] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_VENDOR",
            description = "Error processing VendorId payload."
        },
        [13843] = {
            id = "ERROR_IPSEC_IKE_INVALID_PAYLOAD",
            description = "Invalid payload received."
        },
        [13844] = {
            id = "ERROR_IPSEC_IKE_LOAD_SOFT_SA",
            description = "Soft SA loaded."
        },
        [13845] = {
            id = "ERROR_IPSEC_IKE_SOFT_SA_TORN_DOWN",
            description = "Soft SA torn down."
        },
        [13846] = {
            id = "ERROR_IPSEC_IKE_INVALID_COOKIE",
            description = "Invalid cookie received."
        },
        [13847] = {
            id = "ERROR_IPSEC_IKE_NO_PEER_CERT",
            description = "Peer failed to send valid machine certificate."
        },
        [13848] = {
            id = "ERROR_IPSEC_IKE_PEER_CRL_FAILED",
            description = "Certification Revocation check of peer's certificate failed."
        },
        [13849] = {
            id = "ERROR_IPSEC_IKE_POLICY_CHANGE",
            description = "New policy invalidated SAs formed with old policy."
        },
        [13850] = {
            id = "ERROR_IPSEC_IKE_NO_MM_POLICY",
            description = "There is no available Main Mode IKE policy."
        },
        [13851] = {
            id = "ERROR_IPSEC_IKE_NOTCBPRIV",
            description = "Failed to enabled TCB privilege."
        },
        [13852] = {
            id = "ERROR_IPSEC_IKE_SECLOADFAIL",
            description = "Failed to load SECURITY.DLL."
        },
        [13853] = {
            id = "ERROR_IPSEC_IKE_FAILSSPINIT",
            description = "Failed to obtain security function table dispatch address from SSPI."
        },
        [13854] = {
            id = "ERROR_IPSEC_IKE_FAILQUERYSSP",
            description = "Failed to query Kerberos package to obtain max token size."
        },
        [13855] = {
            id = "ERROR_IPSEC_IKE_SRVACQFAIL",
            description = "Failed to obtain Kerberos server credentials for ISAKMP/ERROR_IPSEC_IKE service. Kerberos authentication will not function. The most likely reason for this is lack of domain membership. This is normal if your computer is a member of a workgroup."
        },
        [13856] = {
            id = "ERROR_IPSEC_IKE_SRVQUERYCRED",
            description = "Failed to determine SSPI principal name for ISAKMP/ERROR_IPSEC_IKE service (QueryCredentialsAttributes)."
        },
        [13857] = {
            id = "ERROR_IPSEC_IKE_GETSPIFAIL",
            description = "Failed to obtain new SPI for the inbound SA from IPsec driver. The most common cause for this is that the driver does not have the correct filter. Check your policy to verify the filters."
        },
        [13858] = {
            id = "ERROR_IPSEC_IKE_INVALID_FILTER",
            description = "Given filter is invalid."
        },
        [13859] = {
            id = "ERROR_IPSEC_IKE_OUT_OF_MEMORY",
            description = "Memory allocation failed."
        },
        [13860] = {
            id = "ERROR_IPSEC_IKE_ADD_UPDATE_KEY_FAILED",
            description = "Failed to add Security Association to IPsec Driver. The most common cause for this is if the IKE negotiation took too long to complete. If the problem persists, reduce the load on the faulting machine."
        },
        [13861] = {
            id = "ERROR_IPSEC_IKE_INVALID_POLICY",
            description = "Invalid policy."
        },
        [13862] = {
            id = "ERROR_IPSEC_IKE_UNKNOWN_DOI",
            description = "Invalid DOI."
        },
        [13863] = {
            id = "ERROR_IPSEC_IKE_INVALID_SITUATION",
            description = "Invalid situation."
        },
        [13864] = {
            id = "ERROR_IPSEC_IKE_DH_FAILURE",
            description = "Diffie-Hellman failure."
        },
        [13865] = {
            id = "ERROR_IPSEC_IKE_INVALID_GROUP",
            description = "Invalid Diffie-Hellman group."
        },
        [13866] = {
            id = "ERROR_IPSEC_IKE_ENCRYPT",
            description = "Error encrypting payload."
        },
        [13867] = {
            id = "ERROR_IPSEC_IKE_DECRYPT",
            description = "Error decrypting payload."
        },
        [13868] = {
            id = "ERROR_IPSEC_IKE_POLICY_MATCH",
            description = "Policy match error."
        },
        [13869] = {
            id = "ERROR_IPSEC_IKE_UNSUPPORTED_ID",
            description = "Unsupported ID."
        },
        [13870] = {
            id = "ERROR_IPSEC_IKE_INVALID_HASH",
            description = "Hash verification failed."
        },
        [13871] = {
            id = "ERROR_IPSEC_IKE_INVALID_HASH_ALG",
            description = "Invalid hash algorithm."
        },
        [13872] = {
            id = "ERROR_IPSEC_IKE_INVALID_HASH_SIZE",
            description = "Invalid hash size."
        },
        [13873] = {
            id = "ERROR_IPSEC_IKE_INVALID_ENCRYPT_ALG",
            description = "Invalid encryption algorithm."
        },
        [13874] = {
            id = "ERROR_IPSEC_IKE_INVALID_AUTH_ALG",
            description = "Invalid authentication algorithm."
        },
        [13875] = {
            id = "ERROR_IPSEC_IKE_INVALID_SIG",
            description = "Invalid certificate signature."
        },
        [13876] = {
            id = "ERROR_IPSEC_IKE_LOAD_FAILED",
            description = "Load failed."
        },
        [13877] = {
            id = "ERROR_IPSEC_IKE_RPC_DELETE",
            description = "Deleted via RPC call."
        },
        [13878] = {
            id = "ERROR_IPSEC_IKE_BENIGN_REINIT",
            description = "Temporary state created to perform reinitialization. This is not a real failure."
        },
        [13879] = {
            id = "ERROR_IPSEC_IKE_INVALID_RESPONDER_LIFETIME_NOTIFY",
            description = "The lifetime value received in the Responder Lifetime Notify is below the Windows 2000 configured minimum value. Please fix the policy on the peer machine."
        },
        [13880] = {
            id = "ERROR_IPSEC_IKE_INVALID_MAJOR_VERSION",
            description = "The recipient cannot handle version of IKE specified in the header."
        },
        [13881] = {
            id = "ERROR_IPSEC_IKE_INVALID_CERT_KEYLEN",
            description = "Key length in certificate is too small for configured security requirements."
        },
        [13882] = {
            id = "ERROR_IPSEC_IKE_MM_LIMIT",
            description = "Max number of established MM SAs to peer exceeded."
        },
        [13883] = {
            id = "ERROR_IPSEC_IKE_NEGOTIATION_DISABLED",
            description = "IKE received a policy that disables negotiation."
        },
        [13884] = {
            id = "ERROR_IPSEC_IKE_QM_LIMIT",
            description = "Reached maximum quick mode limit for the main mode. New main mode will be started."
        },
        [13885] = {
            id = "ERROR_IPSEC_IKE_MM_EXPIRED",
            description = "Main mode SA lifetime expired or peer sent a main mode delete."
        },
        [13886] = {
            id = "ERROR_IPSEC_IKE_PEER_MM_ASSUMED_INVALID",
            description = "Main mode SA assumed to be invalid because peer stopped responding."
        },
        [13887] = {
            id = "ERROR_IPSEC_IKE_CERT_CHAIN_POLICY_MISMATCH",
            description = "Certificate doesn't chain to a trusted root in IPsec policy."
        },
        [13888] = {
            id = "ERROR_IPSEC_IKE_UNEXPECTED_MESSAGE_ID",
            description = "Received unexpected message ID."
        },
        [13889] = {
            id = "ERROR_IPSEC_IKE_INVALID_AUTH_PAYLOAD",
            description = "Received invalid authentication offers."
        },
        [13890] = {
            id = "ERROR_IPSEC_IKE_DOS_COOKIE_SENT",
            description = "Sent DoS cookie notify to initiator."
        },
        [13891] = {
            id = "ERROR_IPSEC_IKE_SHUTTING_DOWN",
            description = "IKE service is shutting down."
        },
        [13892] = {
            id = "ERROR_IPSEC_IKE_CGA_AUTH_FAILED",
            description = "Could not verify binding between CGA address and certificate."
        },
        [13893] = {
            id = "ERROR_IPSEC_IKE_PROCESS_ERR_NATOA",
            description = "Error processing NatOA payload."
        },
        [13894] = {
            id = "ERROR_IPSEC_IKE_INVALID_MM_FOR_QM",
            description = "Parameters of the main mode are invalid for this quick mode."
        },
        [13895] = {
            id = "ERROR_IPSEC_IKE_QM_EXPIRED",
            description = "Quick mode SA was expired by IPsec driver."
        },
        [13896] = {
            id = "ERROR_IPSEC_IKE_TOO_MANY_FILTERS",
            description = "Too many dynamically added IKEEXT filters were detected."
        },
        [13897] = {
            id = "ERROR_IPSEC_IKE_NEG_STATUS_END",
            description = "ERROR_IPSEC_IKE_NEG_STATUS_END"
        },
        [13898] = {
            id = "ERROR_IPSEC_IKE_KILL_DUMMY_NAP_TUNNEL",
            description = "NAP reauth succeeded and must delete the dummy NAP IKEv2 tunnel."
        },
        [13899] = {
            id = "ERROR_IPSEC_IKE_INNER_IP_ASSIGNMENT_FAILURE",
            description = "Error in assigning inner IP address to initiator in tunnel mode."
        },
        [13900] = {
            id = "ERROR_IPSEC_IKE_REQUIRE_CP_PAYLOAD_MISSING",
            description = "Require configuration payload missing."
        },
        [13901] = {
            id = "ERROR_IPSEC_KEY_MODULE_IMPERSONATION_NEGOTIATION_PENDING",
            description = "A negotiation running as the security principle who issued the connection is in progress."
        },
        [13902] = {
            id = "ERROR_IPSEC_IKE_COEXISTENCE_SUPPRESS",
            description = "SA was deleted due to IKEv1/AuthIP co-existence suppress check."
        },
        [13903] = {
            id = "ERROR_IPSEC_IKE_RATELIMIT_DROP",
            description = "Incoming SA request was dropped due to peer IP address rate limiting."
        },
        [13904] = {
            id = "ERROR_IPSEC_IKE_PEER_DOESNT_SUPPORT_MOBIKE",
            description = "Peer does not support MOBIKE."
        },
        [13905] = {
            id = "ERROR_IPSEC_IKE_AUTHORIZATION_FAILURE",
            description = "SA establishment is not authorized."
        },
        [13906] = {
            id = "ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_FAILURE",
            description = "SA establishment is not authorized because there is not a sufficiently strong PKINIT-based credential."
        },
        [13907] = {
            id = "ERROR_IPSEC_IKE_AUTHORIZATION_FAILURE_WITH_OPTIONAL_RETRY",
            description = "SA establishment is not authorized. You may need to enter updated or different credentials such as a smartcard."
        },
        [13908] = {
            id = "ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_AND_CERTMAP_FAILURE",
            description = "SA establishment is not authorized because there is not a sufficiently strong PKINIT-based credential. This might be related to certificate-to-account mapping failure for the SA."
        },
        [13909] = {
            id = "ERROR_IPSEC_IKE_NEG_STATUS_EXTENDED_END",
            description = "ERROR_IPSEC_IKE_NEG_STATUS_EXTENDED_END"
        },
        [13910] = {
            id = "ERROR_IPSEC_BAD_SPI",
            description = "The SPI in the packet does not match a valid IPsec SA."
        },
        [13911] = {
            id = "ERROR_IPSEC_SA_LIFETIME_EXPIRED",
            description = "Packet was received on an IPsec SA whose lifetime has expired."
        },
        [13912] = {
            id = "ERROR_IPSEC_WRONG_SA",
            description = "Packet was received on an IPsec SA that does not match the packet characteristics."
        },
        [13913] = {
            id = "ERROR_IPSEC_REPLAY_CHECK_FAILED",
            description = "Packet sequence number replay check failed."
        },
        [13914] = {
            id = "ERROR_IPSEC_INVALID_PACKET",
            description = "IPsec header and/or trailer in the packet is invalid."
        },
        [13915] = {
            id = "ERROR_IPSEC_INTEGRITY_CHECK_FAILED",
            description = "IPsec integrity check failed."
        },
        [13916] = {
            id = "ERROR_IPSEC_CLEAR_TEXT_DROP",
            description = "IPsec dropped a clear text packet."
        },
        [13917] = {
            id = "ERROR_IPSEC_AUTH_FIREWALL_DROP",
            description = "IPsec dropped an incoming ESP packet in authenticated firewall mode. This drop is benign."
        },
        [13918] = {
            id = "ERROR_IPSEC_THROTTLE_DROP",
            description = "IPsec dropped a packet due to DoS throttling."
        },
        [13925] = {
            id = "ERROR_IPSEC_DOSP_BLOCK",
            description = "IPsec DoS Protection matched an explicit block rule."
        },
        [13926] = {
            id = "ERROR_IPSEC_DOSP_RECEIVED_MULTICAST",
            description = "IPsec DoS Protection received an IPsec specific multicast packet which is not allowed."
        },
        [13927] = {
            id = "ERROR_IPSEC_DOSP_INVALID_PACKET",
            description = "IPsec DoS Protection received an incorrectly formatted packet."
        },
        [13928] = {
            id = "ERROR_IPSEC_DOSP_STATE_LOOKUP_FAILED",
            description = "IPsec DoS Protection failed to look up state."
        },
        [13929] = {
            id = "ERROR_IPSEC_DOSP_MAX_ENTRIES",
            description = "IPsec DoS Protection failed to create state because the maximum number of entries allowed by policy has been reached."
        },
        [13930] = {
            id = "ERROR_IPSEC_DOSP_KEYMOD_NOT_ALLOWED",
            description = "IPsec DoS Protection received an IPsec negotiation packet for a keying module which is not allowed by policy."
        },
        [13931] = {
            id = "ERROR_IPSEC_DOSP_NOT_INSTALLED",
            description = "IPsec DoS Protection has not been enabled."
        },
        [13932] = {
            id = "ERROR_IPSEC_DOSP_MAX_PER_IP_RATELIMIT_QUEUES",
            description = "IPsec DoS Protection failed to create a per internal IP rate limit queue because the maximum number of queues allowed by policy has been reached."
        },
        [14000] = {
            id = "ERROR_SXS_SECTION_NOT_FOUND",
            description = "The requested section was not present in the activation context."
        },
        [14001] = {
            id = "ERROR_SXS_CANT_GEN_ACTCTX",
            description = "The application has failed to start because its side-by-side configuration is incorrect. Please see the application event log or use the command-line sxstrace.exe tool for more detail."
        },
        [14002] = {
            id = "ERROR_SXS_INVALID_ACTCTXDATA_FORMAT",
            description = "The application binding data format is invalid."
        },
        [14003] = {
            id = "ERROR_SXS_ASSEMBLY_NOT_FOUND",
            description = "The referenced assembly is not installed on your system."
        },
        [14004] = {
            id = "ERROR_SXS_MANIFEST_FORMAT_ERROR",
            description = "The manifest file does not begin with the required tag and format information."
        },
        [14005] = {
            id = "ERROR_SXS_MANIFEST_PARSE_ERROR",
            description = "The manifest file contains one or more syntax errors."
        },
        [14006] = {
            id = "ERROR_SXS_ACTIVATION_CONTEXT_DISABLED",
            description = "The application attempted to activate a disabled activation context."
        },
        [14007] = {
            id = "ERROR_SXS_KEY_NOT_FOUND",
            description = "The requested lookup key was not found in any active activation context."
        },
        [14008] = {
            id = "ERROR_SXS_VERSION_CONFLICT",
            description = "A component version required by the application conflicts with another component version already active."
        },
        [14009] = {
            id = "ERROR_SXS_WRONG_SECTION_TYPE",
            description = "The type requested activation context section does not match the query API used."
        },
        [14010] = {
            id = "ERROR_SXS_THREAD_QUERIES_DISABLED",
            description = "Lack of system resources has required isolated activation to be disabled for the current thread of execution."
        },
        [14011] = {
            id = "ERROR_SXS_PROCESS_DEFAULT_ALREADY_SET",
            description = "An attempt to set the process default activation context failed because the process default activation context was already set."
        },
        [14012] = {
            id = "ERROR_SXS_UNKNOWN_ENCODING_GROUP",
            description = "The encoding group identifier specified is not recognized."
        },
        [14013] = {
            id = "ERROR_SXS_UNKNOWN_ENCODING",
            description = "The encoding requested is not recognized."
        },
        [14014] = {
            id = "ERROR_SXS_INVALID_XML_NAMESPACE_URI",
            description = "The manifest contains a reference to an invalid URI."
        },
        [14015] = {
            id = "ERROR_SXS_ROOT_MANIFEST_DEPENDENCY_NOT_INSTALLED",
            description = "The application manifest contains a reference to a dependent assembly which is not installed."
        },
        [14016] = {
            id = "ERROR_SXS_LEAF_MANIFEST_DEPENDENCY_NOT_INSTALLED",
            description = "The manifest for an assembly used by the application has a reference to a dependent assembly which is not installed."
        },
        [14017] = {
            id = "ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE",
            description = "The manifest contains an attribute for the assembly identity which is not valid."
        },
        [14018] = {
            id = "ERROR_SXS_MANIFEST_MISSING_REQUIRED_DEFAULT_NAMESPACE",
            description = "The manifest is missing the required default namespace specification on the assembly element."
        },
        [14019] = {
            id = "ERROR_SXS_MANIFEST_INVALID_REQUIRED_DEFAULT_NAMESPACE",
            description = "The manifest has a default namespace specified on the assembly element but its value is not \"urn:schemas-microsoft-com:asm.v1\"."
        },
        [14020] = {
            id = "ERROR_SXS_PRIVATE_MANIFEST_CROSS_PATH_WITH_REPARSE_POINT",
            description = "The private manifest probed has crossed a path with an unsupported reparse point."
        },
        [14021] = {
            id = "ERROR_SXS_DUPLICATE_DLL_NAME",
            description = "Two or more components referenced directly or indirectly by the application manifest have files by the same name."
        },
        [14022] = {
            id = "ERROR_SXS_DUPLICATE_WINDOWCLASS_NAME",
            description = "Two or more components referenced directly or indirectly by the application manifest have window classes with the same name."
        },
        [14023] = {
            id = "ERROR_SXS_DUPLICATE_CLSID",
            description = "Two or more components referenced directly or indirectly by the application manifest have the same COM server CLSIDs."
        },
        [14024] = {
            id = "ERROR_SXS_DUPLICATE_IID",
            description = "Two or more components referenced directly or indirectly by the application manifest have proxies for the same COM interface IIDs."
        },
        [14025] = {
            id = "ERROR_SXS_DUPLICATE_TLBID",
            description = "Two or more components referenced directly or indirectly by the application manifest have the same COM type library TLBIDs."
        },
        [14026] = {
            id = "ERROR_SXS_DUPLICATE_PROGID",
            description = "Two or more components referenced directly or indirectly by the application manifest have the same COM ProgIDs."
        },
        [14027] = {
            id = "ERROR_SXS_DUPLICATE_ASSEMBLY_NAME",
            description = "Two or more components referenced directly or indirectly by the application manifest are different versions of the same component which is not permitted."
        },
        [14028] = {
            id = "ERROR_SXS_FILE_HASH_MISMATCH",
            description = "A component's file does not match the verification information present in the component manifest."
        },
        [14029] = {
            id = "ERROR_SXS_POLICY_PARSE_ERROR",
            description = "The policy manifest contains one or more syntax errors."
        },
        [14030] = {
            id = "ERROR_SXS_XML_E_MISSINGQUOTE",
            description = "Manifest Parse Error : A string literal was expected, but no opening quote character was found."
        },
        [14031] = {
            id = "ERROR_SXS_XML_E_COMMENTSYNTAX",
            description = "Manifest Parse Error : Incorrect syntax was used in a comment."
        },
        [14032] = {
            id = "ERROR_SXS_XML_E_BADSTARTNAMECHAR",
            description = "Manifest Parse Error : A name was started with an invalid character."
        },
        [14033] = {
            id = "ERROR_SXS_XML_E_BADNAMECHAR",
            description = "Manifest Parse Error : A name contained an invalid character."
        },
        [14034] = {
            id = "ERROR_SXS_XML_E_BADCHARINSTRING",
            description = "Manifest Parse Error : A string literal contained an invalid character."
        },
        [14035] = {
            id = "ERROR_SXS_XML_E_XMLDECLSYNTAX",
            description = "Manifest Parse Error : Invalid syntax for an xml declaration."
        },
        [14036] = {
            id = "ERROR_SXS_XML_E_BADCHARDATA",
            description = "Manifest Parse Error : An Invalid character was found in text content."
        },
        [14037] = {
            id = "ERROR_SXS_XML_E_MISSINGWHITESPACE",
            description = "Manifest Parse Error : Required white space was missing."
        },
        [14038] = {
            id = "ERROR_SXS_XML_E_EXPECTINGTAGEND",
            description = "Manifest Parse Error : The character '>' was expected."
        },
        [14039] = {
            id = "ERROR_SXS_XML_E_MISSINGSEMICOLON",
            description = "Manifest Parse Error : A semi colon character was expected."
        },
        [14040] = {
            id = "ERROR_SXS_XML_E_UNBALANCEDPAREN",
            description = "Manifest Parse Error : Unbalanced parentheses."
        },
        [14041] = {
            id = "ERROR_SXS_XML_E_INTERNALERROR",
            description = "Manifest Parse Error : Internal error."
        },
        [14042] = {
            id = "ERROR_SXS_XML_E_UNEXPECTED_WHITESPACE",
            description = "Manifest Parse Error : Whitespace is not allowed at this location."
        },
        [14043] = {
            id = "ERROR_SXS_XML_E_INCOMPLETE_ENCODING",
            description = "Manifest Parse Error : End of file reached in invalid state for current encoding."
        },
        [14044] = {
            id = "ERROR_SXS_XML_E_MISSING_PAREN",
            description = "Manifest Parse Error : Missing parenthesis."
        },
        [14045] = {
            id = "ERROR_SXS_XML_E_EXPECTINGCLOSEQUOTE",
            description = "Manifest Parse Error : A single or double closing quote character (\' or \") is missing."
        },
        [14046] = {
            id = "ERROR_SXS_XML_E_MULTIPLE_COLONS",
            description = "Manifest Parse Error : Multiple colons are not allowed in a name."
        },
        [14047] = {
            id = "ERROR_SXS_XML_E_INVALID_DECIMAL",
            description = "Manifest Parse Error : Invalid character for decimal digit."
        },
        [14048] = {
            id = "ERROR_SXS_XML_E_INVALID_HEXIDECIMAL",
            description = "Manifest Parse Error : Invalid character for hexadecimal digit."
        },
        [14049] = {
            id = "ERROR_SXS_XML_E_INVALID_UNICODE",
            description = "Manifest Parse Error : Invalid unicode character value for this platform."
        },
        [14050] = {
            id = "ERROR_SXS_XML_E_WHITESPACEORQUESTIONMARK",
            description = "Manifest Parse Error : Expecting whitespace or '?'."
        },
        [14051] = {
            id = "ERROR_SXS_XML_E_UNEXPECTEDENDTAG",
            description = "Manifest Parse Error : End tag was not expected at this location."
        },
        [14052] = {
            id = "ERROR_SXS_XML_E_UNCLOSEDTAG",
            description = "Manifest Parse Error : The following tags were not closed: %1."
        },
        [14053] = {
            id = "ERROR_SXS_XML_E_DUPLICATEATTRIBUTE",
            description = "Manifest Parse Error : Duplicate attribute."
        },
        [14054] = {
            id = "ERROR_SXS_XML_E_MULTIPLEROOTS",
            description = "Manifest Parse Error : Only one top level element is allowed in an XML document."
        },
        [14055] = {
            id = "ERROR_SXS_XML_E_INVALIDATROOTLEVEL",
            description = "Manifest Parse Error : Invalid at the top level of the document."
        },
        [14056] = {
            id = "ERROR_SXS_XML_E_BADXMLDECL",
            description = "Manifest Parse Error : Invalid xml declaration."
        },
        [14057] = {
            id = "ERROR_SXS_XML_E_MISSINGROOT",
            description = "Manifest Parse Error : XML document must have a top level element."
        },
        [14058] = {
            id = "ERROR_SXS_XML_E_UNEXPECTEDEOF",
            description = "Manifest Parse Error : Unexpected end of file."
        },
        [14059] = {
            id = "ERROR_SXS_XML_E_BADPEREFINSUBSET",
            description = "Manifest Parse Error : Parameter entities cannot be used inside markup declarations in an internal subset."
        },
        [14060] = {
            id = "ERROR_SXS_XML_E_UNCLOSEDSTARTTAG",
            description = "Manifest Parse Error : Element was not closed."
        },
        [14061] = {
            id = "ERROR_SXS_XML_E_UNCLOSEDENDTAG",
            description = "Manifest Parse Error : End element was missing the character '>'."
        },
        [14062] = {
            id = "ERROR_SXS_XML_E_UNCLOSEDSTRING",
            description = "Manifest Parse Error : A string literal was not closed."
        },
        [14063] = {
            id = "ERROR_SXS_XML_E_UNCLOSEDCOMMENT",
            description = "Manifest Parse Error : A comment was not closed."
        },
        [14064] = {
            id = "ERROR_SXS_XML_E_UNCLOSEDDECL",
            description = "Manifest Parse Error : A declaration was not closed."
        },
        [14065] = {
            id = "ERROR_SXS_XML_E_UNCLOSEDCDATA",
            description = "Manifest Parse Error : A CDATA section was not closed."
        },
        [14066] = {
            id = "ERROR_SXS_XML_E_RESERVEDNAMESPACE",
            description = "Manifest Parse Error : The namespace prefix is not allowed to start with the reserved string \"xml\"."
        },
        [14067] = {
            id = "ERROR_SXS_XML_E_INVALIDENCODING",
            description = "Manifest Parse Error : System does not support the specified encoding."
        },
        [14068] = {
            id = "ERROR_SXS_XML_E_INVALIDSWITCH",
            description = "Manifest Parse Error : Switch from current encoding to specified encoding not supported."
        },
        [14069] = {
            id = "ERROR_SXS_XML_E_BADXMLCASE",
            description = "Manifest Parse Error : The name 'xml' is reserved and must be lower case."
        },
        [14070] = {
            id = "ERROR_SXS_XML_E_INVALID_STANDALONE",
            description = "Manifest Parse Error : The standalone attribute must have the value 'yes' or 'no'."
        },
        [14071] = {
            id = "ERROR_SXS_XML_E_UNEXPECTED_STANDALONE",
            description = "Manifest Parse Error : The standalone attribute cannot be used in external entities."
        },
        [14072] = {
            id = "ERROR_SXS_XML_E_INVALID_VERSION",
            description = "Manifest Parse Error : Invalid version number."
        },
        [14073] = {
            id = "ERROR_SXS_XML_E_MISSINGEQUALS",
            description = "Manifest Parse Error : Missing equals sign between attribute and attribute value."
        },
        [14074] = {
            id = "ERROR_SXS_PROTECTION_RECOVERY_FAILED",
            description = "Assembly Protection Error : Unable to recover the specified assembly."
        },
        [14075] = {
            id = "ERROR_SXS_PROTECTION_PUBLIC_KEY_TOO_SHORT",
            description = "Assembly Protection Error : The public key for an assembly was too short to be allowed."
        },
        [14076] = {
            id = "ERROR_SXS_PROTECTION_CATALOG_NOT_VALID",
            description = "Assembly Protection Error : The catalog for an assembly is not valid, or does not match the assembly's manifest."
        },
        [14077] = {
            id = "ERROR_SXS_UNTRANSLATABLE_HRESULT",
            description = "An HRESULT could not be translated to a corresponding Win32 error code."
        },
        [14078] = {
            id = "ERROR_SXS_PROTECTION_CATALOG_FILE_MISSING",
            description = "Assembly Protection Error : The catalog for an assembly is missing."
        },
        [14079] = {
            id = "ERROR_SXS_MISSING_ASSEMBLY_IDENTITY_ATTRIBUTE",
            description = "The supplied assembly identity is missing one or more attributes which must be present in this context."
        },
        [14080] = {
            id = "ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE_NAME",
            description = "The supplied assembly identity has one or more attribute names that contain characters not permitted in XML names."
        },
        [14081] = {
            id = "ERROR_SXS_ASSEMBLY_MISSING",
            description = "The referenced assembly could not be found."
        },
        [14082] = {
            id = "ERROR_SXS_CORRUPT_ACTIVATION_STACK",
            description = "The activation context activation stack for the running thread of execution is corrupt."
        },
        [14083] = {
            id = "ERROR_SXS_CORRUPTION",
            description = "The application isolation metadata for this process or thread has become corrupt."
        },
        [14084] = {
            id = "ERROR_SXS_EARLY_DEACTIVATION",
            description = "The activation context being deactivated is not the most recently activated one."
        },
        [14085] = {
            id = "ERROR_SXS_INVALID_DEACTIVATION",
            description = "The activation context being deactivated is not active for the current thread of execution."
        },
        [14086] = {
            id = "ERROR_SXS_MULTIPLE_DEACTIVATION",
            description = "The activation context being deactivated has already been deactivated."
        },
        [14087] = {
            id = "ERROR_SXS_PROCESS_TERMINATION_REQUESTED",
            description = "A component used by the isolation facility has requested to terminate the process."
        },
        [14088] = {
            id = "ERROR_SXS_RELEASE_ACTIVATION_CONTEXT",
            description = "A kernel mode component is releasing a reference on an activation context."
        },
        [14089] = {
            id = "ERROR_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY",
            description = "The activation context of system default assembly could not be generated."
        },
        [14090] = {
            id = "ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE",
            description = "The value of an attribute in an identity is not within the legal range."
        },
        [14091] = {
            id = "ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME",
            description = "The name of an attribute in an identity is not within the legal range."
        },
        [14092] = {
            id = "ERROR_SXS_IDENTITY_DUPLICATE_ATTRIBUTE",
            description = "An identity contains two definitions for the same attribute."
        },
        [14093] = {
            id = "ERROR_SXS_IDENTITY_PARSE_ERROR",
            description = "The identity string is malformed. This may be due to a trailing comma, more than two unnamed attributes, missing attribute name or missing attribute value."
        },
        [14094] = {
            id = "ERROR_MALFORMED_SUBSTITUTION_STRING",
            description = "A string containing localized substitutable content was malformed. Either a dollar sign ($) was followed by something other than a left parenthesis or another dollar sign or an substitution's right parenthesis was not found."
        },
        [14095] = {
            id = "ERROR_SXS_INCORRECT_PUBLIC_KEY_TOKEN",
            description = "The public key token does not correspond to the public key specified."
        },
        [14096] = {
            id = "ERROR_UNMAPPED_SUBSTITUTION_STRING",
            description = "A substitution string had no mapping."
        },
        [14097] = {
            id = "ERROR_SXS_ASSEMBLY_NOT_LOCKED",
            description = "The component must be locked before making the request."
        },
        [14098] = {
            id = "ERROR_SXS_COMPONENT_STORE_CORRUPT",
            description = "The component store has been corrupted."
        },
        [14099] = {
            id = "ERROR_ADVANCED_INSTALLER_FAILED",
            description = "An advanced installer failed during setup or servicing."
        },
        [14100] = {
            id = "ERROR_XML_ENCODING_MISMATCH",
            description = "The character encoding in the XML declaration did not match the encoding used in the document."
        },
        [14101] = {
            id = "ERROR_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT",
            description = "The identities of the manifests are identical but their contents are different."
        },
        [14102] = {
            id = "ERROR_SXS_IDENTITIES_DIFFERENT",
            description = "The component identities are different."
        },
        [14103] = {
            id = "ERROR_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT",
            description = "The assembly is not a deployment."
        },
        [14104] = {
            id = "ERROR_SXS_FILE_NOT_PART_OF_ASSEMBLY",
            description = "The file is not a part of the assembly."
        },
        [14105] = {
            id = "ERROR_SXS_MANIFEST_TOO_BIG",
            description = "The size of the manifest exceeds the maximum allowed."
        },
        [14106] = {
            id = "ERROR_SXS_SETTING_NOT_REGISTERED",
            description = "The setting is not registered."
        },
        [14107] = {
            id = "ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE",
            description = "One or more required members of the transaction are not present."
        },
        [14108] = {
            id = "ERROR_SMI_PRIMITIVE_INSTALLER_FAILED",
            description = "The SMI primitive installer failed during setup or servicing."
        },
        [14109] = {
            id = "ERROR_GENERIC_COMMAND_FAILED",
            description = "A generic command executable returned a result that indicates failure."
        },
        [14110] = {
            id = "ERROR_SXS_FILE_HASH_MISSING",
            description = "A component is missing file verification information in its manifest."
        },
        [15000] = {
            id = "ERROR_EVT_INVALID_CHANNEL_PATH",
            description = "The specified channel path is invalid."
        },
        [15001] = {
            id = "ERROR_EVT_INVALID_QUERY",
            description = "The specified query is invalid."
        },
        [15002] = {
            id = "ERROR_EVT_PUBLISHER_METADATA_NOT_FOUND",
            description = "The publisher metadata cannot be found in the resource."
        },
        [15003] = {
            id = "ERROR_EVT_EVENT_TEMPLATE_NOT_FOUND",
            description = "The template for an event definition cannot be found in the resource (error = %1)."
        },
        [15004] = {
            id = "ERROR_EVT_INVALID_PUBLISHER_NAME",
            description = "The specified publisher name is invalid."
        },
        [15005] = {
            id = "ERROR_EVT_INVALID_EVENT_DATA",
            description = "The event data raised by the publisher is not compatible with the event template definition in the publisher's manifest."
        },
        [15007] = {
            id = "ERROR_EVT_CHANNEL_NOT_FOUND",
            description = "The specified channel could not be found. Check channel configuration."
        },
        [15008] = {
            id = "ERROR_EVT_MALFORMED_XML_TEXT",
            description = "The specified xml text was not well-formed. See Extended Error for more details."
        },
        [15009] = {
            id = "ERROR_EVT_SUBSCRIPTION_TO_DIRECT_CHANNEL",
            description = "The caller is trying to subscribe to a direct channel which is not allowed. The events for a direct channel go directly to a logfile and cannot be subscribed to."
        },
        [15010] = {
            id = "ERROR_EVT_CONFIGURATION_ERROR",
            description = "Configuration error."
        },
        [15011] = {
            id = "ERROR_EVT_QUERY_RESULT_STALE",
            description = "The query result is stale / invalid. This may be due to the log being cleared or rolling over after the query result was created. Users should handle this code by releasing the query result object and reissuing the query."
        },
        [15012] = {
            id = "ERROR_EVT_QUERY_RESULT_INVALID_POSITION",
            description = "Query result is currently at an invalid position."
        },
        [15013] = {
            id = "ERROR_EVT_NON_VALIDATING_MSXML",
            description = "Registered MSXML doesn't support validation."
        },
        [15014] = {
            id = "ERROR_EVT_FILTER_ALREADYSCOPED",
            description = "An expression can only be followed by a change of scope operation if it itself evaluates to a node set and is not already part of some other change of scope operation."
        },
        [15015] = {
            id = "ERROR_EVT_FILTER_NOTELTSET",
            description = "Can't perform a step operation from a term that does not represent an element set."
        },
        [15016] = {
            id = "ERROR_EVT_FILTER_INVARG",
            description = "Left hand side arguments to binary operators must be either attributes, nodes or variables and right hand side arguments must be constants."
        },
        [15017] = {
            id = "ERROR_EVT_FILTER_INVTEST",
            description = "A step operation must involve either a node test or, in the case of a predicate, an algebraic expression against which to test each node in the node set identified by the preceeding node set can be evaluated."
        },
        [15018] = {
            id = "ERROR_EVT_FILTER_INVTYPE",
            description = "This data type is currently unsupported."
        },
        [15019] = {
            id = "ERROR_EVT_FILTER_PARSEERR",
            description = "A syntax error occurred at position %1!d!."
        },
        [15020] = {
            id = "ERROR_EVT_FILTER_UNSUPPORTEDOP",
            description = "This operator is unsupported by this implementation of the filter."
        },
        [15021] = {
            id = "ERROR_EVT_FILTER_UNEXPECTEDTOKEN",
            description = "The token encountered was unexpected."
        },
        [15022] = {
            id = "ERROR_EVT_INVALID_OPERATION_OVER_ENABLED_DIRECT_CHANNEL",
            description = "The requested operation cannot be performed over an enabled direct channel. The channel must first be disabled before performing the requested operation."
        },
        [15023] = {
            id = "ERROR_EVT_INVALID_CHANNEL_PROPERTY_VALUE",
            description = "Channel property %1!s! contains invalid value. The value has invalid type, is outside of valid range, can't be updated or is not supported by this type of channel."
        },
        [15024] = {
            id = "ERROR_EVT_INVALID_PUBLISHER_PROPERTY_VALUE",
            description = "Publisher property %1!s! contains invalid value. The value has invalid type, is outside of valid range, can't be updated or is not supported by this type of publisher."
        },
        [15025] = {
            id = "ERROR_EVT_CHANNEL_CANNOT_ACTIVATE",
            description = "The channel fails to activate."
        },
        [15026] = {
            id = "ERROR_EVT_FILTER_TOO_COMPLEX",
            description = "The xpath expression exceeded supported complexity. Please symplify it or split it into two or more simple expressions."
        },
        [15027] = {
            id = "ERROR_EVT_MESSAGE_NOT_FOUND",
            description = "the message resource is present but the message is not found in the string/message table."
        },
        [15028] = {
            id = "ERROR_EVT_MESSAGE_ID_NOT_FOUND",
            description = "The message id for the desired message could not be found."
        },
        [15029] = {
            id = "ERROR_EVT_UNRESOLVED_VALUE_INSERT",
            description = "The substitution string for insert index (%1) could not be found."
        },
        [15030] = {
            id = "ERROR_EVT_UNRESOLVED_PARAMETER_INSERT",
            description = "The description string for parameter reference (%1) could not be found."
        },
        [15031] = {
            id = "ERROR_EVT_MAX_INSERTS_REACHED",
            description = "The maximum number of replacements has been reached."
        },
        [15032] = {
            id = "ERROR_EVT_EVENT_DEFINITION_NOT_FOUND",
            description = "The event definition could not be found for event id (%1)."
        },
        [15033] = {
            id = "ERROR_EVT_MESSAGE_LOCALE_NOT_FOUND",
            description = "The locale specific resource for the desired message is not present."
        },
        [15034] = {
            id = "ERROR_EVT_VERSION_TOO_OLD",
            description = "The resource is too old to be compatible."
        },
        [15035] = {
            id = "ERROR_EVT_VERSION_TOO_NEW",
            description = "The resource is too new to be compatible."
        },
        [15036] = {
            id = "ERROR_EVT_CANNOT_OPEN_CHANNEL_OF_QUERY",
            description = "The channel at index %1!d! of the query can't be opened."
        },
        [15037] = {
            id = "ERROR_EVT_PUBLISHER_DISABLED",
            description = "The publisher has been disabled and its resource is not available. This usually occurs when the publisher is in the process of being uninstalled or upgraded."
        },
        [15038] = {
            id = "ERROR_EVT_FILTER_OUT_OF_RANGE",
            description = "Attempted to create a numeric type that is outside of its valid range."
        },
        [15080] = {
            id = "ERROR_EC_SUBSCRIPTION_CANNOT_ACTIVATE",
            description = "The subscription fails to activate."
        },
        [15081] = {
            id = "ERROR_EC_LOG_DISABLED",
            description = "The log of the subscription is in disabled state, and can not be used to forward events to. The log must first be enabled before the subscription can be activated."
        },
        [15082] = {
            id = "ERROR_EC_CIRCULAR_FORWARDING",
            description = "When forwarding events from local machine to itself, the query of the subscription can't contain target log of the subscription."
        },
        [15083] = {
            id = "ERROR_EC_CREDSTORE_FULL",
            description = "The credential store that is used to save credentials is full."
        },
        [15084] = {
            id = "ERROR_EC_CRED_NOT_FOUND",
            description = "The credential used by this subscription can't be found in credential store."
        },
        [15085] = {
            id = "ERROR_EC_NO_ACTIVE_CHANNEL",
            description = "No active channel is found for the query."
        },
        [15100] = {
            id = "ERROR_MUI_FILE_NOT_FOUND",
            description = "The resource loader failed to find MUI file."
        },
        [15101] = {
            id = "ERROR_MUI_INVALID_FILE",
            description = "The resource loader failed to load MUI file because the file fail to pass validation."
        },
        [15102] = {
            id = "ERROR_MUI_INVALID_RC_CONFIG",
            description = "The RC Manifest is corrupted with garbage data or unsupported version or missing required item."
        },
        [15103] = {
            id = "ERROR_MUI_INVALID_LOCALE_NAME",
            description = "The RC Manifest has invalid culture name."
        },
        [15104] = {
            id = "ERROR_MUI_INVALID_ULTIMATEFALLBACK_NAME",
            description = "The RC Manifest has invalid ultimatefallback name."
        },
        [15105] = {
            id = "ERROR_MUI_FILE_NOT_LOADED",
            description = "The resource loader cache doesn't have loaded MUI entry."
        },
        [15106] = {
            id = "ERROR_RESOURCE_ENUM_USER_STOP",
            description = "User stopped resource enumeration."
        },
        [15107] = {
            id = "ERROR_MUI_INTLSETTINGS_UILANG_NOT_INSTALLED",
            description = "UI language installation failed."
        },
        [15108] = {
            id = "ERROR_MUI_INTLSETTINGS_INVALID_LOCALE_NAME",
            description = "Locale installation failed."
        },
        [15110] = {
            id = "ERROR_MRM_RUNTIME_NO_DEFAULT_OR_NEUTRAL_RESOURCE",
            description = "A resource does not have default or neutral value."
        },
        [15111] = {
            id = "ERROR_MRM_INVALID_PRICONFIG",
            description = "Invalid PRI config file."
        },
        [15112] = {
            id = "ERROR_MRM_INVALID_FILE_TYPE",
            description = "Invalid file type."
        },
        [15113] = {
            id = "ERROR_MRM_UNKNOWN_QUALIFIER",
            description = "Unknown qualifier."
        },
        [15114] = {
            id = "ERROR_MRM_INVALID_QUALIFIER_VALUE",
            description = "Invalid qualifier value."
        },
        [15115] = {
            id = "ERROR_MRM_NO_CANDIDATE",
            description = "No Candidate found."
        },
        [15116] = {
            id = "ERROR_MRM_NO_MATCH_OR_DEFAULT_CANDIDATE",
            description = "The ResourceMap or NamedResource has an item that does not have default or neutral resource.."
        },
        [15117] = {
            id = "ERROR_MRM_RESOURCE_TYPE_MISMATCH",
            description = "Invalid ResourceCandidate type."
        },
        [15118] = {
            id = "ERROR_MRM_DUPLICATE_MAP_NAME",
            description = "Duplicate Resource Map."
        },
        [15119] = {
            id = "ERROR_MRM_DUPLICATE_ENTRY",
            description = "Duplicate Entry."
        },
        [15120] = {
            id = "ERROR_MRM_INVALID_RESOURCE_IDENTIFIER",
            description = "Invalid Resource Identifier."
        },
        [15121] = {
            id = "ERROR_MRM_FILEPATH_TOO_LONG",
            description = "Filepath too long."
        },
        [15122] = {
            id = "ERROR_MRM_UNSUPPORTED_DIRECTORY_TYPE",
            description = "Unsupported directory type."
        },
        [15126] = {
            id = "ERROR_MRM_INVALID_PRI_FILE",
            description = "Invalid PRI File."
        },
        [15127] = {
            id = "ERROR_MRM_NAMED_RESOURCE_NOT_FOUND",
            description = "NamedResource Not Found."
        },
        [15135] = {
            id = "ERROR_MRM_MAP_NOT_FOUND",
            description = "ResourceMap Not Found."
        },
        [15136] = {
            id = "ERROR_MRM_UNSUPPORTED_PROFILE_TYPE",
            description = "Unsupported MRT profile type."
        },
        [15137] = {
            id = "ERROR_MRM_INVALID_QUALIFIER_OPERATOR",
            description = "Invalid qualifier operator."
        },
        [15138] = {
            id = "ERROR_MRM_INDETERMINATE_QUALIFIER_VALUE",
            description = "Unable to determine qualifier value or qualifier value has not been set."
        },
        [15139] = {
            id = "ERROR_MRM_AUTOMERGE_ENABLED",
            description = "Automerge is enabled in the PRI file."
        },
        [15140] = {
            id = "ERROR_MRM_TOO_MANY_RESOURCES",
            description = "Too many resources defined for package."
        },
        [15200] = {
            id = "ERROR_MCA_INVALID_CAPABILITIES_STRING",
            description = "The monitor returned a DDC/CI capabilities string that did not comply with the ACCESS.bus 3.0, DDC/CI 1.1 or MCCS 2 Revision 1 specification."
        },
        [15201] = {
            id = "ERROR_MCA_INVALID_VCP_VERSION",
            description = "The monitor's VCP Version (0xDF) VCP code returned an invalid version value."
        },
        [15202] = {
            id = "ERROR_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION",
            description = "The monitor does not comply with the MCCS specification it claims to support."
        },
        [15203] = {
            id = "ERROR_MCA_MCCS_VERSION_MISMATCH",
            description = "The MCCS version in a monitor's mccs_ver capability does not match the MCCS version the monitor reports when the VCP Version (0xDF) VCP code is used."
        },
        [15204] = {
            id = "ERROR_MCA_UNSUPPORTED_MCCS_VERSION",
            description = "The Monitor Configuration API only works with monitors that support the MCCS 1.0 specification, MCCS 2.0 specification or the MCCS 2.0 Revision 1 specification."
        },
        [15205] = {
            id = "ERROR_MCA_INTERNAL_ERROR",
            description = "An internal Monitor Configuration API error occurred."
        },
        [15206] = {
            id = "ERROR_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED",
            description = "The monitor returned an invalid monitor technology type. CRT, Plasma and LCD (TFT) are examples of monitor technology types. This error implies that the monitor violated the MCCS 2.0 or MCCS 2.0 Revision 1 specification."
        },
        [15207] = {
            id = "ERROR_MCA_UNSUPPORTED_COLOR_TEMPERATURE",
            description = "The caller of SetMonitorColorTemperature specified a color temperature that the current monitor did not support. This error implies that the monitor violated the MCCS 2.0 or MCCS 2.0 Revision 1 specification."
        },
        [15250] = {
            id = "ERROR_AMBIGUOUS_SYSTEM_DEVICE",
            description = "The requested system device cannot be identified due to multiple indistinguishable devices potentially matching the identification criteria."
        },
        [15299] = {
            id = "ERROR_SYSTEM_DEVICE_NOT_FOUND",
            description = "The requested system device cannot be found."
        },
        [15300] = {
            id = "ERROR_HASH_NOT_SUPPORTED",
            description = "Hash generation for the specified hash version and hash type is not enabled on the server."
        },
        [15301] = {
            id = "ERROR_HASH_NOT_PRESENT",
            description = "The hash requested from the server is not available or no longer valid."
        },
        [15321] = {
            id = "ERROR_SECONDARY_IC_PROVIDER_NOT_REGISTERED",
            description = "The secondary interrupt controller instance that manages the specified interrupt is not registered."
        },
        [15322] = {
            id = "ERROR_GPIO_CLIENT_INFORMATION_INVALID",
            description = "The information supplied by the GPIO client driver is invalid."
        },
        [15323] = {
            id = "ERROR_GPIO_VERSION_NOT_SUPPORTED",
            description = "The version specified by the GPIO client driver is not supported."
        },
        [15324] = {
            id = "ERROR_GPIO_INVALID_REGISTRATION_PACKET",
            description = "The registration packet supplied by the GPIO client driver is not valid."
        },
        [15325] = {
            id = "ERROR_GPIO_OPERATION_DENIED",
            description = "The requested operation is not suppported for the specified handle."
        },
        [15326] = {
            id = "ERROR_GPIO_INCOMPATIBLE_CONNECT_MODE",
            description = "The requested connect mode conflicts with an existing mode on one or more of the specified pins."
        },
        [15327] = {
            id = "ERROR_GPIO_INTERRUPT_ALREADY_UNMASKED",
            description = "The interrupt requested to be unmasked is not masked."
        },
        [15400] = {
            id = "ERROR_CANNOT_SWITCH_RUNLEVEL",
            description = "The requested run level switch cannot be completed successfully."
        },
        [15401] = {
            id = "ERROR_INVALID_RUNLEVEL_SETTING",
            description = "The service has an invalid run level setting. The run level for a service must not be higher than the run level of its dependent services."
        },
        [15402] = {
            id = "ERROR_RUNLEVEL_SWITCH_TIMEOUT",
            description = "The requested run level switch cannot be completed successfully since one or more services will not stop or restart within the specified timeout."
        },
        [15403] = {
            id = "ERROR_RUNLEVEL_SWITCH_AGENT_TIMEOUT",
            description = "A run level switch agent did not respond within the specified timeout."
        },
        [15404] = {
            id = "ERROR_RUNLEVEL_SWITCH_IN_PROGRESS",
            description = "A run level switch is currently in progress."
        },
        [15405] = {
            id = "ERROR_SERVICES_FAILED_AUTOSTART",
            description = "One or more services failed to start during the service startup phase of a run level switch."
        },
        [15501] = {
            id = "ERROR_COM_TASK_STOP_PENDING",
            description = "The task stop request cannot be completed immediately since task needs more time to shutdown."
        },
        [15600] = {
            id = "ERROR_INSTALL_OPEN_PACKAGE_FAILED",
            description = "Package could not be opened."
        },
        [15601] = {
            id = "ERROR_INSTALL_PACKAGE_NOT_FOUND",
            description = "Package was not found."
        },
        [15602] = {
            id = "ERROR_INSTALL_INVALID_PACKAGE",
            description = "Package data is invalid."
        },
        [15603] = {
            id = "ERROR_INSTALL_RESOLVE_DEPENDENCY_FAILED",
            description = "Package failed updates, dependency or conflict validation."
        },
        [15604] = {
            id = "ERROR_INSTALL_OUT_OF_DISK_SPACE",
            description = "There is not enough disk space on your computer. Please free up some space and try again."
        },
        [15605] = {
            id = "ERROR_INSTALL_NETWORK_FAILURE",
            description = "There was a problem downloading your product."
        },
        [15606] = {
            id = "ERROR_INSTALL_REGISTRATION_FAILURE",
            description = "Package could not be registered."
        },
        [15607] = {
            id = "ERROR_INSTALL_DEREGISTRATION_FAILURE",
            description = "Package could not be unregistered."
        },
        [15608] = {
            id = "ERROR_INSTALL_CANCEL",
            description = "User cancelled the install request."
        },
        [15609] = {
            id = "ERROR_INSTALL_FAILED",
            description = "Install failed. Please contact your software vendor."
        },
        [15610] = {
            id = "ERROR_REMOVE_FAILED",
            description = "Removal failed. Please contact your software vendor."
        },
        [15611] = {
            id = "ERROR_PACKAGE_ALREADY_EXISTS",
            description = "The provided package is already installed, and reinstallation of the package was blocked. Check the AppXDeployment-Server event log for details."
        },
        [15612] = {
            id = "ERROR_NEEDS_REMEDIATION",
            description = "The application cannot be started. Try reinstalling the application to fix the problem."
        },
        [15613] = {
            id = "ERROR_INSTALL_PREREQUISITE_FAILED",
            description = "A Prerequisite for an install could not be satisfied."
        },
        [15614] = {
            id = "ERROR_PACKAGE_REPOSITORY_CORRUPTED",
            description = "The package repository is corrupted."
        },
        [15615] = {
            id = "ERROR_INSTALL_POLICY_FAILURE",
            description = "To install this application you need either a Windows developer license or a sideloading-enabled system."
        },
        [15616] = {
            id = "ERROR_PACKAGE_UPDATING",
            description = "The application cannot be started because it is currently updating."
        },
        [15617] = {
            id = "ERROR_DEPLOYMENT_BLOCKED_BY_POLICY",
            description = "The package deployment operation is blocked by policy. Please contact your system administrator."
        },
        [15618] = {
            id = "ERROR_PACKAGES_IN_USE",
            description = "The package could not be installed because resources it modifies are currently in use."
        },
        [15619] = {
            id = "ERROR_RECOVERY_FILE_CORRUPT",
            description = "The package could not be recovered because necessary data for recovery have been corrupted."
        },
        [15620] = {
            id = "ERROR_INVALID_STAGED_SIGNATURE",
            description = "The signature is invalid. To register in developer mode, AppxSignature.p7x and AppxBlockMap.xml must be valid or should not be present."
        },
        [15621] = {
            id = "ERROR_DELETING_EXISTING_APPLICATIONDATA_STORE_FAILED",
            description = "An error occurred while deleting the package's previously existing application data."
        },
        [15622] = {
            id = "ERROR_INSTALL_PACKAGE_DOWNGRADE",
            description = "The package could not be installed because a higher version of this package is already installed."
        },
        [15623] = {
            id = "ERROR_SYSTEM_NEEDS_REMEDIATION",
            description = "An error in a system binary was detected. Try refreshing the PC to fix the problem."
        },
        [15624] = {
            id = "ERROR_APPX_INTEGRITY_FAILURE_CLR_NGEN",
            description = "A corrupted CLR NGEN binary was detected on the system."
        },
        [15625] = {
            id = "ERROR_RESILIENCY_FILE_CORRUPT",
            description = "The operation could not be resumed because necessary data for recovery have been corrupted."
        },
        [15626] = {
            id = "ERROR_INSTALL_FIREWALL_SERVICE_NOT_RUNNING",
            description = "The package could not be installed because the Windows Firewall service is not running. Enable the Windows Firewall service and try again."
        },
        [15700] = {
            id = "APPMODEL_ERROR_NO_PACKAGE",
            description = "The process has no package identity."
        },
        [15701] = {
            id = "APPMODEL_ERROR_PACKAGE_RUNTIME_CORRUPT",
            description = "The package runtime information is corrupted."
        },
        [15702] = {
            id = "APPMODEL_ERROR_PACKAGE_IDENTITY_CORRUPT",
            description = "The package identity is corrupted."
        },
        [15703] = {
            id = "APPMODEL_ERROR_NO_APPLICATION",
            description = "The process has no application identity."
        },
        [15800] = {
            id = "ERROR_STATE_LOAD_STORE_FAILED",
            description = "Loading the state store failed."
        },
        [15801] = {
            id = "ERROR_STATE_GET_VERSION_FAILED",
            description = "Retrieving the state version for the application failed."
        },
        [15802] = {
            id = "ERROR_STATE_SET_VERSION_FAILED",
            description = "Setting the state version for the application failed."
        },
        [15803] = {
            id = "ERROR_STATE_STRUCTURED_RESET_FAILED",
            description = "Resetting the structured state of the application failed."
        },
        [15804] = {
            id = "ERROR_STATE_OPEN_CONTAINER_FAILED",
            description = "State Manager failed to open the container."
        },
        [15805] = {
            id = "ERROR_STATE_CREATE_CONTAINER_FAILED",
            description = "State Manager failed to create the container."
        },
        [15806] = {
            id = "ERROR_STATE_DELETE_CONTAINER_FAILED",
            description = "State Manager failed to delete the container."
        },
        [15807] = {
            id = "ERROR_STATE_READ_SETTING_FAILED",
            description = "State Manager failed to read the setting."
        },
        [15808] = {
            id = "ERROR_STATE_WRITE_SETTING_FAILED",
            description = "State Manager failed to write the setting."
        },
        [15809] = {
            id = "ERROR_STATE_DELETE_SETTING_FAILED",
            description = "State Manager failed to delete the setting."
        },
        [15810] = {
            id = "ERROR_STATE_QUERY_SETTING_FAILED",
            description = "State Manager failed to query the setting."
        },
        [15811] = {
            id = "ERROR_STATE_READ_COMPOSITE_SETTING_FAILED",
            description = "State Manager failed to read the composite setting."
        },
        [15812] = {
            id = "ERROR_STATE_WRITE_COMPOSITE_SETTING_FAILED",
            description = "State Manager failed to write the composite setting."
        },
        [15813] = {
            id = "ERROR_STATE_ENUMERATE_CONTAINER_FAILED",
            description = "State Manager failed to enumerate the containers."
        },
        [15814] = {
            id = "ERROR_STATE_ENUMERATE_SETTINGS_FAILED",
            description = "State Manager failed to enumerate the settings."
        },
        [15815] = {
            id = "ERROR_STATE_COMPOSITE_SETTING_VALUE_SIZE_LIMIT_EXCEEDED",
            description = "The size of the state manager composite setting value has exceeded the limit."
        },
        [15816] = {
            id = "ERROR_STATE_SETTING_VALUE_SIZE_LIMIT_EXCEEDED",
            description = "The size of the state manager setting value has exceeded the limit."
        },
        [15817] = {
            id = "ERROR_STATE_SETTING_NAME_SIZE_LIMIT_EXCEEDED",
            description = "The length of the state manager setting name has exceeded the limit."
        },
        [15818] = {
            id = "ERROR_STATE_CONTAINER_NAME_SIZE_LIMIT_EXCEEDED",
            description = "The length of the state manager container name has exceeded the limit."
        },
        [15841] = {
            id = "ERROR_API_UNAVAILABLE",
            description = "This API cannot be used in the context of the caller's application type."
        }
    }
}
