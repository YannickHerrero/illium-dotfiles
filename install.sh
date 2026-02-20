#!/bin/sh
# install.sh — illium-dotfiles installer
# Idempotent setup script for Arch Linux ARM on Apple Silicon
# Usage: ./install.sh [--dry-run]

set -e

# ─── Colors ─────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

DRY_RUN=0
if [ "$1" = "--dry-run" ]; then
    DRY_RUN=1
fi

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ─── Helper functions ───────────────────────────────────────────────
info()  { printf "${GREEN}[OK]${NC} %s\n" "$1"; }
warn()  { printf "${YELLOW}[SKIP]${NC} %s\n" "$1"; }
error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }

run() {
    if [ "$DRY_RUN" -eq 1 ]; then
        printf "${YELLOW}[DRY-RUN]${NC} %s\n" "$*"
    else
        "$@"
    fi
}

# ─── Check architecture ────────────────────────────────────────────
check_arch() {
    ARCH=$(uname -m)
    if [ "$ARCH" != "aarch64" ]; then
        error "This script is designed for aarch64 (Arch Linux ARM)."
        error "Detected architecture: $ARCH"
        exit 1
    fi

    if [ ! -f /etc/arch-release ]; then
        error "This script is designed for Arch Linux."
        exit 1
    fi

    info "Running on Arch Linux ARM (aarch64)"
}

# ─── Configure git ──────────────────────────────────────────────────
configure_git() {
    printf "Enter your git name: "
    read -r GIT_NAME
    printf "Enter your git email: "
    read -r GIT_EMAIL

    if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
        run git config --global user.name "$GIT_NAME"
        run git config --global user.email "$GIT_EMAIL"
        info "Git configured: $GIT_NAME <$GIT_EMAIL>"
    else
        warn "Git configuration skipped (empty input)"
    fi
}

# ─── Install pacman packages ───────────────────────────────────────
install_packages() {
    if [ ! -f "$DOTFILES_DIR/packages.txt" ]; then
        error "packages.txt not found"
        exit 1
    fi

    # Filter out comments and empty lines
    PACKAGES=$(sed 's/#.*//;/^$/d' "$DOTFILES_DIR/packages.txt" | tr '\n' ' ')

    info "Installing packages from packages.txt..."
    run sudo pacman -S --needed --noconfirm $PACKAGES
    info "Packages installed"
}

# ─── Install AUR helper ────────────────────────────────────────────
install_aur_helper() {
    if command -v yay > /dev/null 2>&1; then
        warn "yay is already installed"
        return
    fi

    if command -v paru > /dev/null 2>&1; then
        warn "paru is already installed (using paru instead of yay)"
        return
    fi

    info "Installing yay from source..."
    run sudo pacman -S --needed --noconfirm git base-devel
    TMPDIR=$(mktemp -d)
    run git clone https://aur.archlinux.org/yay.git "$TMPDIR/yay"
    if [ "$DRY_RUN" -eq 0 ]; then
        (cd "$TMPDIR/yay" && makepkg -si --noconfirm)
    else
        printf "${YELLOW}[DRY-RUN]${NC} cd %s && makepkg -si --noconfirm\n" "$TMPDIR/yay"
    fi
    rm -rf "$TMPDIR"
    info "yay installed"
}

# ─── Install AUR packages ──────────────────────────────────────────
install_aur_packages() {
    AUR_HELPER=""
    if command -v yay > /dev/null 2>&1; then
        AUR_HELPER="yay"
    elif command -v paru > /dev/null 2>&1; then
        AUR_HELPER="paru"
    else
        error "No AUR helper found. Install yay or paru first."
        return
    fi

    info "Installing AUR packages with $AUR_HELPER..."

    # bluetuith — TUI bluetooth manager
    if ! pacman -Qq bluetuith > /dev/null 2>&1; then
        run $AUR_HELPER -S --needed --noconfirm bluetuith
    else
        warn "bluetuith already installed"
    fi

    # oh-my-posh — prompt theme engine
    if ! command -v oh-my-posh > /dev/null 2>&1; then
        run $AUR_HELPER -S --needed --noconfirm oh-my-posh-bin
    else
        warn "oh-my-posh already installed"
    fi

    info "AUR packages installed"
}

# ─── Install mise (polyglot tool manager) ──────────────────────────
install_mise() {
    if command -v mise > /dev/null 2>&1; then
        warn "mise is already installed"
        return
    fi

    info "Installing mise..."
    run curl https://mise.run | sh
    info "mise installed"
}

# ─── Install opencode ──────────────────────────────────────────────
install_opencode() {
    if command -v opencode > /dev/null 2>&1; then
        warn "opencode is already installed"
        return
    fi

    info "Installing opencode..."
    run curl -fsSL https://opencode.ai/install | sh
    info "opencode installed"
}

# ─── Install pywal16 ───────────────────────────────────────────────
install_pywal() {
    if command -v wal > /dev/null 2>&1; then
        warn "pywal16 (wal) is already installed"
        return
    fi

    info "Installing pywal16 via pip..."
    run pip install pywal16 --break-system-packages
    info "pywal16 installed"
}

# ─── Build suckless tools ──────────────────────────────────────────
build_suckless() {
    for tool in dwm st dmenu slstatus; do
        TOOL_DIR="$DOTFILES_DIR/suckless/$tool"
        if [ ! -d "$TOOL_DIR" ]; then
            error "Suckless tool directory not found: $TOOL_DIR"
            continue
        fi

        info "Building $tool..."
        if [ "$DRY_RUN" -eq 0 ]; then
            (cd "$TOOL_DIR" && sudo make clean install)
        else
            printf "${YELLOW}[DRY-RUN]${NC} cd %s && sudo make clean install\n" "$TOOL_DIR"
        fi
        info "$tool installed"
    done
}

# ─── Create symlinks ───────────────────────────────────────────────
create_symlinks() {
    info "Creating symlinks..."

    # ~/.zshrc
    run ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    info "Linked .zshrc"

    # ~/.zsh/ (modular config files)
    run mkdir -p "$HOME/.zsh"
    for zshconfig in "$DOTFILES_DIR/zsh/.zsh/"*.zsh; do
        CONFIG_NAME=$(basename "$zshconfig")
        run ln -sf "$zshconfig" "$HOME/.zsh/$CONFIG_NAME"
    done
    info "Linked modular zsh configs to ~/.zsh/"

    # ~/.config/ohmyposh/
    run mkdir -p "$HOME/.config/ohmyposh"
    run ln -sf "$DOTFILES_DIR/oh-my-posh/illium.omp.toml" "$HOME/.config/ohmyposh/illium.omp.toml"
    info "Linked oh-my-posh theme"

    # ~/.config/dunst/
    run mkdir -p "$HOME/.config/dunst"
    run ln -sf "$DOTFILES_DIR/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
    info "Linked dunst config"

    # ~/.config/picom/
    run mkdir -p "$HOME/.config/picom"
    run ln -sf "$DOTFILES_DIR/picom/picom.conf" "$HOME/.config/picom/picom.conf"
    info "Linked picom config"

    # ~/.xinitrc
    run ln -sf "$DOTFILES_DIR/x11/.xinitrc" "$HOME/.xinitrc"
    info "Linked .xinitrc"

    # ~/.Xresources
    run ln -sf "$DOTFILES_DIR/x11/.Xresources" "$HOME/.Xresources"
    info "Linked .Xresources"

    # ~/scripts/
    run mkdir -p "$HOME/.config/scripts"
    for script in "$DOTFILES_DIR/scripts/"*.sh; do
        SCRIPT_NAME=$(basename "$script")
        run ln -sf "$script" "$HOME/.config/scripts/$SCRIPT_NAME"
    done
    run chmod +x "$HOME/.config/scripts/"*.sh 2>/dev/null || true
    info "Linked scripts to ~/.config/scripts/"

    # ~/.config/nvim/
    run mkdir -p "$HOME/.config/nvim"
    # Symlink each file/dir individually so lazy.nvim can write lazy-lock.json
    for item in "$DOTFILES_DIR/nvim/"*; do
        ITEM_NAME=$(basename "$item")
        run ln -sf "$item" "$HOME/.config/nvim/$ITEM_NAME"
    done
    # Also link the lua directory (nested)
    run ln -sf "$DOTFILES_DIR/nvim/lua" "$HOME/.config/nvim/lua"
    info "Linked neovim config"

    # ~/wallpapers/
    run mkdir -p "$HOME/wallpapers"
    info "Created ~/wallpapers/ directory"
}

# ─── Set default shell ──────────────────────────────────────────────
set_default_shell() {
    CURRENT_SHELL=$(basename "$SHELL")
    if [ "$CURRENT_SHELL" = "zsh" ]; then
        warn "zsh is already the default shell"
        return
    fi

    ZSH_PATH=$(which zsh)
    if [ -n "$ZSH_PATH" ]; then
        info "Setting zsh as default shell..."
        run chsh -s "$ZSH_PATH"
        info "Default shell set to zsh"
    else
        error "zsh not found in PATH"
    fi
}

# ─── Enable services ───────────────────────────────────────────────
enable_services() {
    for service in NetworkManager bluetooth; do
        if systemctl is-enabled "$service" > /dev/null 2>&1; then
            warn "$service is already enabled"
        else
            info "Enabling $service..."
            run sudo systemctl enable "$service"
            info "$service enabled"
        fi
    done
}

# ─── Summary ────────────────────────────────────────────────────────
print_summary() {
    printf "\n"
    printf "${GREEN}══════════════════════════════════════════════════${NC}\n"
    printf "${GREEN}  illium-dotfiles installation complete!${NC}\n"
    printf "${GREEN}══════════════════════════════════════════════════${NC}\n"
    printf "\n"
    printf "  What was done:\n"
    printf "    - Pacman packages installed\n"
    printf "    - AUR helper (yay) installed\n"
    printf "    - AUR packages installed (bluetuith, oh-my-posh)\n"
    printf "    - pywal16 installed\n"
    printf "    - mise installed (polyglot tool manager)\n"
    printf "    - opencode installed\n"
    printf "    - Suckless tools built (dwm, st, dmenu, slstatus)\n"
    printf "    - Config files symlinked (zsh, oh-my-posh, neovim, etc.)\n"
    printf "    - zsh set as default shell\n"
    printf "    - systemd services enabled\n"
    printf "\n"
    printf "  Next steps:\n"
    printf "    1. Reboot the system\n"
    printf "    2. Log in and run: startx\n"
    printf "    3. Add a wallpaper to ~/wallpapers/ and run:\n"
    printf "       wal-set.sh ~/wallpapers/your-wallpaper.jpg\n"
    printf "\n"
    printf "  See docs/ for more information.\n"
    printf "\n"
}

# ─── Main ───────────────────────────────────────────────────────────
main() {
    printf "\n"
    printf "${GREEN}══════════════════════════════════════════════════${NC}\n"
    printf "${GREEN}  illium-dotfiles installer${NC}\n"
    printf "${GREEN}══════════════════════════════════════════════════${NC}\n"
    printf "\n"

    if [ "$DRY_RUN" -eq 1 ]; then
        printf "${YELLOW}  Running in dry-run mode — no changes will be made.${NC}\n\n"
    fi

    check_arch
    configure_git
    install_packages
    install_aur_helper
    install_aur_packages
    install_pywal
    install_mise
    install_opencode
    build_suckless
    create_symlinks
    set_default_shell
    enable_services
    print_summary
}

main
