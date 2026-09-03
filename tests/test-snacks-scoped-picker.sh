#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
nvim --headless -u NONE \
  -c "luafile $repo_root/tests/snacks_scoped_picker.lua" \
  -c "luafile $repo_root/tests/snacks_picker_footer.lua" \
  -c "qa"
