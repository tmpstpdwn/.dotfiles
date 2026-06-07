#!/bin/bash

LAST_STATE=""
LAST_LOW=0
LAST_FULL=0
LOW=20
NOW=0

while true; do
    LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
    STATE=$(cat /sys/class/power_supply/BAT0/status)
    NOW=$(date +%s)

    if [[ "$STATE" == "Discharging" && "$LEVEL" -le "$LOW" ]]; then
        if ((NOW - LAST_LOW >= 60)); then
            notify-send -u critical -t 5000 "Battery Low" "${LEVEL}%"
            LAST_LOW=$NOW
        fi
    elif [[ "$STATE" == "Full" ]]; then
        if ((NOW - LAST_FULL >= 60)); then
            notify-send -t 5000 "Battery Full" "Unplug charger"
            LAST_FULL=$NOW
        fi
    elif [[ "$STATE" == "Charging" && "$LAST_STATE" != "Charging" ]]; then
        LAST_LOW=0
        LAST_FULL=0
        notify-send "Battery Charging" "${LEVEL}%"
    fi

    LAST_STATE="$STATE"
    sleep 1
done
