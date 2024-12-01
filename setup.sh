#!/bin/sh

set -e

SERVER=$1

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }

# Link files
./link.sh

# Install Brew packages
info "Installing brew packages"
./setup/brew $SERVER

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

info "Update dotfiles remote for write access"
git remote set-url origin git@github.com:jeef3/dotfiles.git
