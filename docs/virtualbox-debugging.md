# VirtualBox Debugging Notes

## Problem

After running `startx` in a VirtualBox VM, dwm starts but `st` (simple terminal)
renders as white/garbage pixels. Firefox and other non-transparent windows work fine.

## Root Cause

Two interacting issues:

1. **st has an alpha/transparency patch** (`st/config.h: float alpha = 0.95`) which
   requires a running compositor to render correctly.

2. **picom is configured with `backend = "glx"`** (`picom/picom.conf`), but VirtualBox
   has poor/broken GLX support. picom crashes silently on startup, leaving st with no
   compositor to handle its transparency — resulting in garbage rendering.

## Diagnosis Steps

1. `Alt+Enter` in dwm → white pixels instead of a terminal = st is launching but not rendering
2. `Alt+B` opens Firefox normally → confirms dwm keybindings and window management work
3. `/tmp/dwm.log` is empty → dwm itself has no errors
4. The common factor: st uses alpha transparency, Firefox does not

## Fix Options

### Option A: Switch picom backend to xrender (VirtualBox-compatible)
```
# picom/picom.conf
backend = "xrender";  # instead of "glx"
```
Downside: worse performance on real hardware (Apple Silicon with proper GPU).

### Option B: Auto-detect backend in autostart
```sh
# In autostart.sh, detect VirtualBox and pick the right backend:
if lspci | grep -qi virtualbox; then
    picom --backend xrender --daemon &
else
    picom --daemon &
fi
```
This keeps `glx` as default in picom.conf for real hardware, but overrides for VMs.

### Option C: Set st alpha to 1.0
Remove the transparency dependency entirely. Simple but loses the transparency feature.

## Verification

From a second TTY while dwm is running:
```sh
DISPLAY=:0 picom --backend xrender --daemon
```
Then `Alt+Enter` in dwm — if st renders properly, the GLX backend was the problem.
