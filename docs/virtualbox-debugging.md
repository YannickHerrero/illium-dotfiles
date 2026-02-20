# VirtualBox Debugging Notes

## Problem

After running `startx` in a VirtualBox VM, dwm starts but suckless tools render
incorrectly due to VirtualBox's broken GLX support (software-emulated via llvmpipe):

- **st** (simple terminal): window is invisible or shows white/garbage pixels.
  st's alpha patch (`config.h: float alpha = 0.95`) creates a 32-bit ARGB window
  that requires a working compositor — picom's GLX backend can't handle it in VBox.

- **dmenu**: shows random white pixels instead of text glyphs, but remains
  functionally operational (typing and selecting entries still works). The GLX
  compositor garbles XftDraw text rendering.

- **Firefox and other apps**: render normally (no transparency, no compositor dependency).

## Root Cause

Two interacting issues:

1. **st has an alpha/transparency patch** (`st/config.h: float alpha = 0.95`) which
   requires a running compositor to render correctly.

2. **picom is configured with `backend = "glx"`** (`picom/picom.conf`), but VirtualBox
   has poor/broken GLX support (llvmpipe software renderer). picom either crashes
   silently or renders incorrectly, breaking st's transparency and dmenu's text.

Note: `glx` works correctly on real Asahi hardware (conformant OpenGL 4.6 drivers).
The issue is VirtualBox-specific.

## Diagnosis Steps

1. `Alt+Enter` in dwm → invisible window or white pixels = st not rendering
2. `Alt+Space` (dmenu) → random white pixels instead of text, but input works
3. `Alt+B` opens Firefox normally → confirms dwm keybindings and window management work
4. `/tmp/dwm.log` is empty → dwm itself has no errors
5. The common factor: compositor-dependent rendering is broken

## Resolution

**Option B was implemented**: auto-detect VirtualBox in `scripts/autostart.sh`.

```sh
# Compositor (VirtualBox lacks proper GLX — fall back to xrender)
if lspci | grep -qi virtualbox; then
    picom --backend xrender --daemon &
else
    picom --daemon &
fi
```

This keeps `glx` as default in `picom.conf` for real Asahi hardware (where it
performs better with proper GPU acceleration), but overrides to `xrender` in VMs.

## Other Fix Options (not used)

### Option A: Switch picom backend to xrender globally
```
# picom/picom.conf
backend = "xrender";  # instead of "glx"
```
Downside: worse performance on real hardware (Apple Silicon with proper GPU).

### Option C: Set st alpha to 1.0
Remove the transparency dependency entirely. Simple but loses the transparency feature.

## Verification

From a second TTY while dwm is running:
```sh
DISPLAY=:0 picom --backend xrender --daemon
```
Then `Alt+Enter` in dwm — if st renders properly, the GLX backend was the problem.
