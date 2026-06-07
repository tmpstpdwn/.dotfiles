#!/bin/bash

declare -A PROCS

SERVICES=(
    "pipewire:pipewire"
    "waybar:waybar"
    "battery_notify:$HOME/.config/sway/scripts/battery_notify.sh"
    "track_focus:$HOME/.config/sway/scripts/track_window_focus.sh"
    "swayidle:swayidle -w timeout 300 'swaylock -f'"
    "mako:mako"
)

start_services() {
    for entry in "${SERVICES[@]}"; do
        local name="${entry%%:*}"
        local cmd="${entry#*:}"
        setsid bash -c "$cmd" &
        PROCS[$name]=$!
    done
}

cleanup() {
    echo "Sway exited, stopping services..."

    for name in "${!PROCS[@]}"; do
        local pid=${PROCS[$name]}
        local pgid
        pgid=$(ps -o pgid= -p "$pid" 2>/dev/null | tr -d ' ')
        if [[ -n "$pgid" && "$pgid" -gt 1 ]]; then
            echo "  stopping $name (pgid -$pgid)"
            kill -TERM -"$pgid" 2>/dev/null
        fi
    done

    sleep 2

    for name in "${!PROCS[@]}"; do
        local pid=${PROCS[$name]}
        local pgid
        pgid=$(ps -o pgid= -p "$pid" 2>/dev/null | tr -d ' ')
        if [[ -n "$pgid" && "$pgid" -gt 1 ]]; then
            echo "  force-killing $name (pgid -$pgid)"
            kill -KILL -"$pgid" 2>/dev/null
        fi
    done
}

trap cleanup EXIT

start_services

while pgrep -u "$USER" -x sway >/dev/null; do
    sleep 1
done
