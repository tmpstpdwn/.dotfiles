#!/bin/bash

state_file="/tmp/sway-last-focus"
touch "$state_file"

swaymsg -m -t subscribe '["window"]' | jq --unbuffered -c '
  select(.change == "focus") | .container.id
' | while read -r id; do
    if [ -n "$id" ]; then
        prev=$(cat "$state_file" 2>/dev/null)
        if [ "$id" != "$prev" ]; then
            echo "$prev" > "${state_file}.prev"
            echo "$id" > "$state_file"
        fi
    fi
done
