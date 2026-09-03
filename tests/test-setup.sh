#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
temp_dir="$(mktemp -d)"
mock_bin="$temp_dir/bin"
home="$temp_dir/home"
log="$temp_dir/commands.log"
mkdir -p "$mock_bin" "$home"
trap 'rm -rf "$temp_dir"' EXIT

mock_command() {
  local name="$1"
  cat >"$mock_bin/$name"
  chmod +x "$mock_bin/$name"
}

mock_command brew <<EOF
#!/usr/bin/env bash
echo "brew \$*" >>"$log"
case "\${1:-}" in
  list) exit 0 ;;
esac
EOF

mock_command npm <<EOF
#!/usr/bin/env bash
echo "npm \$*" >>"$log"
case "\${1:-}" in
  ls) exit 0 ;;
esac
EOF

mock_command gh <<EOF
#!/usr/bin/env bash
echo "gh \$*" >>"$log"
if [[ "\${1:-}" == auth && "\${2:-}" == status ]]; then
  exit 0
fi
exit 1
EOF

mock_command git <<EOF
#!/usr/bin/env bash
echo "git \$*" >>"$log"
EOF

(
  cd "$repo_root"
  HOME="$home" PATH="$mock_bin:$PATH" TERM=xterm SPINNER_DELAY=0 \
    bash ./setup.sh >/dev/null
)

grep -qx 'gh auth status' "$log"
grep -qx 'git remote set-url origin git@github.com:jeef3/dotfiles.git' "$log"
test -L "$home/.zshrc"
test -L "$home/.config/nvim"
if grep -q '^npm install ' "$log"; then
  echo "setup unexpectedly installed an npm package" >&2
  exit 1
fi

echo "setup: OK"
