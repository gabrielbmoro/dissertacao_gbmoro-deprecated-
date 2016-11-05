# -*- coding: utf-8 -*-
#file_reader.py


class FileReader(object):

    def __init__(self, path):
        self.path = path

    def reader(self):
        return open(self.path, 'r')