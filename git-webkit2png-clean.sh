#!/bin/bash
# TODO: be able to clean out a whole bunch of them at once
root=$(git rev-parse --show-toplevel)
rev=$(git rev-parse HEAD)
cd "$root/.git"
rm -Rf $rev
cd $root
