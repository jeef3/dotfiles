#!/bin/bash

title() { printf "\n $(tput bold)$1$(tput sgr0)\n\n"; }
check() { printf " $(tput setaf 8)›  $(tput setaf 10)✓\t$(tput sgr0)$1\n"; }
info() { printf " $(tput setaf 8)›  $(tput setaf 12)…\t$(tput sgr0)$1\n"; }
cmd() { printf " $(tput setaf 8)›  $(tput setaf 14)↘️\t$(tput bold)$(tput setaf 8)$1$(tput sgr0)\n"; }

title "Bubu Time!"

info "Updating Homebrew"
info "If this fails, run brew update-reset"
cmd "brew update"
brew update

OUTDATED=$(brew outdated)
UPDATED=($OUTDATED)

info "Checking for and updating outdated brews"
cmd "brew upgrade"
brew upgrade

info "Cleaning up"
cmd "brew cleanup"
brew cleanup

# Summary
title "Brews updated:"
for index in ${!UPDATED[*]}
do
  check "${UPDATED[$index]}"
done
