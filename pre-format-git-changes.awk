BEGIN {}
/[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}/ {date=$1}
$3 ~ /.+/ {printf "%s\t%s\t%s\t%s%s\n", operation, date, $1, repoBasePath, $3}
