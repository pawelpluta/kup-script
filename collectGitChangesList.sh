#!/bin/bash
executionPath=$(pwd)
startDate="$2"
endDate="$3"
find "$1" -type d -depth 1 -maxdepth 1 -exec "$executionPath"/collectGitChanges.sh {} "$startDate" "$endDate" \;
