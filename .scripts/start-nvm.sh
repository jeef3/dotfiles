#!/usr/bin/env bash

source $(dirname "$0")/../setup/util.sh
source $(dirname "$0")/../setup/spinner.sh

title "Start nvm"

command -v nvm > /dev/null
if [ $? -eq 1 ]; then
  fail "nvm not installed"
  exit;
fi

which nvm > /dev/null
if [ $? -eq 0 ]; then
  success "nvm already started"
  exit;
fi

start_spinner "Starting nvm…"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

stop_spinner
success "nvm started\n"
