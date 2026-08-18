#!/bin/bash

# Start some services; Make sure they are terminated when sway exits.

RED='\033[31m'
GREEN='\033[32m'
RESET='\033[0m'

SERVICES=(
    "pipewire:pipewire"
    "waybar:waybar"
    "battery_notify:$HOME/.config/sway/scripts/battery_notify.sh"
    "track_focus:$HOME/.config/sway/scripts/track_window_focus.sh"
    "swayidle:swayidle -w timeout 300 'swaylock -f'"
    "mako:mako"
    "xwayland-satellite:xwayland-satellite"
)

pids=()

# Start services.
startup () {
    for item in "${SERVICES[@]}"; do
        name="${item%%:*}"
        cmd="${item#*:}"
        setsid bash -c "$cmd" >/dev/null 2>&1 &
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
            echo -e "${RED}ERROR:${RESET} $name (PID $pid) failed during startup with exit code $status." >&2
            failed=true
        fi
    done

    if $failed; then
        exit 1
    fi

    echo -e "${GREEN}SUCCESS:${RESET} All services started properly."
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

# Stop services.
cleanup() {
    stop_service TERM
    sleep 5
    stop_service KILL
    echo -e "${GREEN}SUCCESS:${RESET} All running services stopped properly."
    exit 0
}

# Cleanup on exit.
trap cleanup EXIT

# Startup services; exit and trigger cleanup incase of errors.
startup

# Block script exit until sway exits, which then will trigger cleanup.
swaymsg -t subscribe -m '["shutdown"]' >/dev/null 2>&1
