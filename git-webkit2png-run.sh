#!/bin/bash
# TODO: parameter to ignore existing output
# TODO add config option for adding any old options to webkit2png
source git-webkit2png-shared.sh

mkdir -p $(outputDir $(sha))
# the main thing parallel gives us is job management and progress tracking
# timing with different parameters, we don't get much out of the actual parallelilzation that it does
urls "$(gitConfigGet webkit2png.urlsCommand)" |  tr ' ' $'\n' | parallel -j16 --will-cite --bar --delay 2 webkit2png --ignore-ssl-check -D $(outputDir $(sha)) $(selector $(gitConfigGet webkit2png.selector)) -F {} > /dev/null

post $(outputDir $(sha))
