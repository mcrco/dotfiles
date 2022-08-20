#!/bin/sh
/home/mod3sty/.screenlayout/setMonitorVars.sh
xrandr --output $(cat /home/mod3sty/vars/laptopscreen) --mode 1920x1080 --pos 0x0 --rotate normal --output $(cat /home/mod3sty/vars/monitorscreen) --primary --mode 2560x1440 --pos 1920x0 --rotate $(cat /home/mod3sty/vars/monitorOrientation)

