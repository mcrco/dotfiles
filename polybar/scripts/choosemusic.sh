#!/bin/bash

if [[ $(pgrep -c firefox) -eq 0 ]]
then
	echo "ﱘ  No Music Playing"
else
	/home/mod3sty/.config/polybar/scripts/browsermediacontrol
fi
