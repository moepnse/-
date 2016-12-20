# -*- coding: utf-8 -*-

# standard library imports
import inspect

# third party imports

# application/library imports


def str2bool(value, mapping={'true': True, '1': True, 'yes': True, 'y': True, 'false': False, '0': False, 'no': False, 'n': False}):
    if value in (0, 1):
        return value
    if value in mapping:
        return mapping[value]
    raise ValueError('invalid truth value %s' % value)


def get_current_line_nr():
    """Returns the current line number."""
    try:
        return inspect.currentframe().f_back.f_lineno
    except:
        return 0


cdef unicode un_camel(unicode str):
    cdef:
        unicode new_str = u""
        unicode char = u""

    for char in str:
        if char.isupper():
            new_str += u"_"+char.lower()
        else:
            new_str += char
    if new_str[0] == u"_":
        new_str = new_str[1:]
    return new_str


def get_application_path():
    cdef char* application_path
    application_path = sys.executable
    #print "Application path: %s" % application_path
    return os.path.dirname(os.path.abspath(application_path)) 
