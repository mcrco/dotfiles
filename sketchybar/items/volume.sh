#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$BLUE
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$GLASS_BORDER
  slider.knob=􀀁
  slider.knob.drawing=off
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=10
  icon=$VOLUME_100
  icon.width=0
  icon.align=left
  icon.color=$GREY
  icon.font="$FONT:Regular:14.0"
  label.width=25
  label.align=left
  label.font="$FONT:Regular:14.0"
)

status_bracket=(
  "${glass[@]}"
)

sketchybar --add event monitor_volume_change    \
           --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              monitor_volume_change \
                              mouse.clicked     \
                              mouse.entered     \
                              mouse.exited      \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"

sketchybar --add bracket status brew github.bell volume_icon \
           --set status "${status_bracket[@]}"

# Follow the monitor volume that MonitorControl sets over DDC (macOS does not
# emit volume_change for HDMI/DisplayPort audio, so we watch MonitorControl's prefs)
pkill -f monitor_volume_watch.sh
"$PLUGIN_DIR/monitor_volume_watch.sh" >/dev/null 2>&1 &
