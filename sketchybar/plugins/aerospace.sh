#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/colors.sh"

# On reload / --update the event env is empty; ask AeroSpace directly instead
if [ -z "$FOCUSED_WORKSPACE" ] && command -v aerospace >/dev/null; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # Focused workspace: brighter glass pill inside the bracket
    sketchybar --animate tanh 12 --set $NAME icon.highlight=true \
        label.highlight=true \
        background.drawing=on
else
    sketchybar --animate tanh 12 --set $NAME icon.highlight=false \
        label.highlight=false \
        background.drawing=off
fi
