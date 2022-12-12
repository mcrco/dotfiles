#!/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6")

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                 \
             --set space.$sid associated_space=$sid                      \
                              icon=${SPACE_ICONS[i]}                     \
                              icon.font="SF Pro:Bold:14.0"  \
                              icon.padding_left=12                        \
                              icon.padding_right=4                       \
                              icon.highlight_color=0xffffffff \
                              icon.color=0xff999999 \
                              background.drawing=off \
                              background.padding_left=5                  \
                              background.padding_right=5                 \
                              # background.color=0x44ffffff                \
                              # background.corner_radius=0                 \
                              # background.height=22                       \
                              # background.drawing=on                     \
                              # label.background.height=26                    \
                              # label.background.drawing=on                   \
                              # label.background.color=0xffffffff  \
                              # label.background.corner_radius=9              \
                              # label.drawing=off                             \
                              script="$PLUGIN_DIR/space.sh"              \
                              click_script="yabai -m space --focus $sid"
done
