#!/bin/bash
function root {
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
    echo $(eval "$1")
  fi
}

function urlToOutputFile {
  echo $(echo $1|cut -b 5-|tr -d ':/.-')-full.png
}

function cdOutputDir {
  cd "$(root)/.git"
  mkdir -p $dir/$(sha)
  cd $dir/$(sha)
}

function post {
  eval "$(git config --get webkit2png.post) $1"
}

#root
#sha
#selector ""
#selector "#content"
#urls "echo 1 + 1 | bc"
#urlToOutputFile 'http://localhost/file.html'
#cdOutputDir
#echo $PWD
