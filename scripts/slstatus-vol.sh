#!/bin/sh
# slstatus-vol.sh — output current volume for slstatus
# Reads PipeWire volume via wpctl, outputs "XX%" or "muted"

VOL_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

if [ -z "$VOL_INFO" ]; then
    echo "n/a"
    exit 0
fi

VOL=$(echo "$VOL_INFO" | awk '{printf "%.0f", $2 * 100}')
MUTED=$(echo "$VOL_INFO" | grep -c "MUTED")

if [ "$MUTED" -eq 1 ]; then
    echo "muted"
else
    echo "${VOL}%"
fi
