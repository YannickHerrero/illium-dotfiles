# Installation Guide

Step-by-step guide to setting up illium-dotfiles on a MacBook Air M2 with Arch Linux ARM.

## Prerequisites

- MacBook Air M2 (or other Apple Silicon Mac)
- macOS already installed (Asahi requires it)
- Internet connection
- ~250GB free disk space (or however much you want to allocate)

## 1. Install Asahi Linux

Follow the [Asahi Linux installer](https://asahilinux.org/) to set up Arch Linux ARM alongside your existing macOS installation.

```bash
curl https://alx.sh | sh
```

Choose the **Arch Linux ARM** option (minimal, no desktop environment). The installer will:
- Resize your macOS partition
- Create a new APFS container for Linux
- Install the base Arch Linux ARM system

After installation, reboot and select the Arch Linux entry from the boot menu.

## 2. Initial Arch Setup

After booting into Arch Linux ARM for the first time:

```bash
# Log in as root (or the user created during install)

# Connect to WiFi
nmcli device wifi connect "YourSSID" password "YourPassword"

# Update the system
pacman -Syu

# Create your user (if not done during install)
useradd -m -G wheel -s /bin/bash illium
passwd illium

# Enable sudo for wheel group
EDITOR=nano visudo
# Uncomment: %wheel ALL=(ALL:ALL) ALL

# Switch to your user
su - illium
```

## 3. Clone and Install Dotfiles

```bash
# Install git if not present
sudo pacman -S git

# Clone the repo
git clone https://github.com/illium/illium-dotfiles.git ~/illium-dotfiles
cd ~/illium-dotfiles

# Make the installer executable
chmod +x install.sh

# Preview what will be done
./install.sh --dry-run

# Run the full install
./install.sh
```

The install script will:
1. Check that you're on aarch64
2. Ask for your git name and email
3. Install all packages from `packages.txt`
4. Install yay (AUR helper)
5. Install AUR packages (bluetuith, oh-my-posh)
6. Install pywal16 via pip
7. Build and install suckless tools (dwm, st, dmenu, slstatus)
8. Create all config symlinks
9. Set zsh as your default shell
10. Enable NetworkManager and bluetooth

## 4. First Boot into dwm

After the install completes:

```bash
# Reboot
sudo reboot

# After logging in, start the graphical session
startx
```

You should now see dwm with the Tokyo Night color scheme. Press `Alt+Return` to open a terminal.

## 5. Partition Notes

If you're running macOS + Omarchy + Arch Linux ARM:

- macOS: primary APFS container
- Omarchy: separate APFS volume or container
- Arch Linux ARM: dedicated partition via Asahi installer

The Asahi installer handles the partitioning. You don't need to manually partition anything. The boot menu (hold power button at startup) will show all installed OSes.

## Next Steps

See [post-install.md](post-install.md) for things to do after installing.
