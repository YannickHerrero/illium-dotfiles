#!/bin/sh
# autostart.sh — launched by dwm on startup via .xinitrc

# Compositor
picom --daemon &

# Notification daemon
dunst &

# Status bar
slstatus &

# Apply pywal colors if cached
if [ -f ~/.cache/wal/colors.sh ]; then
    . ~/.cache/wal/colors.sh
fi
