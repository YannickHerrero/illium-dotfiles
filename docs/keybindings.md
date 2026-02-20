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
| `Super+Alt+Space` | Quick actions menu (lock, hibernate, wallpaper, screenshot) |

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

## dmenu — Application & Web App Launcher

dmenu lists both `$PATH` executables and web apps defined in `~/.config/webapps.conf`.
Selecting a web app opens it in a dedicated Firefox window.

| Key | Action |
|---|---|
| Type text | Filter applications and web apps |
| `Return` | Launch selected |
| `Tab` | Complete selection |
| `Escape` | Close dmenu |
| `Ctrl+H` | Backspace |
| `Ctrl+W` | Delete word |
| `Ctrl+U` | Clear input |
| Arrow keys | Navigate results |
