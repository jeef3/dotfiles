#!/usr/bin/env bash
set -euo pipefail

test_dir="$(cd "$(dirname "$0")" && pwd)"

# Bootstrap and setup run first: setup installs Neovim, which the Neovim
# tests then exercise.
"$test_dir/test-bootstrap.sh"
"$test_dir/test-setup.sh"
"$test_dir/test-spinner.sh"
"$test_dir/test-zsh.sh"
"$test_dir/test-nvim.sh"
