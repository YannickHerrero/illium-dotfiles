#!/bin/sh
# wal-set.sh — set wallpaper and generate color scheme with pywal16
# Usage: wal-set.sh <path-to-wallpaper>

if [ -z "$1" ]; then
    echo "Usage: wal-set.sh <path-to-wallpaper>"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: file '$1' not found"
    exit 1
fi

# Generate color scheme (skip setting wallpaper, we use feh)
wal -i "$1" -n

# Set wallpaper with feh
feh --bg-fill "$1"
