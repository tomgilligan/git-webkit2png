#!/bin/bash
# TODO: parameter to ignore existing output
source git-webkit2png-shared.sh


for url in $(urls "$(gitConfigGet webkit2png.urlsCommand)")
do
  cdOutputDir
  # for now lets assume http and do a byte offset
  if [[ ! -e $(urlToOutputFile $url) ]]
  then
    # TODO add config option for adding any old options to webkit2png
    webkit2png --ignore-ssl-check $(selector $(gitConfigGet webkit2png.selector)) -F $url
  fi
done

post $PWD
