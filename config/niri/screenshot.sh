#!/bin/sh
region=$(slurp) || exit 0
file="$HOME/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
mkdir -p "$(dirname "$file")"
grim -g "$region" "$file"
printf '%s' "$file" | wl-copy
