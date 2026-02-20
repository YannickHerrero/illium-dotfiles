#!/bin/sh
# notify-brightness.sh — send dunst notification with current brightness level
# Uses dunstify progress bar hint for OSD-style feedback

BRIGHTNESS=$(brightnessctl -m 2>/dev/null | awk -F, '{print $4}' | tr -d '%')

if [ -z "$BRIGHTNESS" ]; then
    exit 0
fi

dunstify -a "brightness" -r 9994 -u low -h "int:value:$BRIGHTNESS" "Brightness: ${BRIGHTNESS}%"
