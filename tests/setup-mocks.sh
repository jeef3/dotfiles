#!/usr/bin/env bash

setup_install_mocks() {
  local mock_bin="$1"
  local log="$2"
  local repo_root="${3:-}"

  mkdir -p "$mock_bin"

  local real_brew
  real_brew="$(command -v brew || true)"
  if [[ -z "$real_brew" ]]; then
    echo "setup mocks require Homebrew on PATH" >&2
    return 1
  fi

  cat >"$mock_bin/brew" <<EOF
#!/usr/bin/env bash
echo "brew \$*" >>"$log"
case "\${1:-}" in
  bundle) exec "$real_brew" "\$@" ;;
  --prefix) exec "$real_brew" "\$@" ;;
  list|tap|cleanup) exit 0 ;;
  install)
    case "\${3:-}" in
      neovim|zinit|zoxide|fnm)
        if [[ "\${2:-}" == --formula ]]; then
          exec "$real_brew" install --formula "\${3}"
        fi
        ;;
    esac
    ;;
esac
EOF
  chmod +x "$mock_bin/brew"

  cat >"$mock_bin/npm" <<EOF
#!/usr/bin/env bash
echo "npm \$*" >>"$log"
case "\${1:-}" in
  ls) exit 0 ;;
esac
EOF
  chmod +x "$mock_bin/npm"

  cat >"$mock_bin/gh" <<EOF
#!/usr/bin/env bash
echo "gh \$*" >>"$log"
if [[ "\${1:-}" == auth && "\${2:-}" == status ]]; then
  exit 0
fi
exit 1
EOF
  chmod +x "$mock_bin/gh"

  cat >"$mock_bin/git" <<EOF
#!/usr/bin/env bash
echo "git \$*" >>"$log"
if [[ "\${1:-}" == clone ]]; then
  mkdir -p "\${3}"
  if [[ -n "$repo_root" ]]; then
    cp -R "$repo_root"/. "\${3}/"
  fi
fi
EOF
  chmod +x "$mock_bin/git"

  export PATH="$mock_bin:$PATH"
  export DOTFILES_TEST_LOG="$log"
}
