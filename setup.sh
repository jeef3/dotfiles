#!/bin/sh

set -e

# Ask for the administrator password upfront
sudo -v

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }

info "Installing Git submodules"
git submodule init
git submodule update --recursive

# Link files
./link.sh

# Install Vim Plug
info "Installing/updating Vim Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Brew packages
info "Installing brew packages"
./setup/brew

# Switch to Brew zsh
info "Switching to Zsh"
if [ $(basename $SHELL) == 'zsh' ]; then
  success "Already using Zsh"
else
  success "Not using Zsh, switching"
  echo $(which zsh) >> /etc/shells
  chsh -s $(which zsh)
fi

info "Adding italics"
tic xterm-256color-italic.terminfo

info "Setting macos preferences"
./setup/macos

info "Installing global npm modules"
./setup/dev

info "Installing Haskell (can't install with Homebrew)"
curl -sSL https://get.haskellstack.org/ | sh

info "Installing iTerm shell integration"
curl -L https://iterm2.com/misc/install_shell_integration.sh | bash

# Warning: Not good practice
info "Linking keys"
# ln -s ~/Library/CloudStorage/iCloudDrive/Keys/.aws ~/
# ln -s ~/Library/CloudStorage/iCloudDrive/Keys/.ssh ~/
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.ssh ~/
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.aws ~/
chmod 700 ~/.ssh ~/.aws
chmod ^00 ~/.ssh/* ~/.aws/*

info "Installing Vim plug-ins"
vim +PlugUpdate +qall
success "Vim plug-ins installed"

info "Update dotfiles remote for write access"
git remote set-url origin git@github.com:jeef3/dotfiles.git
