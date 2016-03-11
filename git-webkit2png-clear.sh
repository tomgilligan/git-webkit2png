#!/bin/bash
root=$(git rev-parse --show-toplevel)
rev=$(git rev-parse HEAD)
cd "$root/.git"
rm -Rf $rev
cd $root
