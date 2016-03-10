#!/bin/bash

selector=$(git config --get webkit2png.selector)
if [[ -n "$selector" ]]
then
  let selctor="--selector=$selector"
fi
urlsCommand=$(git config --get webkit2png.urlsCommand)
if [[ -n "$urlsCommand" ]]
then
  urls=$(eval $urlsCommand)

  for url in $urls
  do
    # for now lets assume http and do a byte offset
    outputFile="$(echo $url|cut -b 5-|tr -d ':/.-')-full.png"
    if [[ -e $outputFile ]]
    then
      true
    else
      webkit2png --ignore-ssl-check $selctor -F $url
    fi
  done
fi
