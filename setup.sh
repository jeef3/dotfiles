#!/bin/sh

set -e

# Ask for the administrator password upfront
sudo -v

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }

# Link files
./link.sh

info "Installing Git submodules"
git submodule init
git submodule update --recursive

# Install Vim Plug
info "Installing/updating Vim Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

info "Installing Vim plug-ins"
vim +PlugUpdate +qall
success "Vim plug-ins installed"

info "Installing tmux plug-ins"
~/.tmux/plugins/tpm/bin/update_plugins all

info "Switching to Zsh"
if [ $(basename $SHELL) == 'zsh' ]; then
  success "Already using Zsh"
else
  success "Not using Zsh, switching"
  chsh -s /bin/zsh
fi

info "Adding italics"
tic xterm-256color-italic.terminfo
tic tmux-256color-terminfo

info "Installing brew packages"
./setup/brew

info "Setting macos preferences"
./setup/osx

info "Installing global npm modules"
./setup/dev
