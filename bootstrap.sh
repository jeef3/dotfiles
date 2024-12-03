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

success "Xcode Command Line Tools installed: $? $X"

# Homebrew
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
if [ "$(which git)" = "/usr/bin/git" ]; then
  info "System Git found, installing Homebrew Git"
  brew install git
  success "Git installed"
else
  success "Homebrew Git already installed"
fi

if [ ! -d  "$TARGET_DIR" ]; then
  # git clone https://github.com/jeef3/dotfiles.git "$TARGET_DIR" >/dev/null 2>&1
  # (git clone https://github.com/jeef3/dotfiles.git "$TARGET_DIR" >/dev/null 2>&1) & spinner
  start_spinner "Cloning dotfiles…"
  git clone https://github.com/jeef3/dotfiles.git "$TARGET_DIR" >/dev/null 2>&1
  stop_spinner

  success "Dotfiles cloned"
else
  (cd "$TARGET_DIR" && git fetch -a)

  success "Dotfiles updated"
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
