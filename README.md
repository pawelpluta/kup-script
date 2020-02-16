# KUP generation script

This script is response for need of generation of report required by Polish tax law interpretation.
Format of this file is compatible with format proposed by lawyers that made analysis for company that I'm currently working for.

## Pre-requirements
This script assumes that you are keeping all your GIT repositories within one directory, and `.git` is directly in sub-directory, like this:
```
Repositories
 |-- project 1
 |    |-- .git
 |    |-- src
 |    |-- some project files
 |-- project 2
      |-- .git
      |-- src
      |-- some project 2 files
```
This script also requires, that you have `awk` command installed on your workspace.

## Usage
`main.sh` is the root of whole script. It requires three parameters:
 * Repositories root dir
 * Start date of git changes that you want to export report from (in format yyyy-MM-dd)
 * End date of git changes that you want to export report to (in format yyyy-MM-dd)

By default, this script will only take into account changes that are:
 * Committed by user with the same name as your git `user.name` (to change it, check `collectGitChanges.sh`)
 * All new files will be included in report
 * In case of modification, only files with at least 6 changed lines will be included (to change it, check `format-kup-report.awk`)
 * Merging commits are not included
 
 
Sample:

`./main.sh ~/Repositories/GitHub/ "2020-01-01" "2020-02-31"`