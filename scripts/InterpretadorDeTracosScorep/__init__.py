# -*- coding: utf-8 -*-
from file_reader import FileReader
from trace_exporter import TraceExporter

fileR = FileReader('C:\\Users\\gbmoro\\Downloads\\trace.csv')
traceE = TraceExporter()
counters = ['PAPI_L2_TCA', 'PAPI_L2_DCM', 'PAPI_L2_ICM']

traceE.scorepWithPapiCounters(fileR.reader(), counters)