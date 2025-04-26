#!/usr/bin/env bash

source $(dirname "$0")/setup/util.sh

# Link dotfiles
./link.sh

# Install Brew packages
./setup/brew ./Brewfile.base

title "Set up GitHub"

gh auth login

git remote set-url origin git@github.com:jeef3/dotfiles.git
success "Dotfiles remote updated for write access"
