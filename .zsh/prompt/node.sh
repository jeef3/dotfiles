function node_version() {
  if command -v nvm &> /dev/null; then
    # Traverse up the directory tree
    local dir=$(pwd)
    while [ "$dir" != "/" ]; do
      if [ -f "$dir/.nvmrc" ]; then
        # If .nvmrc is found, print the current Node version
        echo "${GREEN} ${DARK_GRAY}$(node -v)"
        return
      fi
      dir=$(dirname "$dir")
    done
  fi
}
