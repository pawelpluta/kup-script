#!/bin/bash
gitRepositoriesRootDir="$1"
startDate="$2"
endDate="$3"
./cleanup.sh
./collectGitChangesList.sh "$gitRepositoriesRootDir" "$startDate" "$endDate"
./sortGitChangesList.sh
./aggregateGitChanges.sh
./generateKUPreportData.sh