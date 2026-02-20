#!/bin/sh
# tuiapp-launch.sh — launch a TUI app inside an st terminal
# Usage: tuiapp-launch.sh <command> [args...]

if [ -z "$1" ]; then
    printf "Usage: tuiapp-launch.sh <command> [args...]\n" >&2
    exit 1
fi

exec st -e "$@" &
