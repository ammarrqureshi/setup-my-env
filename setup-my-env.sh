#!/bin/bash

# Function to check and install a package using the appropriate package manager
install_package() {
  if command -v apt-get >/dev/null; then
    sudo apt-get update
    sudo apt-get install -y "$1"
  elif command -v yum >/dev/null; then
    sudo yum install -y "$1"
  elif command -v brew >/dev/null; then
    brew install "$1"
  elif command -v pacman >/dev/null; then
    sudo pacman -Syu --noconfirm "$1"
  elif command -v dnf >/dev/null; then
    sudo dnf install -y "$1"
  elif command -v zypper >/dev/null; then
    sudo zypper install -y "$1"
  else
    echo "Error: Package manager not found. Please install $1 manually."
    exit 1
  fi
}

# Install Neovim
install_package neovim

# Clone your Neovim configuration from GitHub
# Replace <your-nvim-repo-url> with your actual GitHub repository URL
git clone https://github.com/ammarrqureshi/nvim-config.git ~/.config/nvim

# Install tmux
install_package tmux

# Clone the tmux.conf file from GitHub and copy it to /etc
# Replace <your-tmux-repo-url> with your actual GitHub repository URL
git clone https://github.com/ammarrqureshi/tmux-conf.git ~/tmux-config
if [ "$(uname)" == "Darwin" ]; then
  sudo cp ~/tmux-config/tmux.conf /usr/local/etc/tmux.conf
else
  sudo cp ~/tmux-config/tmux.conf /etc/tmux.conf
fi

# Clean up
rm -rf ~/tmux-config

echo "Installation and setup complete!"
