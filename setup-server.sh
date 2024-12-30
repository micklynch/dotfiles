#!/bin/bash

# Exit on any error
set -e

echo "Starting Ubuntu server setup..."

# 1. Hide welcome message
sudo touch ~/.hushlogin

# 2. Install and switch to zsh
sudo apt update
sudo apt install zsh -y
chsh -s $(which zsh)

# 3. Install git and configure
sudo apt install git -y
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra

# 4. Install neovim and vim-plug
sudo apt update
sudo apt install neovim -y
sudo apt install curl -y

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Create nvim config directory and download init.vim
mkdir -p ~/.config/nvim
curl -o ~/.config/nvim/init.vim https://raw.githubusercontent.com/micklynch/dotfiles/refs/heads/master/nvim/init.vim

# 5. Install tmux and configure
sudo apt install tmux -y
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Download tmux config
mkdir -p ~/.config/tmux
curl -o ~/.config/tmux/tmux.conf https://raw.githubusercontent.com/micklynch/dotfiles/refs/heads/master/.config/tmux/tmux.conf
# Source tmux config
tmux source ~/.config/tmux/tmux.conf

# 6. Install LSD
sudo apt install lsd -y

# 7. Install batcat
sudo apt install bat -y

# 8. Install oh-my-zsh and p10k
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Add aliases and p10k theme to .zshrc
cat << 'EOF' >> ~/.zshrc
# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Aliases
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias cat='batcat'
EOF

# Source changes
source ~/.zshrc

echo "Setup complete. Please log out and log back in for all changes to take effect."
echo "After login:"
echo "1. Run :PlugInstall in nvim"
echo "2. Press prefix + I in tmux"
