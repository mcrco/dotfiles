#!/bin/bash
# Close the focused window without going through `aerospace close`.
# `aerospace close` drops the window from its tree immediately, so when the app
# shows a "confirm close" sheet instead of closing, AeroSpace has already moved
# focus to the previous window. Closing via the app itself avoids that.

osascript <<'EOF' || aerospace close
tell application "System Events"
    set proc to first process whose frontmost is true
    tell proc
        if name is "Ghostty" then
            -- hidden titlebar has no close button; use the menu (immune to held modifiers)
            click menu item "Close Window" of menu "File" of menu bar 1
        else
            click (first button of window 1 whose subrole is "AXCloseButton")
        end if
    end tell
end tell
EOF
