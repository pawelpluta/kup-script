#!/bin/bash
< gitAggregatedOutput.tmp awk -F "\t" -f format-kup-report.awk > kupReportData.csv
