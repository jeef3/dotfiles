#!/bin/sh

set -e

SERVER=$1

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }

info "Installing Git submodules"
git submodule init
git submodule update --recursive

# Needs to exist
mkdir -p ~/.config

# Link files
./link.sh

# Install Vim Plug
# info "Installing/updating Vim Plug"
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Install Brew packages
info "Installing brew packages"
./setup/brew $SERVER

# Switch to Brew zsh
info "Switching to Zsh"
if [ $(basename $SHELL) == 'zsh' ]; then
  success "Already using Zsh"
else
  success "Not using Zsh, switching"
  chsh -s $(which zsh)
fi

info "Adding italics"
# tic tmux-256color.terminfo
# tic xterm-256color-italic.terminfo

info "Setting macos preferences"
# ./setup/macos

info "Installing global npm modules"
./setup/dev

info "Installing rvm (can't install with Homebrew)"
# curl -sSL https://get.rvm.io | bash -s stable

# Warning: Not good practice
info "Linking keys"
if [ -e "$HOME/.ssh" ] && ! [ -h "$HOME/.ssh" ]; then
  fail ".ssh exists. Please backup and/or remove this first"
elif [ -h "$HOME/.ssh" ]; then
  success "Re-linking .ssh"
  rm -rf "$HOME/.ssh"
  ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.ssh ~/
else
  success "Linking .ssh"
  ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.ssh ~/
fi

# ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.aws ~/
sudo chmod 600 ~/.ssh ~/.aws
sudo chmod 600 ~/.ssh/* ~/.aws/*

info "Installing Vim plug-ins"
nvim +PlugUpdate +qall
success "Vim plug-ins installed"

info "Update dotfiles remote for write access"
git remote set-url origin git@github.com:jeef3/dotfiles.git
