#!/bin/bash

function findRepositoryBasePath() {
  cd "$1"
  repositoryLocation=$(git config --get remote.origin.url)
  echo "$repositoryLocation"?path=
}

function findCommiter() {
  cd "$1"
  commiterName=$(git config --get user.name)
  if [[ $commiterName = "" ]];
  then
    commiterName=$(git config --get user.email | cut -f1 -d"@")
  fi
  echo "$commiterName"
}

executionPath=$(pwd)
gitRepositoryLocalDir="$1"
startDate="$2"
endDate="$3"
repoBasePath=$(findRepositoryBasePath "$gitRepositoryLocalDir")
commitsAuthor=$(findCommiter "$gitRepositoryLocalDir")

cd "$gitRepositoryLocalDir"
git log --no-merges --author="$commitsAuthor" --date=short --since="$startDate" --until="$endDate" --pretty=format:"%cd" --numstat --diff-filter=A | awk -F "\t" -f "$executionPath"/pre-format-git-changes.awk -v repoBasePath="$repoBasePath" -v operation="A" >> "$executionPath"/gitMixedOutput.tmp
git log --no-merges --author="$commitsAuthor" --date=short --since="$startDate" --until="$endDate" --pretty=format:"%cd" --numstat --diff-filter=M | awk -F "\t" -f "$executionPath"/pre-format-git-changes.awk -v repoBasePath="$repoBasePath" -v operation="M" >> "$executionPath"/gitMixedOutput.tmp
