function node_version() {
  if command -v nvm &> /dev/null; then
    local dir=$(pwd)
    while [ "$dir" != "/" ]; do
      if [ -f "$dir/.nvmrc" ]; then
        local expected=$(< "$dir/.nvmrc")
        local current=$(node -v 2>/dev/null)

        local expected_clean=${expected#v}
        local current_clean=${current#v}

        if [[ "$current_clean" != "$expected_clean"* ]]; then
          echo "${GREEN} ${MAGENTA}${BOLD}${current}${RESET}${DARK_GRAY} (v${expected_clean})"
        else
          echo "${GREEN} ${DARK_GRAY}${current}"
        fi

        return
      fi
      dir=$(dirname "$dir")
    done
  fi
}
