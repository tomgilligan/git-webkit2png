#!/bin/bash
# TODO: be able to clean out a whole bunch of them at once
root=$(git rev-parse --show-toplevel)
rev=$(git rev-parse HEAD)
dir="webkit2png"
mkdir -p "$root/.git/$dir"
cd "$root/.git/$dir"
rm -Rf $rev
cd $root
