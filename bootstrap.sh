#!/bin/sh

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }

# FIXME: Check CLI Tools
# Xcode CLI Tools
info "Checking XCode Command Line Tools"
X=$(xcode-select --install 2>&1)
success "Xcode Command Line Tools installed: $? $X"

# Homebrew
info "Checking Homebrew"
which -s brew
if [ ! $? -eq 0 ]; then
  info "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  success "Homebrew installed"
else
  success "Homebrew already installed"
fi

# Git
info "Checking Git"
if [ "$(which git)" = "/usr/bin/git" ]; then
  info "System Git found, installing Homebrew Git"
  brew install git
  success "Git installed"
else
  success "Homebrew Git already installed"
fi


INSTALL_DIR=~/projects

if [ ! -d  "$INSTALL_DIR" ]; then
  info "Cloning dotfiles repository"
  mkdir -p ~/projects
  git clone https://github.com/jeef3/dotfiles.git ~/projects/dotfiles

  success "Dotfiles cloned"
else
  success "Dotfiles already cloned, updating"
  git fetch -a
fi

info "Installing Git submodules"
git submodule init
git submodule update --recursive

echo "cd ~/projects/dofiles"
echo ""
echo "./setup.sh"
