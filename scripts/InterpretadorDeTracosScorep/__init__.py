# -*- coding: utf-8 -*-
from file_reader import FileReader
from trace_exporter import TraceExporter

fileR = FileReader('/home/gbmoro/Dropbox/MasterStudy/works/dissertacao_gbmoro/dados/exp_05-11-2016_ft/trace.csv')
traceE = TraceExporter()
counters = ['PAPI_L2_TCA', 'PAPI_L2_DCM', 'PAPI_L2_ICM']

traceE.scorepWithPapiCounters(fileR.reader(), counters)
