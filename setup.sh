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

# Link files
./link.sh

# Install Vim Plug
info "Installing/updating Vim Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugUpdate +qall
success "Vim plug-ins installed"

info "Switching to Zsh"
if [ $(basename $SHELL) == 'zsh' ]; then
  success "Already using Zsh"
else
  success "Not using Zsh, switching"
  chsh -s /bin/zsh
fi

info "Adding italics"
tic xterm-256color-italic.terminfo
