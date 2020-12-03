#!/bin/sh

set -e

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }
fail() { printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"; exit; }

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
  .config/ranger
)

info "Linking dotfiles"

for symlink in ${symlinks[@]}
do
  if [ -e "$HOME/$symlink" ] && ! [ -h "$HOME/$symlink" ]; then
    fail "$HOME/$symlink exists. Please backup and/or remove this first"
  elif [ -h "$HOME/$symlink" ]; then
    success "Re-linking $symlink"
    rm "$HOME/$symlink"
    ln -s "$(pwd)/$symlink" "$HOME/$symlink"
  else
    success "Linking $symlink"
    ln -s "$(pwd)/$symlink" "$HOME/$symlink"
  fi
done
