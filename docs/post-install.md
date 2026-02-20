# Post-Install Guide

Things to do after running `install.sh`.

## 1. Set a Wallpaper

Add an image to `~/wallpapers/` and apply it:

```bash
cp /path/to/your/wallpaper.jpg ~/wallpapers/default.jpg
~/.config/scripts/wal-set.sh ~/wallpapers/default.jpg
```

This generates a color scheme with pywal16 and sets the wallpaper with feh. The color scheme is applied to your terminal on next open.

## 2. Verify Git Configuration

The installer already prompted you for git config. Verify:

```bash
git config --global user.name
git config --global user.email
```

## 3. Configure Firefox

Recommended `about:config` tweaks:

| Setting | Value | Why |
|---|---|---|
| `toolkit.legacyUserProfileCustomizations.stylesheets` | `true` | Enable userChrome.css for UI customization |
| `browser.tabs.inTitlebar` | `0` | Better integration with dwm |
| `media.ffmpeg.vaapi.enabled` | `true` | Hardware video acceleration |

Recommended extensions:
- uBlock Origin
- Dark Reader
- Vimium (keyboard navigation)

## 4. Rebuild Suckless Tools After Config Changes

If you edit any `config.h` in the `suckless/` directory:

```bash
cd ~/illium-dotfiles/suckless/dwm  # or st, dmenu, slstatus
sudo make clean install
```

Then quit and restart dwm (`Alt+Shift+Q`, then `startx`).

## 5. Battery-Specific Notes

On Apple Silicon, the battery name for slstatus is `macsmc-battery`. If your battery shows "n/a", check:

```bash
ls /sys/class/power_supply/
```

And update the battery name in `suckless/slstatus/config.h` accordingly.

## 6. Display Scaling

For the MacBook Air M2's Retina display, you may want to adjust DPI. Edit `~/.Xresources`:

```
Xft.dpi: 144
```

Then either reboot or run:

```bash
xrdb -merge ~/.Xresources
```

You'll also want to increase font sizes in your suckless configs.

## 7. Power Management

For better battery life:

```bash
# Install TLP
sudo pacman -S tlp
sudo systemctl enable --now tlp
```

## 8. Keeping Up to Date

```bash
# Update system packages
sudo pacman -Syu

# Update AUR packages
yay -Syu
```
