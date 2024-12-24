eval "$(/opt/homebrew/bin/brew shellenv)"
export BREW_HOME=$(brew --prefix)

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export EDITOR="nvim"

# Java
export PATH="$BREW_HOME/opt/openjdk/bin:$PATH"

# Node/npm
export NPM_PACKAGES="$HOME/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"

# Rust
export PATH="$BREW_HOME/opt/rustup/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
