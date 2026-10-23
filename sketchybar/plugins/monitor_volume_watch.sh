#!/bin/bash
# Watches MonitorControl's prefs plist and triggers the sketchybar event
# "monitor_volume_change" (with VOLUME and MUTED env vars) whenever the
# volume or mute state of the monitor that is the current audio output changes.

source "$(dirname "$0")/monitor_volume.sh"

LAST_MTIME=""
LAST_STATE=""
INIT=1

while :; do
  mtime=$(stat -f '%Fm' "$MC_PLIST" 2>/dev/null)
  if [ -n "$mtime" ] && [ "$mtime" != "$LAST_MTIME" ]; then
    LAST_MTIME=$mtime
    if id=$(mc_current_display); then
      mc_read_volume "$id"
      state="$MC_VOLUME:$MC_MUTED"
      if [ "$state" != "$LAST_STATE" ]; then
        sketchybar --trigger monitor_volume_change VOLUME="$MC_VOLUME" MUTED="$MC_MUTED" INIT="$INIT"
        LAST_STATE=$state
      fi
    fi
    INIT=0
  fi
  sleep 0.2
done
