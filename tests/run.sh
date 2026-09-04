#!/usr/bin/env bash
set -euo pipefail

export TERM="${TERM:-xterm-256color}"

test_dir="$(cd "$(dirname "$0")" && pwd)"

# Bootstrap and setup run first: setup installs Neovim, which the Neovim
# tests then exercise.
"$test_dir/test-bootstrap.sh"
"$test_dir/test-setup.sh"
"$test_dir/test-spinner.zsh"
"$test_dir/test-nvim.sh"
"$test_dir/test-util.sh"
"$test_dir/test-zsh.sh"
