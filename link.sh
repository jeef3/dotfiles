#!/bin/sh
source lib/colors.sh

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
)

info () {
  printf "\r\033[2K  [ ${BLUE}..${RESET} ] ${WHITE}${BOLD}$1${RESET}\n"
}

warn () {
  printf "\r\033[2K  [${YELLOW}WARN${RESET}] $1\n"
}

success () {
  printf "\r\033[2K  [ ${GREEN}OK${RESET} ] $1\n"
}

fail () {
  printf "\r\033[2K  [${RED}FAIL${RESET}] $1\n"
  echo ''
  exit
}

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
