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

title "Set up GitHub"

gh auth login

git remote set-url origin git@github.com:jeef3/dotfiles.git
success "Dotfiles remote updated for write access"
