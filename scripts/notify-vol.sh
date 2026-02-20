#!/bin/sh
# notify-vol.sh — send dunst notification with current volume level
# Uses dunstify progress bar hint for OSD-style feedback

VOL_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

if [ -z "$VOL_INFO" ]; then
    exit 0
fi

# wpctl outputs: "Volume: 0.65" or "Volume: 0.00 [MUTED]"
VOL=$(echo "$VOL_INFO" | awk '{printf "%.0f", $2 * 100}')
MUTED=$(echo "$VOL_INFO" | grep -c "MUTED")

if [ "$MUTED" -eq 1 ]; then
    dunstify -a "volume" -r 9993 -u low -h "int:value:$VOL" "Volume: muted"
else
    dunstify -a "volume" -r 9993 -u low -h "int:value:$VOL" "Volume: ${VOL}%"
fi
