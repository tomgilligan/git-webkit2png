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
