#!/bin/bash

# Start some services; Make sure they are terminated when sway exits.

GREEN='\033[32m'
ORANGE='\033[38;5;208m'
RED='\033[31m'
RESET='\033[0m'

SERVICES=(
    "xwayland-satellite:xwayland-satellite"
    "waybar:waybar"
    "randwal:$HOME/.config/sway/scripts/randwal.sh"
    "gammastep:gammastep -O 3500"
    "pipewire:pipewire"
    "battery_notify:$HOME/.config/sway/scripts/battery_notify.sh"
    "track_focus:$HOME/.config/sway/scripts/track_window_focus.sh"
    "swayidle:swayidle -w timeout 300 'swaylock -f'"
    "mako:mako"
)

pids=()

# Start services.
startup () {
    mkdir -p $HOME/.cache
    echo "" > "$HOME/.cache/autostart.log"

    echo -ne "${ORANGE}Starting all autostart processes...${RESET}"

    for item in "${SERVICES[@]}"; do
        name="${item%%:*}"
        cmd="${item#*:}"
        setsid bash -c "$cmd" >>$HOME/.cache/autostart.log 2>&1 &
        pids+=($!)
    done

    sleep 2

    failed=false
    for i in "${!pids[@]}"; do
        pid="${pids[$i]}"
        item="${SERVICES[$i]}"
        name="${item%%:*}"
        if ! kill -0 "$pid" 2>/dev/null; then
            wait "$pid"
            status=$?
            if [ "$status" -ne 0 ]; then
                echo -e "\r${RED}Process $name (PID $pid) failed during startup with exit code $status.${RESET}" >&2
                failed=true
            fi
        fi
    done

    if $failed; then
        exit 1
    fi

    echo -e "\r${GREEN}All autostart processes started.          ${RESET}"
}

# Send a TERM or KILL signal to all running services.
# TERM / KILL is provided as $1.
stop_service() {
    local signal="$1"

    for i in "${!pids[@]}"; do
        pid="${pids[$i]}"

        if kill -0 "$pid" 2>/dev/null; then
            kill -s "$signal" -- "-$pid" 2>/dev/null
        fi
    done
}

cleanup() {
    echo -ne "${ORANGE}Stopping all running autostart processes...${RESET}"
    stop_service TERM
    sleep 5
    stop_service KILL
    echo -e "\r${GREEN}All running autostart processes stopped.          ${RESET}"
    exit 0
}

# Cleanup on exit.
trap cleanup EXIT

# Startup services; exit and trigger cleanup incase of errors.
startup

# Block script exit until sway exits, which then will trigger cleanup.
swaymsg -t subscribe -m '["shutdown"]' >/dev/null 2>&1
