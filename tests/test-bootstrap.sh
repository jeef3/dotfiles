#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
temp_dir="$(mktemp -d)"
mock_bin="$temp_dir/bin"
log="$temp_dir/commands.log"
home="$temp_dir/home"
mkdir -p "$mock_bin" "$home"
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
if [[ "\${1:-}" == clone ]]; then
  mkdir -p "\${3}"
fi
EOF

mock_command curl <<EOF
#!/usr/bin/env bash
echo "curl \$*" >>"$log"
last_arg=""
for arg in "\$@"; do
  last_arg="\$arg"
done

case "\$last_arg" in
  https://raw.githubusercontent.com/jeef3/dotfiles/main/bootstrap.sh)
    cat "$repo_root/bootstrap.sh"
    ;;
  *)
    exit 1
    ;;
esac
EOF

HOME="$home" PATH="$mock_bin:$PATH" TERM=xterm DOTFILES_BOOTSTRAP_YES=1 \
  bash -c 'curl -fsSL https://raw.githubusercontent.com/jeef3/dotfiles/main/bootstrap.sh | bash' \
  >/dev/null

target_dir="$home/projects/dotfiles"
grep -qx 'curl -fsSL https://raw.githubusercontent.com/jeef3/dotfiles/main/bootstrap.sh' "$log"
grep -qx "git clone https://github.com/jeef3/dotfiles.git $target_dir" "$log"
grep -qx 'git submodule init' "$log"
grep -qx 'git submodule update --recursive' "$log"
if grep -q '^brew ' "$log"; then
  echo "bootstrap unexpectedly invoked Homebrew" >&2
  exit 1
fi

echo "bootstrap: OK"
