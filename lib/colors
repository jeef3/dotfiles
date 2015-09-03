#!/bin/sh

if tput setaf 1 &> /dev/null; then
  tput sgr0

  BLACK=$(tput setaf 0)
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)
  BLUE=$(tput setaf 4)
  MAGENTA=$(tput setaf 5)
  CYAN=$(tput setaf 6)
  WHITE=$(tput setaf 7)

  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  BLACK="\033[0;30m"
  RED="\033[0;31m"
  GREEN="\033[0;32m"
  YELLOW="\033[0;33m"
  BLUE="\033[0;34m"
  MAGENTA="\033[0;35m"
  CYAN="\033[0;36m"
  WHITE="\033[0;37m"

  BOLD=""
  RESET="\033[m"
fi
