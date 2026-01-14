#!/home/karimkandil/.nix-profile/bin/bash

# Directory containing your wallpapers
WALL_DIR="$HOME/Walls/All/"

# History file to store used wallpapers
HISTORY_FILE="$HOME/.cache/wal_history"

# Time between wallpaper changes (seconds)
INTERVAL=500  # idk

# Start swww daemon if it's not already running
if ! pgrep -x "swww-daemon" >/dev/null 2>&1; then
    swww-daemon >/dev/null 2>&1 &
    sleep 1
fi

# Create history file if it doesn't exist
touch "$HISTORY_FILE"

# Infinite loop: shuffle wallpaper and update wal
while true; do
    # Get all wallpapers
    ALL_WALLPAPERS=($(find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \)))

    # If no image found, exit
    [ ${#ALL_WALLPAPERS[@]} -eq 0 ] && echo "No wallpapers found in $WALL_DIR" && exit 1

    # Get used wallpapers
    USED_WALLPAPERS=($(cat "$HISTORY_FILE"))

    # Get unused wallpapers
    UNUSED_WALLPAPERS=()
    for wallpaper in "${ALL_WALLPAPERS[@]}"; do
        if ! [[ " ${USED_WALLPAPERS[@]} " =~ " ${wallpaper} " ]]; then
            UNUSED_WALLPAPERS+=("$wallpaper")
        fi
    done

    # If all wallpapers have been used, clear the history
    if [ ${#UNUSED_WALLPAPERS[@]} -eq 0 ]; then
        echo "All wallpapers have been used. Resetting history."
        > "$HISTORY_FILE"
        UNUSED_WALLPAPERS=("${ALL_WALLPAPERS[@]}")
    fi

    # Pick a random image from the unused wallpapers
    IMG="${UNUSED_WALLPAPERS[RANDOM % ${#UNUSED_WALLPAPERS[@]}]}"

    # Set wallpaper with swww (you can tweak transition options)
    swww img "$IMG" --outputs "DVI-D-1" --transition-type fade --transition-duration 1
    swww img "$IMG" --outputs "HDMI-A-1" --transition-type fade --transition-duration 1

    # Generate colorscheme with wal based on the current wallpaper
    wal -i "$IMG"

    # Source the pywal colors
    source "${HOME}/.cache/wal/colors.sh"

    # Set Hyprland border colors directly
    # You can change color4 and color8 to any other pywal color variable
    hyprctl keyword general:col.active_border "rgb(${color4//#})"
    hyprctl keyword general:col.inactive_border "rgb(${color8//#})"

    # Add the new wallpaper to the history
    echo "$IMG" >> "$HISTORY_FILE"

    # Wait before next wallpaper
    sleep "$INTERVAL"
done

