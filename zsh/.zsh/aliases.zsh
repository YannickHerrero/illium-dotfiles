# ─── Text Editors & Navigation ──────────────────────────────────────
alias v="nvim"
alias vim="nvim"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias mkcd='function _mkcd() { mkdir -p "$1" && cd "$1" }; _mkcd'
alias vswap="rm -rf ~/.local/state/nvim/swap/"

# ─── Modern CLI replacements ───────────────────────────────────────
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias la='eza -a --icons'
alias lt='eza --tree --icons --level=2'
alias cat='bat --style=plain'

# ─── Git ────────────────────────────────────────────────────────────
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'
alias gd='git diff'

# ─── Tools ──────────────────────────────────────────────────────────
alias yy='yazi'
alias oc='opencode'
