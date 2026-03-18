#!/bin/bash

id=$(cat /tmp/sway-last-focus.prev 2>/dev/null)

if [ -n "$id" ]; then
    swaymsg "[con_id=$id]" focus
fi
