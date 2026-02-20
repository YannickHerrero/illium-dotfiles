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
| **dmenu 5.3** | Application launcher — also surfaces TUI apps and web apps from config files |
| **slstatus 1.0** | Status bar — CPU, RAM, battery, volume, WiFi, date/time |
| **picom** | Compositor — vsync, transparency, fading |
| **dunst** | Notification daemon |
| **neovim** | Text editor — LazyVim, LSP, treesitter, pywal16-themed via nvim-base16 |
| **zsh** + **zinit** + **oh-my-posh** | Modular shell config with plugin manager and minimal prompt |
| **mise** | Polyglot tool manager (node, rust, go, CLI tools) |
| **zoxide** | Smart cd replacement (learns your most-used directories) |
| **pywal16** | Wallpaper-based color scheme generation |
| **ripgrep, fzf, bat, eza** | Modern CLI replacements for grep, find, cat, ls |
| **rstools** | Vim-centric TUI toolkit — todo, HTTP client, KeePass, notes |
| **opencode** | AI-powered coding assistant |
| **Scripts** | Autostart, screenshots, wallpaper setter, screen lock |

Color scheme: **Tokyo Night** (overridden at runtime by pywal).

## Repository Structure

```
illium-dotfiles/
├── install.sh          # Idempotent installer
├── packages.txt        # Pacman package list
├── suckless/           # Full source trees (dwm, st, dmenu, slstatus)
├── nvim/               # Neovim config (LazyVim + pywal16 theming)
├── zsh/                # Modular zsh config (.zshrc + .zsh/*.zsh)
├── oh-my-posh/         # Prompt theme (illium.omp.toml, pywal-aware)
├── dunst/              # Notification config
├── picom/              # Compositor config
├── x11/                # .xinitrc, .Xresources
├── webapps.conf        # Web app definitions (Name=URL, shown in dmenu)
├── tuiapps.conf        # TUI app definitions (Name=command, shown in dmenu)
├── scripts/            # Utility scripts
├── wallpapers/         # Your wallpapers go here
└── docs/               # Documentation
```

## Documentation

- [Installation Guide](docs/installation-guide.md) — full setup from Asahi install to first boot
- [Keybindings](docs/keybindings.md) — dwm, st, and dmenu keybinding reference
- [Packages](docs/packages.md) — what each package does and why
- [Daily Usage](docs/daily-usage.md) — day-to-day workflow and updating your config
- [Troubleshooting](docs/troubleshooting.md) — common issues and fixes
- [Post-Install](docs/post-install.md) — wallpapers, Firefox config, display scaling

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
