#!/bin/sh

# Merge base Xresources (Tokyo Night defaults)
xrdb -merge ~/.Xresources

# Restore pywal colors if cached (overrides base Xresources)
if [ -f ~/.cache/wal/colors.Xresources ]; then
    xrdb -merge ~/.cache/wal/colors.Xresources
fi

# Restore wallpaper from pywal cache, or fall back to default
if [ -f ~/.cache/wal/wal ]; then
    feh --bg-fill "$(cat ~/.cache/wal/wal)" &
else
    feh --bg-fill ~/wallpapers/default.jpg &
fi

# Autostart script
~/.config/scripts/autostart.sh &

# Start dwm (loop to allow restart with Alt+Shift+Q)
while true; do
    dwm 2> /tmp/dwm.log
done
