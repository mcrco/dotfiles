#!/bin/bash
echo normal > /home/mod3sty/vars/monitorOrientation
xrandr --output $(cat $HOME/vars/monitorscreen) --rotate normal
$HOME/.config/bspwm/bspwmrc
