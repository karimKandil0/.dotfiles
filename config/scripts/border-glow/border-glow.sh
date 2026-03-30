#!/usr/bin/env bash

# 1. Get the color from Pywal (6th line)
PYWAL_COLOR=$(sed -n '6p' "$HOME/.cache/wal/colors" | sed 's/#//')
[ -z "$PYWAL_COLOR" ] && PYWAL_COLOR="ff0000" # Fallback to Red for testing

# 2. Flash settings
# We set the border size to 5 and the color to your accent
hyprctl keyword general:border_size 5
hyprctl keyword general:col.active_border "0xff$PYWAL_COLOR"

sleep 0.15

# 3. Reset to your standard look
hyprctl keyword general:border_size 2
hyprctl keyword general:col.active_border "0xff444444"
