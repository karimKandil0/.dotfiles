#!/usr/bin/env bash
set -euo pipefail

pkill -f "/bin/bash /home/karimkandil/.dotfiles/config/hypr/modules/walstart.sh" || true
"$HOME/.dotfiles/config/hypr/modules/walstart.sh" &
