#!/bin/bash
root=$(git rev-parse --show-toplevel)
dir="webkit2png"
mkdir -p "$root/.git/$dir"
cd "$root/.git/$dir"
outputFiles=$(comm -23 <(ls $1) <(ls $2))
if [[ ! -z $outputFiles ]]; then
  echo Screenshots that only exist for $1
  echo $outputFiles
fi
outputFiles=$(comm -13 <(ls $1) <(ls $2))
if [[ ! -z $outputFiles ]]; then
  echo Screenshots that only exist for $2
  echo $outputFiles
fi
outputFiles=$(comm -12 <(ls $1) <(ls $2))
echo Screenshots that are different between $1 and $2
mkdir -p "$1$2"
for outputFile in $(echo $outputFiles|cut -f3); do
  if [[ -e "$1$2/$outputFile" ]]; then
    echo $outputFile
  else
    compare -metric AE  "$1/$outputFile" "$2/$outputFile" /dev/null 2>/dev/null 1>/dev/null
    if [ $? != "0" ]
    then
      echo $outputFile
      composite "$1/$outputFile" "$2/$outputFile" -compose difference "$1$2/$outputFile"
      # auto level makes it easier to notice differences
      convert   "$1$2/$outputFile" -auto-level "$1$2/$outputFile"
    fi
  fi
done

cd "$1$2"
post=$(git config --get webkit2png.post)
eval $post
cd $root
