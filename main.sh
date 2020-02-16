#!/bin/bash
gitRepositoriesRootDir="$1"
./cleanup.sh
./collectGitChangesList.sh "$gitRepositoriesRootDir"
./sortGitChangesList.sh
./aggregateGitChanges.sh
./generateKUPreportData.sh