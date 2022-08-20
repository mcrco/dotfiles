#!/usr/bin/env bash

# Add this script to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bars
#polybar allbar -c $HOME/.config/polybar/monitorbar.ini &
#polybar allbar -c $HOME/.config/polybar/laptopbar.ini &
#for m in $(polybar --list-monitors | cut -d":" -f1); do
#    MONITOR=$m polybar --reload allbar -c /home/mod3sty/.config/polybar/allbar.ini & 
#done


ls | grep bar.ini | while read -r line ; do
	polybar ${line%.ini} -c $line &
done
