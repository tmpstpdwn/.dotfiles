#!/bin/bash

BG_FILE="$HOME/.bg"

if [ -n "$1" ]; then
    echo "$1" >"$BG_FILE"
    swaybg -i "$1" -m fill &
else
    if [ -f "$BG_FILE" ]; then
        swaybg -i "$(cat "$BG_FILE")" -m fill &
    else
        echo "No background file found!"
        exit 1
    fi
fi
