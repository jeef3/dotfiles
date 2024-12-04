#!/usr/bin/env bash

source $(dirname "$0")/setup/util.sh

SERVER=$1

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Link dotfiles
./link.sh

# Install Brew packages
./setup/brew $SERVER

# Warning: Not good practice
# info "Linking keys"
# if [ -e "$HOME/.ssh" ] && ! [ -h "$HOME/.ssh" ]; then
#   fail ".ssh exists. Please backup and/or remove this first"
# elif [ -h "$HOME/.ssh" ]; then
#   success "Re-linking .ssh"
#   rm -rf "$HOME/.ssh"
#   ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.ssh ~/
# else
#   success "Linking .ssh"
#   ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.ssh ~/
# fi

# ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Keys/.aws ~/
# sudo chmod 600 ~/.ssh ~/.aws
# sudo chmod 600 ~/.ssh/* ~/.aws/*

title "Final steps"

gh auth login

git remote set-url origin git@github.com:jeef3/dotfiles.git
success "Dotfiles remote updated for write access"
