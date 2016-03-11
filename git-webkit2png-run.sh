#!/bin/bash
# TODO: parameter to ignore existing output

root=$(git rev-parse --show-toplevel)
rev=$(git rev-parse HEAD)
warning=""
selector=$(git config --get webkit2png.selector)
dir="webkit2png"
if [[ -n "$selector" ]]
then
  selctor="--selector=$selector"
fi
urlsCommand=$(git config --get webkit2png.urlsCommand)
if [[ -n "$urlsCommand" ]]
then
  urls=$(eval $urlsCommand)
  cd "$root/.git"
  mkdir -p $dir/$rev
  cd $dir/$rev

  for url in $urls
  do
    # for now lets assume http and do a byte offset
    outputFile="$(echo $url|cut -b 5-|tr -d ':/.-')-full.png"
    if [[ -e $outputFile ]]
    then
      true
    else
      # TODO add config option for adding any old options to webkit2png
      webkit2png --ignore-ssl-check $selctor -F $url
      if [[ ! -e $outputFile ]]
      then
        # TODO make this warning more robust
        if [[ -z $warning ]]
        then
          echo "$outputFile was expected to exist after running webkit2png but it does not: won't be able to skip existing files"
          let warning="dont"
        fi
      fi
    fi
  done
fi

post=$(git config --get webkit2png.post)
eval $post
cd $root
