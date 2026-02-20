# Daily Usage & Updating Your Config

How to work with this setup day to day and how to manage config changes over time.

## Starting a Session

After logging in at the TTY:

```bash
startx
```

dwm launches automatically via `.xinitrc`, which also starts picom, dunst, slstatus,
and applies any cached pywal colors.

To quit dwm and return to the TTY: `Alt+Shift+Q`.

dwm runs in a loop — if it crashes, it restarts automatically. Check `/tmp/dwm.log`
if something goes wrong.

## Typical Workflow

| Task | How |
|---|---|
| Open a terminal | `Alt+Return` |
| Launch an app | `Alt+Space`, type the name, hit Enter |
| Launch a TUI app | `Alt+Space`, type the name (e.g. "Bluetooth"), hit Enter |
| Launch a web app | `Alt+Space`, type the name (e.g. "YouTube"), hit Enter |
| Switch workspaces | `Alt+1` through `Alt+9` |
| Move a window to workspace 3 | `Alt+Shift+3` (follows you there) |
| Fullscreen a window | `Alt+F` (monocle layout, press again to go back) |
| Float a window | `Alt+T` |
| Kill a window | `Alt+Q` |
| Screenshot (selection) | Run `~/.config/scripts/screenshot.sh -s` |
| Lock screen | Run `~/.config/scripts/lock.sh` |

## Changing Wallpaper & Colors

```bash
# Set a new wallpaper and generate matching color scheme
~/.config/scripts/wal-set.sh ~/wallpapers/new-image.jpg
```

This runs pywal16 to extract colors from the image and applies them to your
terminal. New st windows will use the generated colors automatically. Existing
terminals pick up colors on next launch.

To restore colors after a reboot, the `.zshrc` and `autostart.sh` both source
the pywal cache automatically.

## Changing Volume & Brightness

```bash
# Volume (TUI mixer)
pulsemixer

# Brightness
brightnessctl set 70%
brightnessctl set +10%
brightnessctl set 10%-
```

You can bind these to keys by adding entries to `suckless/dwm/config.h` (see
below for how to modify suckless configs).

## Bluetooth

```bash
# TUI bluetooth manager
bluetuith

# Or the classic CLI
bluetoothctl
```

## Navigation

```bash
# Smart cd — learns your most-used directories
z docs          # cd to most frequent match for "docs"
z dev proj      # partial matching: cd to ~/dev/project-name

# Fuzzy finders (fzf-powered, defined in ~/.zsh/fuzzy-dir.zsh)
f               # fuzzy cd into top-level ~/dev folders
fd              # deep fuzzy cd into ~/dev subfolders
ff              # fuzzy file finder — opens in nvim
```

## File Management

```bash
# TUI file manager
yazi
# (aliased to 'yy' in .zshrc)
# 'y' function: yazi with cd-to-last-directory on exit
y
```

## System Monitoring

```bash
# TUI system monitor
btop
```

The status bar (slstatus) shows CPU, RAM, battery, volume, WiFi, and time at a
glance.

---

## Updating Suckless Configs

Suckless tools are configured by editing C header files and recompiling. This is
the core workflow you'll repeat whenever you want to change keybindings, colors,
fonts, gaps, or behavior.

### The Edit-Compile-Restart Loop

1. **Edit** the `config.h` for the tool you want to change:

```bash
cd ~/illium-dotfiles/suckless/dwm
vim config.h
```

2. **Compile and install**:

```bash
sudo make clean install
```

If there's a syntax error, `make` will tell you the line number. Fix it and
try again.

3. **Restart** the tool:
   - **dwm**: press `Alt+Shift+Q` to quit, then `startx` again. All your
     windows will close, so save your work first.
   - **st**: just open a new terminal. Existing terminals keep the old config.
   - **dmenu**: changes take effect next time you open it (`Alt+Space`).
   - **slstatus**: kill and restart it:
     ```bash
     pkill slstatus && slstatus &
     ```

### Common Config Changes

**Add a keybinding to dwm** — edit `suckless/dwm/config.h`, add an entry to
the `keys[]` array:

```c
{ MODKEY,  XK_p,  spawn,  SHCMD("pulsemixer") },
```

**Change the font size** — edit the `font` or `fonts[]` line in the relevant
`config.h`.

**Change gap size** — edit `gappx` in `suckless/dwm/config.h`.

**Change terminal opacity** — edit `alpha` in `suckless/st/config.h` (0.0 =
fully transparent, 1.0 = fully opaque).

**Change status bar modules** — edit the `args[]` array in
`suckless/slstatus/config.h`.

### Modifying dwm.c / st.c Directly

For deeper changes (new layouts, new features), you edit the `.c` files
directly. This repo already has movestack, tagandfollow, gaps, alpha, and
scrollback baked into the source. If you want to add more functionality:

1. Read the relevant suckless patch page for context on what to change
2. Apply the changes by hand to the source files in this repo
3. Recompile and test

Do **not** use `patch` — this repo carries the full modified source, so apply
changes inline.

## Updating Non-Suckless Configs

These configs are plain text files symlinked from the repo into your home
directory. Edit the file in the repo and the change takes effect immediately
(or after restarting the relevant program).

| Config | File in repo | Symlinks to | Restart needed? |
|---|---|---|---|
| zsh (main) | `zsh/.zshrc` | `~/.zshrc` | Open a new terminal |
| zsh (modules) | `zsh/.zsh/*.zsh` | `~/.zsh/*.zsh` | Open a new terminal |
| oh-my-posh | `oh-my-posh/illium.omp.toml` | `~/.config/ohmyposh/illium.omp.toml` | Open a new terminal |
| picom | `picom/picom.conf` | `~/.config/picom/picom.conf` | `pkill picom && picom --daemon &` |
| dunst | `dunst/dunstrc` | `~/.config/dunst/dunstrc` | `pkill dunst && dunst &` |
| Xresources | `x11/.Xresources` | `~/.Xresources` | `xrdb -merge ~/.Xresources` |
| xinitrc | `x11/.xinitrc` | `~/.xinitrc` | Next `startx` |
| Scripts | `scripts/*.sh` | `~/.config/scripts/*.sh` | Immediate (they're executed on each run) |
| Web apps | `webapps.conf` | `~/.config/webapps.conf` | Immediate (read on each dmenu launch) |
| TUI apps | `tuiapps.conf` | `~/.config/tuiapps.conf` | Immediate (read on each dmenu launch) |

## Versioning Your Changes

This is a git repo. Use it.

### After making a change

```bash
cd ~/illium-dotfiles
git add -A
git commit -m "feat: add brightness keybindings to dwm"
```

### Commit message conventions used in this repo

| Prefix | When to use |
|---|---|
| `feat:` | New feature or config change |
| `fix:` | Bug fix |
| `docs:` | Documentation only |
| `refactor:` | Code cleanup, no behavior change |

### Pushing to a remote

If you've set up a GitHub/GitLab remote:

```bash
git remote add origin git@github.com:illium/illium-dotfiles.git
git push -u origin main
```

Then after future changes:

```bash
git push
```

### Reviewing what changed

```bash
# See uncommitted changes
git diff

# See recent commits
git log --oneline -10

# See what a specific commit changed
git show <commit-hash>
```

## Syncing Across Machines

If you want to use this config on another Arch Linux ARM machine:

```bash
# On the new machine
git clone git@github.com:illium/illium-dotfiles.git ~/illium-dotfiles
cd ~/illium-dotfiles
./install.sh
```

The install script is idempotent — safe to run on a machine that already has
some of the setup done.

To pull updates from another machine:

```bash
cd ~/illium-dotfiles
git pull
```

Then recompile any suckless tools that changed:

```bash
cd suckless/dwm && sudo make clean install
cd ../st && sudo make clean install
# etc.
```

## System Maintenance

### Updating packages

```bash
# Official repos
sudo pacman -Syu

# AUR packages
yay -Syu

# pywal16
pip install --upgrade pywal16 --break-system-packages
```

### Cleaning up

```bash
# Remove orphaned packages
sudo pacman -Rns $(pacman -Qdtq)

# Clear package cache (keep last 3 versions)
sudo paccache -r
```

### Checking disk usage

```bash
df -h /
du -sh ~/illium-dotfiles
```

### Rebuilding font cache

After installing new fonts:

```bash
fc-cache -fv
```
