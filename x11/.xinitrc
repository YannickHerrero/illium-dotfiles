#!/bin/sh

# Source system xinitrc scripts (dbus session, systemd user env, etc.)
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Merge base Xresources (Tokyo Night defaults)
xrdb -merge ~/.Xresources

# Restore pywal colors if cached (overrides base Xresources)
if [ -f ~/.cache/wal/colors.Xresources ]; then
    xrdb -merge ~/.cache/wal/colors.Xresources
fi

# Restore wallpaper from pywal cache, or fall back to default
if [ -f ~/.cache/wal/wal ]; then
    feh --bg-fill "$(cat ~/.cache/wal/wal)" &
elif [ -f ~/wallpapers/default.jpg ]; then
    feh --bg-fill ~/wallpapers/default.jpg &
fi

# Autostart script
~/.config/scripts/autostart.sh &

# Start dwm (loop to allow restart with Alt+Shift+Q)
while true; do
    dwm 2> /tmp/dwm.log
done
