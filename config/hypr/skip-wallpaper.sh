#!/usr/bin/env bash
set -euo pipefail

pkill -f "/bin/bash /home/karimkandil/.dotfiles/config/hypr/walstart.sh" || true
"$HOME/.dotfiles/config/hypr/walstart.sh" &
