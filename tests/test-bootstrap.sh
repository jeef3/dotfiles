#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
temp_dir="$(mktemp -d)"
mock_bin="$temp_dir/bin"
log="$temp_dir/commands.log"
target_dir="$temp_dir/dotfiles"
mkdir -p "$mock_bin" "$target_dir"
trap 'rm -rf "$temp_dir"' EXIT

mock_command() {
  local name="$1"
  cat >"$mock_bin/$name"
  chmod +x "$mock_bin/$name"
}

mock_command xcode-select <<'EOF'
#!/usr/bin/env bash
exit 0
EOF

mock_command brew <<EOF
#!/usr/bin/env bash
echo "brew \$*" >>"$log"
EOF

mock_command git <<EOF
#!/usr/bin/env bash
echo "git \$*" >>"$log"
EOF

printf 'y\n' | PATH="$mock_bin:$PATH" TERM=xterm \
  bash "$repo_root/bootstrap.sh" "$target_dir" >/dev/null

grep -qx 'git submodule init' "$log"
grep -qx 'git submodule update --recursive' "$log"
if grep -q '^brew ' "$log"; then
  echo "bootstrap unexpectedly invoked Homebrew" >&2
  exit 1
fi

echo "bootstrap: OK"
