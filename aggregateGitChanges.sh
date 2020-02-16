#!/bin/bash
< gitSortedOutput.tmp awk -f aggregate-git-changes.awk > gitAggregatedOutput.tmp