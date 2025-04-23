#!/usr/bin/env bash

source $(dirname "$0")/setup/util.sh
source $(dirname "$0")/setup/spinner.sh

DEFAULT_DIR="$HOME/projects/dotfiles"

TARGET_DIR="${1:-$DEFAULT_DIR}"

echo "This will create $(tput bold)$TARGET_DIR$(tput sgr0) and clone your dotfiles there."
read -n 1 -p "Are you sure you want to continue? (y/n): " answer
echo ""

if [ ! "$answer" == "y" ]; then
  echo "Stopping bootstrap"
  exit
fi

title "Bootstrapping Dotfiles"

# FIXME: Check CLI Tools
start_spinner "Checking XCode Command Line Tools"
X=$(xcode-select --install >/dev/null 2>&1)
stop_spinner

success "$(tput bold)Xcode Command Line Tools$(tput sgr0) installed: $? $X"

# Homebrew
which -s brew
if [ ! $? -eq 0 ]; then
  info "Installing $(tput bold)Homebrew$(tput sgr0)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  success "$(tput bold)Homebrew $(tput sgr0; tput setaf 7)installed$(tput sgr0)"
else
  skip "$(tput bold)Homebrew $(tput sgr0; tput setaf 7)already installed, skipping…$(tput sgr0)"
fi

# Git
if [ "$(which git)" = "/usr/bin/git" ]; then
  start_spinner "System Git found, installing $(tput bold)Homebrew Git$(tput sgr0)…"
  brew install git >/dev/null 2>&1
  stop_spinner

  success "$(tput bold)Homebrew Git $(tput sgr0; tput setaf 7)installed$(tput sgr0)"
else
  skip "$(tput bold)Homebrew Git $(tput sgr0; tput setaf 7)already installed, skipping…$(tput sgr0)"
fi

# App Store
which -s mas
if [ ! $? -eq 0 ]; then
  start_spinner "$(tput sgr0; tput bold)Mac App Store CLI $(tput sgr0; tput setaf 7)Installing…$(tput sgr0)"
  brew install mas >/dev/null 2>&1
  stop_spinner

  success "$(tput bold)Mac App Store CLI $(tput sgr0; tput setaf 7)installed"
else
  skip "$(tput bold)Mac App Store CLI $(tput sgr0; tput setaf 7)already installed"
fi

if [ ! -d  "$TARGET_DIR" ]; then
  start_spinner "Cloning $(tput bold)Dotfiles$(tput sgr0)…"
  git clone https://github.com/jeef3/dotfiles.git "$TARGET_DIR" >/dev/null 2>&1
  stop_spinner

  success "Dotfiles$(tput sgr0) cloned"
else
  start_spinner "$(tput bold)Updating Dotfiles$(tput sgr0)…"
  (cd "$TARGET_DIR" && git fetch -a)
  stop_spinner

  success "$(tput bold)Dotfiles$(tput sgr0) updated"
fi

cd $TARGET_DIR
start_spinner "Installing submodules…"
git submodule init >/dev/null 2>&1
git submodule update --recursive >/dev/null 2>&1
stop_spinner
success "Git submodules updated"

echo "cd $TARGET_DIR"
echo ""
echo "./setup.sh"
