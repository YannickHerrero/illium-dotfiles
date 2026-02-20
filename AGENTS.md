# AGENTS.md

Guidelines for AI coding agents working in this repository.

## Project Overview

Arch Linux ARM dotfiles for Apple Silicon (Asahi Linux). A suckless-based desktop
environment (dwm, st, dmenu, slstatus) with pywal16 dynamic theming and Tokyo Night
defaults. Configuration is deployed via symlinks orchestrated by `install.sh`.

## Repository Structure

```
suckless/          C source trees: dwm, st, dmenu, slstatus (patched inline)
nvim/              Neovim config (lazy.nvim plugin specs in lua/plugins/)
zsh/               Modular zsh config (.zshrc + .zsh/*.zsh modules)
scripts/           POSIX sh utility scripts (autostart, lock, screenshot, etc.)
x11/               .xinitrc, .Xresources
oh-my-posh/        Prompt theme (illium.omp.toml)
dunst/             Notification daemon config
picom/             Compositor config
docs/              Markdown documentation
```

## Build Commands

### Suckless tools (dwm, st, dmenu, slstatus)

```sh
cd suckless/dwm && sudo make clean install
cd suckless/st && sudo make clean install
cd suckless/dmenu && sudo make clean install
cd suckless/slstatus && sudo make clean install
```

Compiler: C99 with `-pedantic -Wall -Os`. Config is in each tool's `config.h`.

### Full system install

```sh
./install.sh          # idempotent, creates symlinks + installs packages
./install.sh --dry-run  # preview without changes
```

### No test suite or CI

This is a dotfiles repo -- there are no automated tests, linters, or CI pipelines.

## Code Style

### Lua (Neovim config)

- **Formatter**: stylua (`nvim/stylua.toml`)
- **Indent**: 2 spaces (no tabs)
- **Column width**: 120
- **Globals**: `vim`, `jit` are whitelisted in `.luarc.json`
- **Plugin filenames**: kebab-case (`lsp-config.lua`, `git-integration.lua`)
- **Plugin spec pattern**: every file in `nvim/lua/plugins/` returns a lazy.nvim table:

```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin").setup({ ... })
    vim.keymap.set("n", "<leader>xx", ..., { desc = "description" })
  end,
}
```

- **Imports**: use `require()` with local variable caching:

```lua
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
```

- **Error handling**: use `pcall` for graceful fallbacks:

```lua
local ok, colors = pcall(require, "theme-colors")
if ok and colors.base16 then
  -- use generated colors
else
  -- fallback to Tokyo Night defaults
end
```

- **Keymaps**: always include a `desc` field for which-key integration.

### Shell Scripts

- **Shebang**: `#!/bin/sh` (POSIX sh, never bash)
- **Error handling in installer**: `set -e`
- **Header comment**: every script must have a purpose + usage comment:

```sh
#!/bin/sh
# scriptname.sh — short description
# Usage: scriptname.sh [args]
```

- **Idempotency pattern**: always check before acting:

```sh
if command -v tool > /dev/null 2>&1; then
    warn "tool is already installed"
    return
fi
```

- **Output functions** (in install.sh):

```sh
info()  { printf "${GREEN}[OK]${NC} %s\n" "$1"; }
warn()  { printf "${YELLOW}[SKIP]${NC} %s\n" "$1"; }
error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }
```

- **Dry-run**: side-effecting commands go through `run()` wrapper.

### Zsh Config

- **Modular**: `.zshrc` sources `~/.zsh/*.zsh` via glob loop
- **Section headers**: use visual dividers: `# --- Section Name ---...`
- **Tool guards**: conditionally activate external tools:

```zsh
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init --cmd z zsh)"
fi
```

### C (Suckless)

- **Standard**: C99, tab-indented, minimal headers
- **Configuration**: static arrays/constants in `config.h` (not `config.def.h`)
- **Patches**: applied inline in the source -- never use `patch` command
- **Colors**: Tokyo Night palette hardcoded as defaults:

```c
static const char col_bg[]     = "#1a1b26";
static const char col_fg[]     = "#c0caf5";
static const char col_accent[] = "#7aa2f7";
```

## Naming Conventions

| Context | Convention | Example |
|---------|-----------|---------|
| Lua plugin files | kebab-case | `git-integration.lua` |
| Lua modules | kebab-case | `vim-options.lua`, `theme-colors.lua` |
| Shell scripts | kebab-case or descriptive | `wal-set.sh`, `autostart.sh` |
| Zsh modules | descriptive.zsh | `aliases.zsh`, `functions.zsh` |
| C config headers | `config.h` (suckless standard) | `suckless/dwm/config.h` |

## Theming

- **Font**: JetBrainsMono Nerd Font everywhere (dwm: 11pt, st: 16px, dmenu: 11pt, dunst: 10pt)
- **Color pipeline**: `scripts/wal-set.sh <wallpaper>` runs pywal16, generates colors for all tools
- **Nvim colors**: pywal generates `~/.config/nvim/lua/theme-colors.lua` (base16 mapping)
- **Fallback**: Tokyo Night is hardcoded in `.Xresources`, suckless `config.h` files, and `dunstrc`

## Commit Messages

| Prefix | When to use |
|--------|-------------|
| `feat:` | New feature or config change |
| `fix:` | Bug fix |
| `docs:` | Documentation only |
| `refactor:` | Code cleanup, no behavior change |

## Important Notes

- The installer (`install.sh`) must remain idempotent and POSIX-compatible
- Suckless tools carry the full patched source -- do not generate `.diff` or use `patch`
- Symlink targets are defined in `install.sh`'s `create_symlinks()` function
- `pywal/` and `wallpapers/` are placeholder directories
- `stow` is in `packages.txt` but is not used by the installer
