#!/bin/bash

if [[ -z "$(pgrep ffmpeg)" ]]
then
	echo " off"
else
	echo "  rec"
fi
