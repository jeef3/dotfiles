#!/bin/bash

title() { printf "\n$(tput bold)$1\n\n"; }
check() { printf "  \033[00;32m✔︎\033[0m $1\n"; }
info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }

info "Updating Homebrew"
brew update

OUTDATED=$(brew outdated)
UPDATED=($OUTDATED)

info "Checking for and updating outdated brews"
brew upgrade

info "Cleaning up"
brew cleanup

# Summary
title "Brews updated:"
for index in ${!UPDATED[*]}
do
  check "${UPDATED[$index]}"
done

