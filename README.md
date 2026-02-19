# illium-dotfiles

Minimal Arch Linux ARM rice for Apple Silicon — dwm, st, dmenu.

> Screenshot coming soon.

## Quick Install

```bash
git clone https://github.com/illium/illium-dotfiles.git
cd illium-dotfiles
chmod +x install.sh
./install.sh
```

## What's Included

- **dwm** — tiled window manager with movestack patch, gaps, Tokyo Night color scheme
- **st** — simple terminal with alpha transparency and scrollback
- **dmenu** — application launcher
- **slstatus** — status bar (CPU, RAM, battery, volume, WiFi, date)
- **picom** — compositor for vsync and transparency
- **dunst** — notification daemon
- **zsh** + **oh-my-posh** — shell with a minimal prompt theme
- **pywal16** — wallpaper-based color scheme generation
- **Utility scripts** — screenshots, screen lock, wallpaper setter, autostart

## Documentation

- [Installation Guide](docs/installation-guide.md) — full setup from scratch
- [Keybindings](docs/keybindings.md) — dwm, st, and dmenu keybinding reference
- [Packages](docs/packages.md) — what each package does and why it's included
- [Troubleshooting](docs/troubleshooting.md) — common issues and fixes
- [Post-Install](docs/post-install.md) — things to do after installing

## Target Hardware

MacBook Air M2 running Arch Linux ARM via [Asahi Linux](https://asahilinux.org/),
alongside macOS and Omarchy.

## Credits

- [suckless.org](https://suckless.org/) — dwm, st, dmenu, slstatus, slock
- [Asahi Linux](https://asahilinux.org/) — Linux on Apple Silicon
- [oh-my-posh](https://ohmyposh.dev/) — prompt theme engine
- [pywal16](https://github.com/eylles/pywal16) — color scheme generator

## License

[MIT](LICENSE)
