#!/bin/bash
echo left > /home/mod3sty/vars/monitorOrientation
xrandr --output $(cat $HOME/vars/monitorscreen) --rotate left
$HOME/.config/bspwm/bspwmrc
