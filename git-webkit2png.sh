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
    webkit2png --ignore-ssl-check $selctor -F $url
  done
fi
