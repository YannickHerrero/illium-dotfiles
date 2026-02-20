#!/bin/sh
# screenshot.sh — take screenshots with maim + xclip
# Usage:
#   screenshot.sh        — full screen to clipboard
#   screenshot.sh -s     — selection to clipboard

if [ "$1" = "-s" ]; then
    maim -s | xclip -selection clipboard -t image/png
else
    maim | xclip -selection clipboard -t image/png
fi
