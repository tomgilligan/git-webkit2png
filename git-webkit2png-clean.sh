#!/bin/bash
# TODO: be able to clean out a whole bunch of them at once
source git-webkit2png-shared.sh

rm -Rf $(outputDir $(sha))
