#include <winresrc.h>

#define VER_FILEVERSION             1,0,0,0
#define VER_FILEVERSION_STR         "1.0.0.0\0"

#define VER_PRODUCTVERSION          1,0,0,0
#define VER_PRODUCTVERSION_STR      "1.0.0.0\0"

#define VER_COMPANYNAME_STR         "Unicom\0"
#define VER_FILEDESCRIPTION_STR     "Package Installer\0"
#define VER_PRODUCTNAME_STR         "Package Installer\0"
#define VER_INTERNALNAME_STR        "pi\0"
#define VER_LEGALCOPYRIGHT_STR      "Richard Lamboj\0"
#define VER_LEGALTRADEMARKS1_STR    "proprietary\0"
#define VER_LEGALTRADEMARKS2_STR    "proprietary\0"
#define VER_ORIGINALFILENAME_STR    "pi.exe\0"

#ifndef DEBUG
#define VER_DEBUG                   0
#else
#define VER_DEBUG                   VS_FF_DEBUG
#endif
#define VER_PRIVATEBUILD            0
#define VER_PRERELEASE              0
