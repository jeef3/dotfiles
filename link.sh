#!/bin/sh

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
  .config/kitty
  .config/nvim
  .config/ranger
  .todo.cfg
  .ssh
)

# Needs to exist before linking
CONFIG_DIR=~/.config

if [ ! -d "$CONFIG_DIR" ]; then
  info "Initialise config dir"
  mkdir -p $CONFIG_DIR

  success "Config dir created"
else
  success "Config dir already exists"
fi


for symlink in ${symlinks[@]}
do
  if [ -e "$HOME/$symlink" ] && ! [ -h "$HOME/$symlink" ]; then
    warn "$HOME/$symlink exists. Please backup and/or remove this first"
  elif [ -h "$HOME/$symlink" ]; then
    success "Re-linking $symlink"
    rm "$HOME/$symlink"
    ln -s "$(pwd)/$symlink" "$HOME/$symlink"
  else
    success "Linking $symlink"
    ln -s "$(pwd)/$symlink" "$HOME/$symlink"
  fi
done
