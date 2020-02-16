#!/bin/bash
executionPath=$(pwd)
find "$1" -type d -depth 1 -maxdepth 1 -exec "$executionPath"/collectGitChanges.sh {} \;