#!/bin/sh

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }

# Homebrew
info "Checking Homebrew install"
brew --version
if [ $? -eq 0 ]; then
  success "Homebrew already installed"
else
  info "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  success "Homebrew installed"
fi

# Git
info "Installing Git"
brew install git
success "Git installed"

info "Cloning dotfiles repository"
mkdir -p ~/projects
git clone https://github.com/jeef3/dotfiles.git ~/projects/dotfiles
success "Dotfiles cloned"

echo "cd ~/projects/dofiles"
echo ""
echo "./setup.sh"
