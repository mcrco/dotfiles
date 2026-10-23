#!/bin/bash
# Shared helpers for reading the monitor volume that MonitorControl sets over DDC.
# MonitorControl keeps the last value it sent in its prefs plist:
#   value98(<DISPLAY>@<n>)  -> volume, 0.0 .. 1.0   (DDC VCP 0x62)
#   value141(<DISPLAY>@<n>) -> mute, 1 = muted, 2 = unmuted (DDC VCP 0x8D)

MC_PLIST="$HOME/Library/Preferences/app.monitorcontrol.MonitorControl.plist"

# Force a specific display id (e.g. "LGULTRAWIDE778930697@2") instead of
# matching the current audio output device by name. Leave empty to auto-detect.
MC_DISPLAY_OVERRIDE=""

mc_norm() { printf '%s' "$1" | tr '[:lower:]' '[:upper:]' | tr -cd 'A-Z'; }

# Prints the MonitorControl display id whose name matches the current audio
# output device. Returns 1 if the output is not a DDC monitor (e.g. speakers).
mc_current_display() {
  if [ -n "$MC_DISPLAY_OVERRIDE" ]; then echo "$MC_DISPLAY_OVERRIDE"; return 0; fi
  [ -r "$MC_PLIST" ] || return 1
  command -v SwitchAudioSource >/dev/null || return 1

  local out norm key id name kn
  out=$(SwitchAudioSource -c -t output 2>/dev/null)
  norm=$(mc_norm "$out")
  [ ${#norm} -ge 3 ] || return 1

  while IFS= read -r key; do
    id=${key#value98(}; id=${id%)}
    case "$id" in *"|"*) continue ;; esac   # skip mirror-set entries
    name=${id%@*}
    kn=$(mc_norm "$name")
    [ ${#kn} -ge 3 ] || continue
    if [[ "$norm" == *"$kn"* || "$kn" == *"$norm"* ]]; then
      echo "$id"; return 0
    fi
  done < <(plutil -convert xml1 -o - "$MC_PLIST" 2>/dev/null \
           | grep -o '<key>value98([^<]*)</key>' | sed 's/<key>//; s#</key>##')
  return 1
}

# Sets MC_VOLUME (0-100) and MC_MUTED (0/1) for the given display id.
mc_read_volume() {
  local id=$1 raw mute
  raw=$(plutil -extract "value98($id)" raw -o - "$MC_PLIST" 2>/dev/null)
  mute=$(plutil -extract "value141($id)" raw -o - "$MC_PLIST" 2>/dev/null)
  MC_VOLUME=$(awk -v v="${raw:-0}" 'BEGIN { p = v * 100 + 0.5; if (p < 0) p = 0; if (p > 100) p = 100; printf "%d", p }')
  MC_MUTED=0
  [ "$mute" = "1" ] && MC_MUTED=1
}
