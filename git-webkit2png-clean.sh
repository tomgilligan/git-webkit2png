#!/bin/bash
# TODO: be able to clean out a whole bunch of them at once
source git-webkit2png-shared.sh

mkdir -p "$(root)/.git/$dir"
cd "$(root)/.git/$dir"
rm -Rf $(sha)
cd $(root)
