#!/usr/bin/env bash
set -euo pipefail

# Reuse the Hypr wallpaper+pywal loop to avoid config drift.
exec "$HOME/.dotfiles/config/hypr/walstart.sh" "$@"
