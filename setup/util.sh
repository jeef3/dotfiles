#!/usr/bin/env bash

title() { printf "\n $(tput bold)$1$(tput sgr0)\n\n"; }

success() { printf "  $(tput setaf 8)[ $(tput setaf 10)✔$(tput setaf 8) ] $(tput sgr0)$1\n"; }
warn() { printf "  $(tput setaf 8)[ $(tput setaf 3)!$(tput setaf 8) ] $(tput setaf 3)$1\n"; }
fail() { printf "  $(tput setaf 8)[ $(tput setaf 1)⨉$(tput setaf 8) ] $(tput sgr0)$1\n"; }
info() { printf "  $(tput setaf 8)[ $(tput setaf 12)…$(tput setaf 8) ] $(tput sgr0)$1\n"; }

cmd() { printf "  $(tput setaf 8)›  $(tput setaf 14) \t$(tput bold)$(tput setaf 8)$1$(tput sgr0)\n"; }

spinner()
{
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "  $(tput setaf 8)[ $(tput setaf 12)%c$(tput setaf 8) ] " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}
