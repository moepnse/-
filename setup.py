import os
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

packages = ("libs", "libs.handlers", "libs.win", "plugins.logging", "plugins.config", "plugins.protocol_handlers")
cmdclass = {'build_ext': build_ext}
compile_args = []
extra_link_args = [r'/MACHINE:%s' % os.environ['MACHINE']]
library_dir = [os.environ['PYTHON_LIBS_PATH']]
include_dirs = [os.environ['PYTHON_INCLUDE_PATH']]

#ext = Extension("x11pras", ["x11pras.pyx"],  include_dirs = ['.'])
#ext_modules.append(ext)
ext_modules = [
    Extension('libs.common',
        sources=[r'libs\common.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.plugin_handler',
        sources=[r'libs\handlers\plugin_handler.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.config',
        sources=[r'libs\handlers\config.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.logging',
        sources=[r'libs\handlers\logging.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.protocol',
        sources=[r'libs\handlers\protocol.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ['Wtsapi32', 'Kernel32', 'Advapi32', 'Userenv'],
        library_dirs = library_dir
    ),
    Extension('libs.win.system',
        sources=[r'libs\win\system.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ['Kernel32', 'Netapi32'],
        library_dirs = library_dir
    ),
    Extension('libs.win.software',
        sources=[r'libs\win\software.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.win.file_info',
        sources=[r'libs\win\file_info.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ['Version'],
        library_dirs = library_dir
    ),
    Extension('package_installer',
        sources=[r'package_installer.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('plugins.config.xml_md',
        sources=[r'plugins\config\xml_md.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('plugins.config.holdes_mondenkind',
        sources=[r'plugins\config\holdes_mondenkind.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs + ['C:\pi_cython\dependencies\lua-5.3.0\src'],
        libraries = ['Advapi32', 'Netapi32', 'Version', 'lua5.3.0', 'luac'],
        library_dirs = library_dir + ['C:\pi_cython\dependencies\lua-5.3.0\src']
    ),
	Extension('plugins.logging.console',
        sources=[r'plugins\logging\console.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension('plugins.logging.file',
        sources=[r'plugins\logging\file.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension('plugins.logging.win_eventlog',
        sources=[r'plugins\logging\win_eventlog.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ["Advapi32"],
        library_dirs = library_dir
    ),
	Extension('plugins.protocol_handlers.file',
        sources=[r'plugins\protocol_handlers\file.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension('plugins.protocol_handlers.ftp',
        sources=[r'plugins\protocol_handlers\ftp.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension(r'plugins.protocol_handlers.http',
        sources=[r'plugins\protocol_handlers\http.pyx'],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension('plugins.protocol_handlers.smb',
        sources=[r'plugins\protocol_handlers\smb.pyx'],
        extra_compile_args=compile_args,
        extra_link_args=[],
        include_dirs = include_dirs,
        libraries = ["Advapi32", "Mpr"],
        library_dirs = library_dir
    )
]

setup(
    name='pi',
    version = '1.0',
    author = 'Richard Lamboj',
    author_email = 'rl@unicom.ws',
    ext_modules=cythonize(ext_modules, gdb_debug=True),
    cmdclass=cmdclass,
    packages=packages
)
#  Build --------------------------
#  python setup.py build_ext --inplace