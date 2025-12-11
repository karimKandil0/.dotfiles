#!/bin/bash
# This script restarts the walstart.sh script to skip to the next wallpaper.
pkill -f walstart.sh
/home/karimkandil/.dotfiles/config/hypr/walstart.sh &
