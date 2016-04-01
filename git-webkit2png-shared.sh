#!/bin/bash
function currentBranch {
  git rev-parse --abbrev-ref HEAD
}

function root {
  # quick fix
  while [[ ! -n $(git rev-parse --show-toplevel) ]]
  do
    cd ..
  done
  git rev-parse --show-toplevel
}

function sha {
  git rev-parse HEAD
}

dir="webkit2png"

function gitConfigGet {
  git config --get $1
}

# gitConfigGet webkit2png.selector
function selector {
  if [[ -n "$1" ]]
  then
    echo "--selector=$1"
  fi
}

# git config --get webkit2png.urlsCommand
function urls {
  if [[ -n "$1" ]]
  then
    url=$(eval "$1")
    if [[ -n "$2" ]]
    then
      if [[ ! -e "$(outputDir $2)/$(urlToOutputFile $url)" ]]
      then
        echo $url
      fi
    else
      echo $url
    fi
  fi
}

function urlToOutputFile {
  echo $(echo $1|cut -b 5-|tr -d ':/.-')-full.png
}

function outputDir {
  echo "$(root)/.git/$dir/$1"
}

function cdOutputDir {
  mkdir -p $(outputDir $1)
  cd $(cd outputDir $1)
}

function diffDir {
  echo "$(root)/.git/$dir/$1$2"
}

function cdDiffDir {
  mkdir -p $(diffDir $1 $2)
  cd $(diffDir $1 $2)
}

function post {
  eval "$(git config --get webkit2png.post) $1"
}

# rev1 rev2 outputFile
function compareR {
  compare -metric AE "$(outputDir $1)/$3" "$(outputDir $2)/$3" /dev/null 2>/dev/null 1>/dev/null
  if [ $? != "0" ]
  then
    composite "$(outputDir $1)/$3" "$(outputDir $2)/$3" -compose difference "$(diffDir $1 $2)/$3"
    # auto level makes it somewhat easier to notice differences
    convert  "$(diffDir $1 $2)/$3" -auto-level "$(diffDir $1 $2)/$3"
  fi
}

# rev1 rev2 outputFiles
function filterOutputFiles {
  for outputFile in $3
  do
    # we are using the existence of a diff to determine should we skip generating one
    # BUT we could have already compared and not had any differences
    # we then end up generating a diff again even though if we recorded more state, we'd be able to tell that this isn't necessary
    if [[ ! -e "$(diffDir $1 $2)/$outputFile" ]]
    then
      echo $outputFile
    fi
  done
}

function webkit2pngCommand {
  echo webkit2png --ignore-ssl-check -D $(outputDir $(sha)) $(selector $(gitConfigGet webkit2png.selector)) -F
}

function parallelOptions {
  echo -j16 --will-cite --bar --delay 2
}

function parallelFor {
  which parallel > /dev/null
  if [[ $? == "0" ]]
  then
    parallel $(parallelOptions) "$1 > /dev/null" {}
  else
    while read line
    do
      echo $line
      eval "$1 $line" > /dev/null
    done
  fi
}
