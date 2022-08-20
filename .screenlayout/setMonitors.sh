#!/bin/bash
if [ $(xrandr | grep -c " connected") -gt 1 ]
then
    ./dualmonitor.sh
    echo fuck
else
    ./singlemonitor.sh
fi
