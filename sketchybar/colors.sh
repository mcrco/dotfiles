#!/bin/bash

# Color Palette
export BLACK=0xff181926
export WHITE=0xffcad3f5
export RED=0xffed8796
export GREEN=0xffa6da95
export BLUE=0xff8aadf4
export YELLOW=0xffeed49f
export ORANGE=0xfff5a97f
export MAGENTA=0xffc6a0f6
export GREY=0xff939ab7
export TRANSPARENT=0x00000000

# Module pills: the old dark grey-blue tint, a touch lighter/more translucent, with a brighter hairline edge
export GLASS_FILL=0x50454862          # resting pill fill (was BACKGROUND_1 = 0x603c3e4f)
export GLASS_FILL_ACTIVE=0x2cffffff   # selected workspace pill
export GLASS_BORDER=0x8a5c6180        # hairline edge (was BACKGROUND_2 = 0x60494d64)

# General bar colors
export BAR_COLOR=0xCC000000
export BAR_BORDER_COLOR=0x2effffff  # faint specular rim along the bar edge
export ICON_COLOR=$WHITE # Color of all icons
export LABEL_COLOR=$WHITE # Color of all labels
export BACKGROUND_1=0x603c3e4f
export BACKGROUND_2=0x60494d64

export POPUP_BACKGROUND_COLOR=0xd01e1e2e
export POPUP_BORDER_COLOR=$GLASS_BORDER

export SHADOW_COLOR=$BLACK
