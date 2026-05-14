# Deduplicate PATH entries
typeset -U PATH path

# Java
export PATH="$BREW_HOME/opt/openjdk/bin:$PATH"

# Node (fnm default, ensures GUI apps can find Node)
export PATH="$HOME/.local/share/fnm/aliases/default/bin:$PATH"

# Node/npm
export NPM_PACKAGES="$HOME/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"

# Rust
export PATH="$BREW_HOME/opt/rustup/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Pythons app binaries
export PATH="$HOME/.local/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$PATH"
