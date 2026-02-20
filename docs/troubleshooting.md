# Troubleshooting

Common issues and fixes for Arch Linux ARM on Apple Silicon.

## Audio Not Working

Apple Silicon speaker support requires firmware that may not be available yet in all Asahi builds.

**Headphone jack / USB audio should work.** For speakers:

```bash
# Check if speaker firmware is loaded
aplay -l

# Install/update speaker firmware if available
sudo pacman -S asahi-audio

# Ensure PipeWire is running
systemctl --user status pipewire wireplumber
systemctl --user enable --now pipewire wireplumber
```

If speakers still don't work, check [Asahi Linux wiki](https://github.com/AsahiLinux/docs/wiki/Feature-Support) for your model's speaker support status.

## Bluetooth Pairing Issues

```bash
# Ensure bluetooth service is running
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

# Use bluetoothctl to pair
bluetoothctl
> power on
> agent on
> scan on
# Wait for your device to appear
> pair XX:XX:XX:XX:XX:XX
> connect XX:XX:XX:XX:XX:XX
> trust XX:XX:XX:XX:XX:XX
```

Or use `bluetuith` for a TUI interface.

## Screen Tearing

If you see screen tearing, try switching the picom backend:

Edit `~/.config/picom/picom.conf`:

```
# Change from:
backend = "glx";

# To:
backend = "xrender";
```

Then restart picom:

```bash
pkill picom && picom --daemon &
```

## WiFi Drops After Suspend

This is a known issue on some Apple Silicon models:

```bash
# Restart NetworkManager
sudo systemctl restart NetworkManager

# Or reconnect manually
nmcli device wifi connect "YourSSID"
```

If persistent, try disabling power saving for the WiFi adapter:

```bash
sudo iw dev wlan0 set power_save off
```

## Fonts Not Rendering

If fonts appear as boxes or squares:

```bash
# Rebuild font cache
fc-cache -fv

# Verify JetBrains Mono is installed
fc-list | grep -i "JetBrains"
```

If the font isn't found, reinstall:

```bash
sudo pacman -S ttf-jetbrains-mono-nerd
```

## st Transparency Not Working

Transparency requires picom (the compositor) to be running:

```bash
# Check if picom is running
pgrep picom

# Start it if not
picom --daemon &
```

If picom crashes or doesn't start, try the xrender backend (see Screen Tearing above).

## dwm Crashes or Won't Start

Check the dwm log:

```bash
cat /tmp/dwm.log
```

Common causes:
- Missing fonts: install `ttf-jetbrains-mono-nerd`
- Missing dependencies: run `sudo pacman -S libx11 libxft libxinerama`
- Config syntax error: recompile from `suckless/dwm/` directory

```bash
cd ~/illium-dotfiles/suckless/dwm
sudo make clean install
```

## Brightness Control Not Working

```bash
# Check available brightness devices
ls /sys/class/backlight/

# Try brightnessctl
brightnessctl list
brightnessctl set 50%
```

If no backlight device is found, you may need the `asahi-linux` kernel with backlight support.

## startx Fails

```bash
# Check Xorg log
cat /var/log/Xorg.0.log | grep -i error

# Ensure .xinitrc is executable is NOT needed (it's sourced, not executed)
# But ensure it exists:
ls -la ~/.xinitrc
```

Common fixes:
- Ensure `xorg-server` and `xorg-xinit` are installed
- Check that the xinitrc symlink points to the correct file
