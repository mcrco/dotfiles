#!/bin/bash

if [[ $(optimus-manager --print-mode) == "Current GPU mode : nvidia" ]]
then
	echo "eDP-1-1" > /home/mod3sty/vars/laptopscreen
	echo "DP-1-1" > /home/mod3sty/vars/monitorscreen
else
	echo "eDP-1" > /home/mod3sty/vars/laptopscreen
	echo "DP-1" > /home/mod3sty/vars/monitorscreen
fi
