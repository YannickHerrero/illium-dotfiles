#!/bin/sh
# quickmenu.sh — dmenu-based quick actions menu
# Bound to Super+Alt+Space in dwm

SCRIPTS_DIR="$HOME/.config/scripts"

# ─── Load pywal colors for dmenu styling ────────────────────────────
DMENU_ARGS=""
if [ -f "$HOME/.cache/wal/colors.sh" ]; then
    . "$HOME/.cache/wal/colors.sh"
    DMENU_ARGS="-nb $background -nf $foreground -sb $color4 -sf $foreground"
fi

# ─── Show menu ──────────────────────────────────────────────────────
choice=$(printf "Lock\nChange Wallpaper\nScreenshot\nClipboard" | dmenu -i -p "Action:" $DMENU_ARGS)

case "$choice" in
    "Lock")
        "$SCRIPTS_DIR/lock.sh"
        ;;
    "Change Wallpaper")
        wallpaper=$(nsxiv -t -o ~/wallpapers)
        [ -n "$wallpaper" ] && "$SCRIPTS_DIR/wal-set.sh" "$wallpaper"
        ;;
    "Screenshot")
        "$SCRIPTS_DIR/screenshot.sh" -s
        ;;
    "Clipboard")
        clipmenu
        ;;
esac
