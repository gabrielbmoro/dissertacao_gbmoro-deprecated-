# -*- coding: utf-8 -*-
#trace_exporter.py


class TraceExporter(object):

    global traces

    def scorepWithPapiCounters(self, rows, counters):
        sample = ''
        trace = ''

        print("region, file, linha, contador, valor")

        for row in rows:
            if "ENTER" in row:
                part1, region, part2 = row.split('\"')
                called, lineWithFile = region.split('@')
                line, fileAddress = lineWithFile.split(':')
                called = called.replace('!$', '')
                called = called.replace(' ', '_')
                sample = '{},{},{}'.format(called, line, fileAddress)

            if "METRIC" in row:
                part1, part2 = row.split("Values:")
                for metric in part2.split(','):
                    for counter in counters:
                        if counter in metric:
                            p1, p2, p3 = metric.split(';')
                            metric = p3.replace(' ', '')
                            metric = metric.replace(')', '')
                            trace = counter + "," + metric
                            if len(sample.split(',')) > 2:
                                print(str(sample + "," + trace))
