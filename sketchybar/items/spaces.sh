#!/bin/bash

sketchybar --add event aerospace_workspace_change
spaces=()
# Works under both AeroSpace and Rift (Rift workspaces are named "1".."10", 0-based index)
if pgrep -xq AeroSpace; then
    workspaces=$(aerospace list-workspaces --all)
    switch_cmd='aerospace workspace $sid'
else
    workspaces=$(seq 1 10)
    switch_cmd='rift-cli execute workspace switch $((sid - 1))'
fi
first_ws=$(echo "$workspaces" | head -n1)
last_ws=$(echo "$workspaces" | tail -n1)
for sid in $workspaces; do
    # Fixed-width, centred icon so every highlight pill is the same size (28x20).
    # SF Pro's "1" has uneven side bearings, so nudge it 1px left.
    icon_width=28; icon_pad_left=0; icon_pad_right=0
    if [ "$sid" = "1" ]; then icon_width=26; icon_pad_right=2; fi
    # 1px between neighbours (2px pill-to-pill); 3px at the bracket ends so the
    # end pills sit concentric with the bracket's 3px vertical inset
    pad_left=1; pad_right=1
    [ "$sid" = "$first_ws" ] && pad_left=3
    [ "$sid" = "$last_ws" ] && pad_right=3
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        icon="$sid" \
        icon.width=$icon_width \
        icon.align=center \
        icon.padding_left=$icon_pad_left \
        icon.padding_right=$icon_pad_right \
        padding_left=$pad_left \
        padding_right=$pad_right \
        label.padding_right=20 \
        icon.highlight_color=$RED \
        label.color=$GREY \
        label.highlight_color=$WHITE \
        label.font="sketchybar-app-font:Regular:16.0" \
        label.y_offset=-1 \
        background.color=$GLASS_FILL_ACTIVE \
        background.border_width=0 \
        background.height=20 \
        background.corner_radius=10 \
        background.shadow.drawing=off \
        background.drawing=off \
        label.drawing=off \
        script="$PLUGIN_DIR/aerospace.sh $sid" \
        click_script="$(eval echo "\"$switch_cmd\"")"

done

spaces_bracket=(
    "${glass[@]}"
)

sketchybar --add bracket spaces_bracket '/space\..*/' \
    --set spaces_bracket "${spaces_bracket[@]}"
