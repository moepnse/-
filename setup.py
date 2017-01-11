import os
import sys
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

packages = ("libs", "libs.handlers", "libs.win", "plugins.logging", "plugins.config", "plugins.protocol_handlers")
cmdclass = {'build_ext': build_ext}
compile_args = os.environ['PD'].split(" ")
extra_link_args = [r'/MACHINE:%s' % os.environ['MACHINE']] if "win" in sys.platform else []
library_dir = [os.environ['PYTHON_LIBS_PATH']] if "win" in sys.platform else []
include_dirs = [os.environ['PYTHON_INCLUDE_PATH']] if "win" in sys.platform else [os.path.dirname(os.path.realpath(__file__))]
print include_dirs

#ext = Extension("x11pras", ["x11pras.pyx"],  include_dirs = ['.'])
#ext_modules.append(ext)
ext_modules = [
    Extension('libs.common',
        sources=[os.path.join(r'libs', 'common.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.pi_status_gui',
        sources=[os.path.join(r'libs', 'pi_status_gui.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.aimg',
        sources=[os.path.join(r'libs', 'aimg.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.plugin_handler',
        sources=[os.path.join(r'libs', 'handlers', 'plugin_handler.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.config',
        sources=[os.path.join(r'libs', 'handlers', 'config.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.status',
        sources=[os.path.join(r'libs', 'handlers', 'status.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.logging',
        sources=[os.path.join(r'libs', 'handlers', 'logging.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.protocol',
        sources=[os.path.join(r'libs', 'handlers', 'protocol.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ['Wtsapi32', 'Kernel32', 'Advapi32', 'Userenv'] if "win" in sys.platform else [],
        library_dirs = library_dir
    ),
    Extension('libs.handlers.dependencies',
        sources=[os.path.join(r'libs', 'handlers', 'dependencies.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.win.system',
        sources=[os.path.join(r'libs', 'win', 'system.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ['Kernel32', 'Netapi32'] if "win" in sys.platform else [],
        library_dirs = library_dir
    ),
    Extension('libs.win.software',
        sources=[os.path.join(r'libs', 'win', 'software.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('libs.win.file_info',
        sources=[os.path.join(r'libs', 'win', 'file_info.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ['Version'] if "win" in sys.platform else [],
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
        sources=[os.path.join(r'plugins', 'config', 'xml_md.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
    Extension('plugins.config.holdes_mondenkind',
        sources=[os.path.join(r'plugins', 'config', 'holdes_mondenkind.pyx')],
        extra_compile_args=compile_args,
        extra_link_args = [] if "win" in sys.platform else ['-Wl,-rpath=$ORIGIN'],
        include_dirs = include_dirs + [os.path.join('dependencies', 'lua-5.3.0', 'src')],
        #include_dirs = include_dirs + ([os.path.join('dependencies', 'lua-5.3.0', 'src')] if "win" in sys.platform else []),
        #libraries = (['Advapi32', 'Netapi32', 'Version']  if "win" in sys.platform else []) + ['lua5.3.0', 'luac'],
        libraries = (['Advapi32', 'Netapi32', 'Version']  if "win" in sys.platform else []) + ['lua5.3.0'],
        library_dirs = library_dir + [os.path.join('dependencies', 'lua-5.3.0', 'src')]
        #library_dirs = library_dir + ([os.path.join('dependencies', 'lua-5.3.0', 'src')] if "win" in sys.platform else [])
    ),
	Extension('plugins.logging.console',
        sources=[os.path.join(r'plugins', 'logging', 'console.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension('plugins.logging.file',
        sources=[os.path.join(r'plugins', 'logging', 'file.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension('plugins.protocol_handlers.file',
        sources=[os.path.join(r'plugins', 'protocol_handlers', 'file.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension('plugins.protocol_handlers.ftp',
        sources=[os.path.join(r'plugins', 'protocol_handlers', 'ftp.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    ),
	Extension(r'plugins.protocol_handlers.http',
        sources=[os.path.join(r'plugins', 'protocol_handlers', 'http.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = [],
        library_dirs = library_dir
    )
]

if "win" in sys.platform:
    ext_modules += [
        Extension('plugins.logging.win_eventlog',
        sources=[os.path.join(r'plugins', 'logging', 'win_eventlog.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ["Advapi32"] if "win" in sys.platform else [],
        library_dirs = library_dir
        ),
        Extension('plugins.protocol_handlers.smb',
        sources=[os.path.join(r'plugins', 'protocol_handlers', 'smb.pyx')],
        extra_compile_args=compile_args,
        extra_link_args=[],
        include_dirs = include_dirs,
        libraries = ["Advapi32", "Mpr"] if "win" in sys.platform else [],
        library_dirs = library_dir
        ),
        Extension('libs.np_client',
        sources=[os.path.join(r'libs', 'np_client.pyx')],
        extra_compile_args=compile_args,
        include_dirs = include_dirs,
        libraries = ['Kernel32'],
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