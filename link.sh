#!/usr/bin/env bash

source $(dirname "$0")/setup/util.sh

title "Linking dotfiles"

symlinks=(
  .gitconfig
  .gitignore-global
  .oh-my-zsh
  .vim
  .vimrc
  .zsh
  .zshrc
  .editorconfig
  .aliases
  .exports
  .functions
  .tigrc
  .fzf.zsh
  .scripts
  .tmux
  .tmux.conf
  .config/git
  .config/kitty
  .config/nvim
  .config/ranger
  .config/wezterm
  .todo.cfg
)

# Needs to exist before linking
CONFIG_DIR=~/.config

if [ ! -d "$CONFIG_DIR" ]; then
  mkdir -p $CONFIG_DIR

  success "Config dir created"
else
  skip "$(tput setaf 8)Config dir already exists"
fi


for symlink in ${symlinks[@]}
do
  if [ -e "$HOME/$symlink" ] && ! [ -h "$HOME/$symlink" ]; then
    warn "$HOME/$symlink exists. Please backup and/or remove this first"
  elif [ -h "$HOME/$symlink" ]; then
    rm "$HOME/$symlink"
    ln -s "$(pwd)/$symlink" "$HOME/$symlink"
    success "$(tput bold)$symlink$(tput sgr0) $(tput setaf 8)re-linked"
  else
    ln -s "$(pwd)/$symlink" "$HOME/$symlink"
    success "$(tput bold)$symlink$(tput sgr0) linked"
  fi
done
