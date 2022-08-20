#!/bin/sh
#if [[ $(xrandr --query | grep DP-3)]] || [[ $(xrandr --query | grep DP-1-3) ]]
#then
	xrandr --output $LAPTOPSCREEN --mode 1920x1080 --pos 0x0 --rotate normal --output -1-1 --off --output DP-1-2 --off --output $MONITORSCREEN --primary --mode 1920x1080 --pos 1920x0 --rotate normal
#fi
