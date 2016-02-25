#!/bin/sh
source lib/messages

info "Installing Git submodules"
git submodule init
git submodule update --recursive

# Homebrew
info "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Vim plugins
vim +PluginInstall +qall

# Link files
./link.sh

info "Switching to Zsh"
if [ $(basename $SHELL) == 'zsh' ]; then
  success "Already using Zsh"
else
  success "Not using Zsh, switching"
  chsh -s /bin/zsh
fi
