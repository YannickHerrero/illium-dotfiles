#!/bin/sh

# Merge Xresources
xrdb -merge ~/.Xresources

# Set wallpaper (pywal also sets it, this is fallback)
feh --bg-fill ~/wallpapers/default.jpg &

# Autostart script
~/.config/scripts/autostart.sh &

# Start dwm (loop to allow restart with Alt+Shift+Q)
while true; do
    dwm 2> /tmp/dwm.log
done
