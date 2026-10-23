#!/bin/bash

WIDTH=100

icon_for() {
  source "$CONFIG_DIR/icons.sh"
  case $1 in
    [6-9][0-9]|100) ICON=$VOLUME_100 ;;
    [3-5][0-9]) ICON=$VOLUME_66 ;;
    [1-2][0-9]) ICON=$VOLUME_33 ;;
    [1-9]) ICON=$VOLUME_10 ;;
    0) ICON=$VOLUME_0 ;;
    *) ICON=$VOLUME_100 ;;
  esac
}

show_slider() {
  sketchybar --set $NAME slider.percentage=$1 \
             --animate tanh 30 --set $NAME slider.width=$WIDTH

  sleep 2

  # Check wether the volume was changed another time while sleeping
  FINAL_PERCENTAGE=$(sketchybar --query $NAME | jq -r ".slider.percentage")
  if [ "$FINAL_PERCENTAGE" -eq "$1" ]; then
    sketchybar --animate tanh 30 --set $NAME slider.width=0
  fi
}

# macOS system volume changed (built-in speakers, AirPods, ...)
volume_change() {
  icon_for "$INFO"
  sketchybar --set volume_icon label=$ICON
  show_slider "$INFO"
}

# MonitorControl changed the monitor's DDC volume (see monitor_volume_watch.sh)
monitor_volume_change() {
  if [ "$MUTED" = "1" ]; then
    source "$CONFIG_DIR/icons.sh"
    ICON=$VOLUME_0
  else
    icon_for "$VOLUME"
  fi
  sketchybar --set volume_icon label=$ICON

  if [ "$INIT" = "1" ]; then
    # Startup sync: set the state without popping the slider open
    sketchybar --set $NAME slider.percentage=$VOLUME
  else
    show_slider "$VOLUME"
  fi
}

mouse_clicked() {
  source "$CONFIG_DIR/plugins/monitor_volume.sh"
  if mc_current_display >/dev/null && command -v m1ddc >/dev/null; then
    # Output is a DDC monitor: set its hardware volume directly
    m1ddc set volume "$PERCENTAGE" >/dev/null 2>&1
  else
    osascript -e "set volume output volume $PERCENTAGE"
  fi
}

mouse_entered() {
  sketchybar --set $NAME slider.knob.drawing=on
}

mouse_exited() {
  sketchybar --set $NAME slider.knob.drawing=off
}

case "$SENDER" in
  "volume_change") volume_change ;;
  "monitor_volume_change") monitor_volume_change ;;
  "mouse.clicked") mouse_clicked ;;
  "mouse.entered") mouse_entered ;;
  "mouse.exited") mouse_exited ;;
esac
