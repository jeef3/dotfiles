#!/usr/bin/env bash
set -euo pipefail

# macOS defaults to zsh, so the shell config we ship is what actually runs on a
# new machine. These tests never print file contents, only pass/fail.

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
export TERM="${TERM:-xterm-256color}"

if ! command -v zsh >/dev/null 2>&1; then
  echo "test-zsh.sh: zsh not found on PATH" >&2
  exit 1
fi

failures=0

check_syntax() {
  local file="$1"
  local rel="${file#"$repo_root"/}"
  if zsh -n "$file" 2>/dev/null; then
    return 0
  fi
  echo "  syntax error in $rel" >&2
  failures=$((failures + 1))
}

shopt -s nullglob
for file in "$repo_root"/.zshrc "$repo_root"/.zprofile "$repo_root"/.zsh/*.zsh; do
  check_syntax "$file"
done
shopt -u nullglob

if [ "$failures" -gt 0 ]; then
  echo "zsh: $failures file(s) failed to parse" >&2
  exit 1
fi

# Actually start a login+interactive shell against the shipped config in an
# isolated HOME. Terminal.app starts login shells, and .zprofile sets variables
# such as BREW_HOME that .zshrc relies on.
temp_home="$(mktemp -d)"
trap 'rm -rf "$temp_home"' EXIT
stderr_file="$temp_home/stderr"

ln -s "$repo_root/.zsh" "$temp_home/.zsh"
ln -s "$repo_root/.zshrc" "$temp_home/.zshrc"
ln -s "$repo_root/.zprofile" "$temp_home/.zprofile"

if ! HOME="$temp_home" ZDOTDIR="$temp_home" zsh -lic 'exit 0' \
  >/dev/null 2>"$stderr_file"; then
  echo "zsh: shell failed to start with the shipped config" >&2
  sed 's/^/  /' "$stderr_file" >&2
  exit 1
fi

if [ -s "$stderr_file" ]; then
  echo "zsh: shell started but reported errors" >&2
  sed 's/^/  /' "$stderr_file" >&2
  exit 1
fi

echo "zsh: OK"
