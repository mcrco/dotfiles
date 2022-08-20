#!/bin/bash

DIR=$HOME/.config/polybar/scripts/screenrecording

if [[ -z "$(pgrep ffmpeg)" ]] 
then
	$DIR/startrecording.sh
else 
	$DIR/stoprecording.sh
fi
