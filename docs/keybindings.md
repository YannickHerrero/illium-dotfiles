# Keybindings Reference

All custom keybindings for dwm, st, and dmenu.

## dwm — Window Manager

Mod key: **Alt** (Mod1)

### Launching

| Keybinding | Action |
|---|---|
| `Alt+Return` | Open terminal (st) |
| `Alt+Space` | Open dmenu (application launcher) |
| `Alt+B` | Open Firefox |
| `Super+Alt+Space` | Quick actions menu (lock, wallpaper, screenshot, clipboard) |

### Window Focus

| Keybinding | Action |
|---|---|
| `Alt+H` | Focus previous window |
| `Alt+J` | Focus next window |
| `Alt+K` | Focus previous window |
| `Alt+L` | Focus next window |

### Window Movement

| Keybinding | Action |
|---|---|
| `Alt+Shift+H` | Move window up in stack |
| `Alt+Shift+J` | Move window down in stack |
| `Alt+Shift+K` | Move window up in stack |
| `Alt+Shift+L` | Move window down in stack |

### Layout

| Keybinding | Action |
|---|---|
| `Alt+Ctrl+H` | Shrink main area |
| `Alt+Ctrl+L` | Grow main area |
| `Alt+F` | Toggle monocle (fullscreen) layout |
| `Alt+T` | Toggle floating for focused window |

### Workspaces (Tags)

| Keybinding | Action |
|---|---|
| `Alt+1..9` | Switch to workspace 1-9 |
| `Alt+Shift+1..9` | Move window to workspace 1-9 and follow |

### Media Keys

| Keybinding | Action |
|---|---|
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay` | Play/pause media |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `XF86MonBrightnessUp` | Brightness up 5% |
| `XF86MonBrightnessDown` | Brightness down 5% |

All media/brightness actions show an OSD notification via dunst.

### Other

| Keybinding | Action |
|---|---|
| `Alt+Q` | Kill focused window |
| `Alt+Shift+Q` | Quit dwm |

### Mouse

| Action | Binding |
|---|---|
| Move window | `Alt+Left Click` drag |
| Resize window | `Alt+Right Click` drag |
| Toggle floating | `Alt+Middle Click` |

## st — Terminal

### Shortcuts

| Keybinding | Action |
|---|---|
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `Shift+PageUp` | Scroll up (full page) |
| `Shift+PageDown` | Scroll down (full page) |
| `Shift+Mouse Wheel` | Scroll up/down (3 lines) |
| `Ctrl+Shift+PageUp` | Zoom in (increase font size) |
| `Ctrl+Shift+PageDown` | Zoom out (decrease font size) |
| `Ctrl+Shift+Home` | Reset zoom |
| `Shift+Insert` | Paste from selection |

## dmenu — Application, TUI & Web App Launcher

dmenu lists `$PATH` executables, TUI apps from `~/.config/tuiapps.conf`, and web apps
from `~/.config/webapps.conf`. TUI apps open in an st terminal; web apps open in Firefox.

| Key | Action |
|---|---|
| Type text | Filter applications, TUI apps, and web apps |
| `Return` | Launch selected |
| `Tab` | Complete selection |
| `Escape` | Close dmenu |
| `Ctrl+H` | Backspace |
| `Ctrl+W` | Delete word |
| `Ctrl+U` | Clear input |
| Arrow keys | Navigate results |
