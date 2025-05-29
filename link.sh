#!/usr/bin/env bash

source $(dirname "$0")/setup/util.sh

title "Linking Dotfiles"

symlinks=(
  .aliases
  .editorconfig
  .functions

  .gitconfig
  .gitignore-global

  .zsh
  .zshenv
  .zshrc

  .scripts

  .config/git
  .config/kitty
  .config/ghostty
  .config/nvim
  .config/ranger
  .config/todotxt-tui
  .config/tmux
  .config/wezterm

  .todo.cfg
)

# Needs to exist before linking
CONFIG_DIR=~/.config

if [ ! -d "$CONFIG_DIR" ]; then
  mkdir -p $CONFIG_DIR

  success "Config dir" "created"
else
  skip "Config dir" "already exists, skipping…"
fi

for symlink in ${symlinks[@]}
do
  if [ -e "$HOME/$symlink" ] && ! [ -h "$HOME/$symlink" ]; then
    warn "$symlink" "exists. Please backup and/or remove this first"
  elif [ -h "$HOME/$symlink" ]; then
    skip "$symlink" "already linked, skipping…"
  else
    ln -s "$(pwd)/$symlink" "$HOME/$symlink"
    success "$symlink" "linked"
  fi
done
