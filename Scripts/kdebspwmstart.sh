#!/bin/bash
if [[ $(wmctrl -m | grep bswpm) == "Name: KWin" ]]
then
	$HOME/.screenlayout/dualmonitor.sh
	latte-dock --layout kde &
fi

