#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [[ -d "$WALLPAPER_DIR" ]]; then
    wallpaper=$(find "$WALLPAPER_DIR" -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
        -o -iname '*.webp' -o -iname '*.avif' \) | shuf -n 1)
fi

pkill swaybg 2>/dev/null

if [[ -n "$wallpaper" ]]; then
    swaybg -i "$wallpaper" -m fill &
else
    swaybg -c '#111111' &
fi
