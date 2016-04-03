#!/bin/sh
source lib/messages

info "Installing Git submodules"
git submodule init
git submodule update --recursive

# Homebrew
info "Checking Homebrew install"
brew --version
if [ $? -eq 0 ]; then
  success "Homebrew already installed"
else
  info "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

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

info "Adding italics"
tic xterm-256color-italic.terminfo
