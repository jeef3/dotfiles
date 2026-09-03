#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$repo_root/tests"
commands=()

if ! command -v nvim >/dev/null 2>&1; then
  echo "test-nvim.sh: nvim not found on PATH" >&2
  exit 1
fi

for test_file in "$test_dir"/test-*.lua; do
  commands+=(-c "luafile $test_file")
done

nvim --headless -u NONE "${commands[@]}" -c "qa"
