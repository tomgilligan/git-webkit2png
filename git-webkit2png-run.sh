#!/bin/bash
source git-webkit2png-shared.sh

mkdir -p $(outputDir $(sha))
urls "$(gitConfigGet webkit2png.urlsCommand)" $(sha) | parallelFor "$(webkit2pngCommand)"

post $(outputDir $(sha))
