#!/bin/bash
source git-webkit2png-shared.sh
mkdir -p "$(root)/.git/$dir"
cd "$(root)/.git/$dir"

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

cdDiffDir $2

for outputFile in $(echo $outputFiles|cut -f3); do
  if [[ -e "$outputFile" ]]; then
    echo $outputFile
  else
    compare -metric AE  "../$1/$outputFile" "../$2/$outputFile" /dev/null 2>/dev/null 1>/dev/null
    if [ $? != "0" ]
    then
      echo $outputFile
      composite "../$1/$outputFile" "../$2/$outputFile" -compose difference "$outputFile"
      # auto level makes it easier to notice differences
      convert   "$outputFile" -auto-level "$outputFile"
    fi
  fi
done

post $PWD
