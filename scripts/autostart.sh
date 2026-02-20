#!/bin/sh
# autostart.sh — launched by dwm on startup via .xinitrc

# Compositor (VirtualBox lacks proper GLX — fall back to xrender)
if lspci | grep -qi virtualbox; then
    picom --backend xrender --daemon &
else
    picom --daemon &
fi

# Notification daemon
dunst &

# Status bar
slstatus &

# Polkit authentication agent (needed for privilege escalation in GUI apps)
if [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# Clipboard manager daemon
if command -v clipmenud > /dev/null 2>&1; then
    clipmenud &
fi

# Screen blanking / DPMS (blank after 5min, standby 5min, suspend 10min, off 15min)
xset s 300 5
xset dpms 300 600 900

# Create XDG user directories if they don't exist
if command -v xdg-user-dirs-update > /dev/null 2>&1; then
    xdg-user-dirs-update
fi

# Apply pywal colors if cached
if [ -f ~/.cache/wal/colors.sh ]; then
    . ~/.cache/wal/colors.sh
fi
