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

# Everything is mocked except Neovim, which is installed for real so the
# Neovim test suite exercises the version this setup actually provisions.
real_brew="$(command -v brew || true)"
if [[ -z "$real_brew" ]]; then
  echo "setup test requires Homebrew on PATH" >&2
  exit 1
fi

mock_command brew <<EOF
#!/usr/bin/env bash
echo "brew \$*" >>"$log"
case "\${1:-}" in
  # Real Brewfile parsing, so the test exercises the actual parser.
  bundle) exec "$real_brew" "\$@" ;;
  --prefix) exec "$real_brew" "\$@" ;;
  # Pretend nothing is installed yet, like a fresh machine.
  list|tap) exit 0 ;;
  cleanup) exit 0 ;;
  install)
    # Neovim and zinit are installed for real: the Neovim and zsh test
    # suites need them, and they are what setup is meant to provision.
    case "\${3:-}" in
      neovim|zinit)
        if [[ "\${2:-}" == --formula ]]; then
          exec "$real_brew" install --formula "\${3}"
        fi
        ;;
    esac
    ;;
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
    HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_ENV_HINTS=1 \
    ./setup.sh >/dev/null
)

grep -qx 'gh auth status' "$log"
grep -qx 'git remote set-url origin git@github.com:jeef3/dotfiles.git' "$log"
test -L "$home/.zshrc"
test -L "$home/.config/nvim"

grep -qx 'brew install --formula neovim' "$log"
grep -qx 'brew install --formula zinit' "$log"
if ! command -v nvim >/dev/null 2>&1; then
  echo "setup did not leave nvim available on PATH" >&2
  exit 1
fi

if grep -q '^npm install ' "$log"; then
  echo "setup unexpectedly installed an npm package" >&2
  exit 1
fi

echo "setup: OK"
