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
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias c="clear"
alias vim="nvim"
alias ls="lsd"
alias cat="batcat"
EOF

# Source changes
source ~/.zshrc

echo "Setup complete. Please log out and log back in for all changes to take effect."
echo "After login:"
echo "1. Run :PlugInstall in nvim"
echo "2. Press prefix + I in tmux"
