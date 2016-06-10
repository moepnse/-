import os
import sys
import imp

def load_plugin(plugin):
    if plugin[1].endswith('.py'):
        plugin = imp.load_source(*plugin)
    elif plugin[1].endswith('.pyd'):
        plugin = imp.load_dynamic(*plugin)
    else:
        plugin = imp.load_compiled(*plugin)
    return plugin
    
if __name__ == "__main__":
    if len(sys.argv) > 1:
        module_path = os.path.abspath(sys.argv[1])
        module_dir = os.path.dirname(module_path)
        module_filename = os.path.basename(module_path)
        tmp = module_filename.split(".")
        if len(tmp) > 1:
            module_name = tmp[0]
            print "plugin name:\t\t%s\nplugin path:\t\t%s" % (module_name, module_path)
            plugin = load_plugin((module_name, module_path))
            print "plugin name:\t\t%s\nsupported file extension:\t%s\nsupported api versions:\t%s" % (plugin.plugin_name, plugin.file_extension, plugin.api_versions)
        else:
            print "file type is missing!"