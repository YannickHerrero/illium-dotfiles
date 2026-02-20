# ─── Mise — polyglot tool manager ───────────────────────────────────
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# ─── Oh My Posh — prompt theme ─────────────────────────────────────
if command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/illium.omp.toml)"
fi

# ─── Zoxide — smart cd ─────────────────────────────────────────────
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init --cmd z zsh)"
fi
