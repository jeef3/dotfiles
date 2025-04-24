#!/usr/bin/env bash

source $(dirname "$0")/setup/util.sh
source $(dirname "$0")/setup/spinner.sh

DEFAULT_DIR="$HOME/projects/dotfiles"

TARGET_DIR="${1:-$DEFAULT_DIR}"

title "Dotfiles"

quote "$(tput sitm; tput setaf 7)This will create and clone your Dotfiles to:"
quote "📁 $(tput bold)$TARGET_DIR$(tput sgr0)"
quote
read -n 1 -p "$(quote 'Would you like to continue? (y/n): ')" answer
echo ""

if [ ! "$answer" == "y" ]; then
  printf "\n🛑 Stopping Dotfiles bootstrap\n\n"
  exit
fi

title "Bootstrapping Dotfiles"

# FIXME: Check CLI Tools
xcode-select -p 1>/dev/null;
if [ ! $? -eq 0 ]; then
  success "Xcode Command Line Tools" "installed: $? $X"
else
  skip "XCode CLI Tools" "already installed, skipping…"
fi


# Homebrew
which -s brew
if [ ! $? -eq 0 ]; then
  info "Homebrew" "not installed, sudo needed for install"
  sudo -v

  start_spinner "Homebrew" "installing…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null 2>&1
  eval "$(/opt/homebrew/bin/brew shellenv)"
  stop_spinner

  success "Homebrew" "installed"
else
  skip "Homebrew" "already installed, skipping…"
fi

# Git
if [ "$(which git)" = "/usr/bin/git" ]; then
  start_spinner "Homebrew Git" "system Git found, installing Homebrew Git…"
  brew install git >/dev/null 2>&1
  stop_spinner

  success "Homebrew Git" "installed"
else
  skip "Homebrew Git" "already installed, skipping…"
fi

# App Store
which -s mas
if [ ! $? -eq 0 ]; then
  start_spinner "$(tput sgr0; tput bold)Mac App Store CLI $(tput sgr0; tput setaf 7)Installing…$(tput sgr0)"
  brew install mas >/dev/null 2>&1
  stop_spinner

  success "Mac App Store CLI" "installed"
else
  skip "Mac App Store CLI" "already installed, skipping…"
fi

if [ ! -d  "$TARGET_DIR" ]; then
  start_spinner "Dotiles" "cloning…"
  git clone https://github.com/jeef3/dotfiles.git "$TARGET_DIR" >/dev/null 2>&1
  stop_spinner

  success "Dotfiles" "cloned"
else
  start_spinner "Dotfiles" "already installed, updating…"
  (cd "$TARGET_DIR" && git fetch -a)
  stop_spinner

  success "Dotfiles" "updated"
fi

cd $TARGET_DIR
start_spinner "Git submodules" "installing…"
git submodule init >/dev/null 2>&1
git submodule update --recursive >/dev/null 2>&1
stop_spinner
success "Git submodules" "updated"

title "Next Steps"

quote "Run the following command to continue:"
quote "$(tput setab 8; tput setaf 7) cd $TARGET_DIR && ./setup.sh "
