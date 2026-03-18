#!/usr/bin/env bash

# Array to keep track of process IDs
PIDS=()

cleanup() {
    for pid in "${PIDS[@]}"; do
        kill -TERM --pid "$pid" 2>/dev/null
    done
    exit 0
}

pipewire & PIDS+=($!)
waybar & PIDS+=($!)
$HOME/.config/sway/scripts/battery_notify.sh & PIDS+=($!)
$HOME/.config/sway/scripts/track_window_focus.sh & PIDS+=($!)
swayidle -w timeout 300 'swaylock -f' & PIDS+=($!)

# Stay alive as long as Sway is running
while pgrep -u "$USER" -x sway > /dev/null; do
    sleep 1
done

cleanup
