BEGIN {
  fileName=""
  date=""
  linesChanged=0
  fileChangeSymbol="M"
}
$4 != fileName {
  if(fileName!="") {
    printf "%s\t%s\t%s\t%s\n", fileChangeSymbol, date, linesChanged, fileName
  }
  fileChangeSymbol="M"
  date=$2
  linesChanged=0
  fileName=$4
}
$1 == "A" {fileChangeSymbol="A"}
$3 ~ /[[:digit:]]/ {linesChanged+=$3}
