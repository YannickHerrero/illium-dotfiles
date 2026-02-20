# illium's .zshrc

# ─── Path ───────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/scripts:$PATH"

# ─── Editor ─────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim

# ─── History ────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# ─── Options ────────────────────────────────────────────────────────
setopt AUTO_CD
setopt CORRECT
setopt NO_BEEP
setopt INTERACTIVE_COMMENTS

# ─── Completion ─────────────────────────────────────────────────────
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ─── Aliases ────────────────────────────────────────────────────────
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias la='eza -a --icons'
alias lt='eza --tree --icons --level=2'
alias cat='bat --style=plain'
alias ..='cd ..'
alias ...='cd ../..'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'
alias gd='git diff'

# Tools
alias yy='yazi'
alias vim='nvim'
alias v='nvim'

# ─── Oh My Posh ────────────────────────────────────────────────────
if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/illium.omp.json)"
fi

# ─── fzf integration ───────────────────────────────────────────────
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh 2>/dev/null)" || source /usr/share/fzf/key-bindings.zsh 2>/dev/null
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ─── Pywal colors ──────────────────────────────────────────────────
(cat ~/.cache/wal/sequences &) 2>/dev/null
