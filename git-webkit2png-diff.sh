#!/bin/bash
source git-webkit2png-shared.sh

outputDir1=$(outputDir $1)
outputDir2=$(outputDir $2)
diffDir12=$(diffDir $1 $2)
mkdir -p $outputDir1 $outputDir2 $diffDir12

# should this go to stderr or a log maybe?
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
for outputFile in $(filterOutputFiles $1 $2 "$outputFiles")
do
  compareR $1 $2 $outputFile
done

post "$diffDir12"
