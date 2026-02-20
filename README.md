# illium-dotfiles

Minimal Arch Linux ARM rice for Apple Silicon — dwm, st, dmenu.

> Screenshot coming soon.

## Quick Install

```bash
git clone https://github.com/illium/illium-dotfiles.git ~/illium-dotfiles
cd ~/illium-dotfiles
chmod +x install.sh
./install.sh
```

Preview without making changes:

```bash
./install.sh --dry-run
```

## What's Included

| Component | Description |
|---|---|
| **dwm 6.5** | Tiled window manager — movestack, useless gaps, tag-and-follow |
| **st 0.9.2** | Terminal — alpha transparency, scrollback buffer (2048 lines) |
| **dmenu 5.3** | Application launcher |
| **slstatus 1.0** | Status bar — CPU, RAM, battery, volume, WiFi, date/time |
| **picom** | Compositor — vsync, transparency, fading |
| **dunst** | Notification daemon |
| **zsh** + **oh-my-posh** | Shell with minimal prompt (path, git status, exec time) |
| **pywal16** | Wallpaper-based color scheme generation |
| **Scripts** | Autostart, screenshots, wallpaper setter, screen lock |

Color scheme: **Tokyo Night** (overridden at runtime by pywal).

## Repository Structure

```
illium-dotfiles/
├── install.sh          # Idempotent installer
├── packages.txt        # Pacman package list
├── suckless/           # Full source trees (dwm, st, dmenu, slstatus)
├── zsh/                # .zshrc
├── oh-my-posh/         # Prompt theme
├── dunst/              # Notification config
├── picom/              # Compositor config
├── x11/                # .xinitrc, .Xresources
├── scripts/            # Utility scripts
├── wallpapers/         # Your wallpapers go here
└── docs/               # Documentation
```

## Documentation

- [Installation Guide](docs/installation-guide.md) — full setup from Asahi install to first boot
- [Keybindings](docs/keybindings.md) — dwm, st, and dmenu keybinding reference
- [Packages](docs/packages.md) — what each package does and why
- [Troubleshooting](docs/troubleshooting.md) — common issues and fixes
- [Post-Install](docs/post-install.md) — wallpapers, Firefox config, optional tools

## Key Bindings (Quick Reference)

| Keybinding | Action |
|---|---|
| `Alt+Return` | Open terminal |
| `Alt+Space` | Open dmenu |
| `Alt+B` | Open Firefox |
| `Alt+Q` | Kill window |
| `Alt+H/J/K/L` | Focus navigation |
| `Alt+Shift+H/J/K/L` | Move windows in stack |
| `Alt+Ctrl+H/L` | Resize main area |
| `Alt+F` | Toggle monocle layout |
| `Alt+1..9` | Switch workspace |
| `Alt+Shift+1..9` | Move window to workspace and follow |

See [docs/keybindings.md](docs/keybindings.md) for the full reference.

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
