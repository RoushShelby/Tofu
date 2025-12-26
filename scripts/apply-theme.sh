#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/wallpaper.png"
    exit 1
fi

WALLPAPER="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT/config/matugen"

if [ ! -f "$WALLPAPER" ]; then
    echo "Error: Wallpaper not found: $WALLPAPER"
    exit 1
fi

echo "Generating colors from: $WALLPAPER"
matugen image "$WALLPAPER" --config config.toml

if [ $? -eq 0 ]; then
    echo "✓ Colors generated!"
    echo ""
    echo "Restart quickshell to see changes:"
    echo "  Ctrl+C and run: quickshell -c config/quickshell/default"
else
    echo "✗ Failed to generate colors"
    exit 1
fi