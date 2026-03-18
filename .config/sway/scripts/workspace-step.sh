#!/bin/bash

dir="$1"

current=$(swaymsg -t get_workspaces | jq '.[] | select(.focused).num')

case "$dir" in
  next)
    target=$((current + 1))
    ;;
  prev)
    target=$((current - 1))
    if [ "$target" -lt 1 ]; then
      target=1
    fi
    ;;
  *)
    echo "Usage: $0 next|prev"
    exit 1
    ;;
esac

swaymsg workspace number "$target"
