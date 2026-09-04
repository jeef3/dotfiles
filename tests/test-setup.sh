#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
temp_dir="$(mktemp -d)"
mock_bin="$temp_dir/bin"
home="$temp_dir/home"
log="$temp_dir/commands.log"
mkdir -p "$mock_bin" "$home"
trap 'rm -rf "$temp_dir"' EXIT

source "$repo_root/tests/setup-mocks.sh"
setup_install_mocks "$mock_bin" "$log"

(
  cd "$repo_root"
  HOME="$home" TERM=xterm ./setup.sh --test >/dev/null
)

grep -qx 'gh auth status' "$log"
grep -qx 'git remote set-url origin git@github.com:jeef3/dotfiles.git' "$log"
test -L "$home/.zshrc"
test -L "$home/.config/nvim"

grep -qx 'brew install --formula neovim' "$log"
grep -qx 'brew install --formula zinit' "$log"
grep -qx 'brew install --formula zoxide' "$log"
grep -qx 'brew install --formula fnm' "$log"
if ! command -v nvim >/dev/null 2>&1; then
  echo "setup did not leave nvim available on PATH" >&2
  exit 1
fi
if ! command -v zoxide >/dev/null 2>&1; then
  echo "setup did not leave zoxide available on PATH" >&2
  exit 1
fi
if ! command -v fnm >/dev/null 2>&1; then
  echo "setup did not leave fnm available on PATH" >&2
  exit 1
fi

if grep -q '^npm install ' "$log"; then
  echo "setup unexpectedly installed an npm package" >&2
  exit 1
fi

echo "setup: OK"
