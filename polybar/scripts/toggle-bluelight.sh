#!/bin/bash

if [ ! -z $(pgrep redshift) ];
	then
		redshift -x && pkill redshift && killall redshift
else
	while pgrep -u $UID -x redshift >/dev/null; do sleep 1; done
	redshift -l 37.5:-121.9 -t 5000:4500 -r &>/dev/null &
fi
