#!/bin/sh
source lib/messages

symlinks=(
  .gitconfig
  .gitignore-global
  .oh-my-zsh
  .vim
  .vimrc
  .zshrc
  .editorconfig
  .exports
  .functions
  .tmux.conf
  .tmux
)

# link_file () {
# }

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
