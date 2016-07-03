# -*- coding: utf-8 -*-

def parse(command, keep_quotes=False):
    args = []
    arg = u""
    quote_start = False
    for i in range(0, len(command)):
        token = command[i:i+1]
        if token == r'"':
            if keep_quotes:
                arg += token
            if quote_start == True:
                args.append(arg)
                arg = u""
                quote_start = False
                continue
            quote_start = True
            continue

        if quote_start == False:
            if token == r' ':
                if arg != u"":
                    args.append(arg)
                    arg = u""
                continue

        arg += token

    if arg != "":
        args.append(arg)
    return args


def merge(args):
    cmd = u''
    last_arg = u''
    for arg in args:
        cmd += (u'%s' if last_arg.startswith('/') and last_arg.endswith('=') else u' %s') % (u'"%s"' % arg if " " in arg and not (arg.startswith('"') and arg.endswith('"')) else arg)
        last_arg = arg
    return cmd


def strip_qoutes(string):
    quotes = ["\"", "'"]
    for char in quotes:
        if string.startswith(char) and string.endswith(char):
            string = string.strip(char)
    return string


def test():
    print merge(("test", "/blub=", "test", "/test"))
