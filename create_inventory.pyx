# -*- coding: utf-8 -*-

__author__ = 'Richard Lamboj'
__copyright__ = 'Copyright 2013, Unicom'
__credits__ = ['Richard Lamboj']
__license__ = 'Proprietary'
__version__ = '1.0'
__maintainer__ = 'Richard Lamboj'
__email__ = 'rlamboj@unicom.ws'
__status__ = 'Development'


# standard library imports
import os
import sys
import time
import platform

# third party imports


# application/library imports
import libs.win.software


class Inventar(libs.win.software.SoftwareTree):


    def _get_xml_childs(self, product):
        xml = ''
        for child in product.values():
            xml += r'<product name="%s">%s</product>' % (child.product_name, self._get_xml_childs(child))
        return xml

    def xml(self):
        xml = "<products>"
        for product in self.values():
            xml += r'<product name="%s">%s</product>' % (product.product_name, self._get_xml_childs(product))
        return xml + r"</products>"

    def _get_json_childs(self, product):
        json = []
        for child in product.values():
            json.append([child.product_name, self._get_json_childs(child)])
        return json

    def json(self):
        json = []
        for product in libs.win.software.SoftwareTree().values():
            json.append([product.product_name, self._get_json_childs(product)])
        return json


def get_childs(product):
    childs = []
    for child in product.values():
        childs.append('[%s]' % ','.join([child.product_name, '[%s]' % ','.join(get_childs(child))]))
    return childs
    #return '[%s]' % ','.join(childs)


if __name__=='__main__':
    '''
    for product in libs.win.software.SoftwareTree().values():
        print ','.join(get_childs(product))
    '''
    inventar = Inventar()
    args = sys.argv[1:]
    if '--xml' in args:
        print inventar.xml()
    if '--json' in args:
        print inventar.json()