#!/bin/sh
# webapp-launch.sh — launch a URL in a dedicated Firefox window
# Usage: webapp-launch.sh <url>

if [ -z "$1" ]; then
    printf "Usage: webapp-launch.sh <url>\n" >&2
    exit 1
fi

exec firefox --new-window "$1" &
