# Package Documentation

Every package in `packages.txt` explained.

## Xorg

| Package | Purpose |
|---|---|
| `xorg-server` | X Window System display server |
| `xorg-xinit` | Provides `startx` to launch X from the console |
| `xorg-xsetroot` | Sets the root window name (used by dwm for status bar text) |
| `xorg-xrandr` | Display configuration (resolution, rotation, multi-monitor) |
| `xorg-xset` | User preference settings for X (DPMS, key repeat, etc.) |

## Build Tools

| Package | Purpose |
|---|---|
| `base-devel` | Meta-package: gcc, make, binutils, etc. Required for compiling suckless tools and AUR packages |
| `git` | Version control. Used to clone this repo and AUR packages |
| `make` | Build automation. Suckless tools use Makefiles |
| `pkg-config` | Helper for finding library compile/link flags |

## Suckless Dependencies

| Package | Purpose |
|---|---|
| `libx11` | Core X11 client library. Required by dwm, st, dmenu |
| `libxft` | Font rendering for X. Required by all suckless tools |
| `libxinerama` | Multi-monitor support for X. Required by dwm |
| `freetype2` | Font engine. Dependency of libxft |
| `fontconfig` | Font configuration and matching. Dependency of libxft |

## Terminal & Shell

| Package | Purpose |
|---|---|
| `zsh` | Z shell. Default shell in this setup |
| `stow` | GNU Stow: symlink farm manager. Optional helper for dotfile management |

## Window Management Support

| Package | Purpose |
|---|---|
| `picom` | Compositor for X11. Provides vsync, transparency, and fading |
| `dunst` | Lightweight notification daemon |
| `slock` | Simple X screen locker from suckless |
| `feh` | Lightweight image viewer. Used to set wallpapers |

## Audio

| Package | Purpose |
|---|---|
| `pipewire` | Modern audio/video server replacing PulseAudio and JACK |
| `wireplumber` | Session manager for PipeWire |
| `pipewire-pulse` | PulseAudio compatibility layer for PipeWire |
| `pulsemixer` | TUI mixer for PulseAudio/PipeWire |

## Brightness

| Package | Purpose |
|---|---|
| `brightnessctl` | Backlight brightness control. Works on Apple Silicon |

## Network & Bluetooth

| Package | Purpose |
|---|---|
| `networkmanager` | Network configuration daemon with Wi-Fi support |
| `bluez` | Bluetooth protocol stack |
| `bluez-utils` | Bluetooth utilities (`bluetoothctl`, etc.) |

## File Management & Tools

| Package | Purpose |
|---|---|
| `yazi` | TUI file manager (fast, Rust-based) |
| `btop` | TUI system monitor (CPU, RAM, disk, network) |
| `unzip` | Extract .zip archives |
| `wget` | Download files from the web |
| `curl` | Transfer data with URLs (also used by many scripts) |
| `man-db` | Manual page viewer |
| `xclip` | Command-line clipboard interface for X11 |
| `maim` | Screenshot utility for X11 |

## Fonts

| Package | Purpose |
|---|---|
| `ttf-jetbrains-mono-nerd` | JetBrains Mono with Nerd Font icons. Used by dwm, st, dmenu, dunst |
| `ttf-font-awesome` | Icon font. Used in status bar and scripts |

## CLI/TUI Tools

| Package | Purpose |
|---|---|
| `neovim` | Modern text editor. Configured with LazyVim, LSP, treesitter, and pywal16-driven theming via nvim-base16 |
| `ripgrep` | Fast recursive grep alternative. Used by fzf and telescope.nvim for searching |
| `fzf` | Command-line fuzzy finder. Integrated into zsh with Ctrl+T and Ctrl+R bindings |
| `bat` | Cat alternative with syntax highlighting and git integration. Aliased as `cat` in zshrc |
| `eza` | Modern ls replacement with icons and git status. Aliased as `ls`/`ll`/`la`/`lt` in zshrc |
| `zoxide` | Smart cd replacement. Learns your most-used directories. Aliased as `z` in zshrc |

## Browser

| Package | Purpose |
|---|---|
| `firefox` | Web browser |

## AUR Packages (installed separately)

| Package | Purpose |
|---|---|
| `bluetuith` | TUI Bluetooth manager |
| `oh-my-posh-bin` | Cross-shell prompt theme engine |

## pip Packages (installed separately)

| Package | Purpose |
|---|---|
| `pywal16` | Generate color schemes from wallpapers. Fork of pywal with 16-color support |

## Runtimes (installed via mise)

| Runtime | Purpose |
|---|---|
| `rust` | Systems programming language. Required to build rstools |
| `node` | JavaScript runtime |
| `bun` | Fast JavaScript runtime, bundler, and package manager |

## Cargo-installed tools (installed separately)

| Package | Purpose |
|---|---|
| `rstools` | Vim-centric TUI toolkit — todo list, HTTP client, KeePass vault browser, notes. Built from [YannickHerrero/rstools](https://github.com/YannickHerrero/rstools) |

## Curl-installed tools (installed separately)

| Package | Purpose |
|---|---|
| `mise` | Polyglot tool manager — handles node, rust, go, python, and CLI tools. Replaces nvm/asdf/volta |
| `opencode` | AI-powered coding assistant for the terminal |
