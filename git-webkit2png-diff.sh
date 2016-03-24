#!/bin/bash
source git-webkit2png-shared.sh

outputDir1=$(outputDir $1)
outputDir2=$(outputDir $2)
diffDir12=$(diffDir $1 $2)
mkdir -p $outputDir1 $outputDir2 $diffDir12

outputFiles=$(comm -23 <(ls $outputDir1) <(ls $outputDir2))
if [[ ! -z $outputFiles ]]; then
  echo Screenshots that only exist for $1
  echo $outputFiles
fi

outputFiles=$(comm -13 <(ls $outputDir1) <(ls $outputDir2))
if [[ ! -z $outputFiles ]]; then
  echo Screenshots that only exist for $2
  echo $outputFiles
fi

outputFiles=$(comm -12 <(ls $outputDir1) <(ls $outputDir2))
echo Screenshots that are different between $1 and $2

for outputFile in $(echo $outputFiles|cut -f3); do
  diffFile="$diffDir12/$outputFile"
  outputFile1="$outputDir1/$outputFile"
  outputFile2="$outputDir2/$outputFile"
  if [[ -e "$diffFile" ]]; then
    echo $outputFile
  else
    compare -metric AE  "$outputFile1" "$outputFile2" /dev/null 2>/dev/null 1>/dev/null
    if [ $? != "0" ]
    then
      echo $outputFile
      composite "$outputFile1" "$outputFile2" -compose difference "$diffFile"
      # auto level makes it somewhat easier to notice differences
      convert   "$diffFile" -auto-level "$diffFile"
    fi
  fi
done

post "$diffDir12"
