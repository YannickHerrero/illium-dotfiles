#!/bin/sh
# statusbar.sh — fallback status bar using xsetroot
# Only needed if slstatus is not running

while true; do
    BAT=$(cat /sys/class/power_supply/macsmc-battery/capacity 2>/dev/null || echo "n/a")
    BAT_STATUS=$(cat /sys/class/power_supply/macsmc-battery/status 2>/dev/null || echo "")
    CPU=$(top -bn1 | awk '/Cpu/ {printf "%.0f", $2}')
    MEM=$(free | awk '/Mem/ {printf "%.0f", $3/$2 * 100}')
    DATE=$(date "+%a %d %b %H:%M")

    xsetroot -name " CPU ${CPU}% | RAM ${MEM}% | BAT ${BAT}% ${BAT_STATUS} | ${DATE}"
    sleep 1
done
