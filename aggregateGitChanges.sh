#!/bin/bash
< gitSortedOutput.tmp awk -F "\t" f aggregate-git-changes.awk > gitAggregatedOutput.tmp