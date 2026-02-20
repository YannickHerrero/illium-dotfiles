# illium's .zshrc — modular config with zinit

# ─── Path ───────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/scripts:$PATH"

# ─── Editor ─────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim

# ─── Zinit ──────────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# ─── Completion ─────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zinit cdreplay -q

# ─── Source modular configs ─────────────────────────────────────────
for config in ~/.zsh/*.zsh; do
    source "$config"
done

# ─── Pywal colors ──────────────────────────────────────────────────
(cat ~/.cache/wal/sequences &) 2>/dev/null
