#!/bin/bash

function findRepositoryBasePath() {
  cd "$1"
  repositoryLocation=$(git config --get remote.origin.url)
  echo "$repositoryLocation"?path=
}

function findCommiter() {
  cd "$1"
  git config --get user.name
}

executionPath=$(pwd)
gitRepositoryLocalDir="$1"
startDate="$2"
endDate="$3"
repoBasePath=$(findRepositoryBasePath "$gitRepositoryLocalDir")
commitsAuthor=$(findCommiter "$gitRepositoryLocalDir")

cd "$gitRepositoryLocalDir"
git log --no-merges --author="$commitsAuthor" --date=short --since="$startDate" --until="$endDate" --pretty=format:"%ad" --numstat --diff-filter=A | awk -f "$executionPath"/pre-format-git-changes.awk -v repoBasePath="$repoBasePath" -v operation="A" >> "$executionPath"/gitMixedOutput.tmp
git log --no-merges --author="$commitsAuthor" --date=short --since="$startDate" --until="$endDate" --pretty=format:"%ad" --numstat --diff-filter=M | awk -f "$executionPath"/pre-format-git-changes.awk -v repoBasePath="$repoBasePath" -v operation="M" >> "$executionPath"/gitMixedOutput.tmp
