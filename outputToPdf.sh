#!/bin/bash
startDate="$1"
endDate="$2"

mkdir -p .args
echo $startDate > .args/startDate
echo $endDate > .args/endDate
cat kupReportData.csv | pbcopy
open ./report.docm
