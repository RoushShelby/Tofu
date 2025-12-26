#!/usr/bin/env bash
set -e

WALL="${1:-$HOME/wallpaper.png}"

if [[ ! -f "$WALL" ]]; then
    echo "Wallpaper not found: $WALL"
    exit 1
fi

matugen image "$WALL"
systemctl --user restart quickshell
