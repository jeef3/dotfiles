eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"

BREW_HOME=$(brew --prefix)

# Shell history
# eval "$(atuin init zsh --disable-up-arrow)"

# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load scripts
[[ -d "$HOME/.scripts" ]] && export PATH=$HOME/.scripts:$PATH

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}

setopt hist_expire_dups_first

source ~/.config/wezterm/shell_integration.sh

source ~/.zsh/plugins.zsh
source ~/.zsh/prompt.zsh

# Completion
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:descriptions' format '%F{#b3b3d4}%K{#ff3399} %d %F{#ff3399}%K{black}%f%k'

# Add Homebrew's sbin to PATH
export PATH="/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Created by `pipx` on 2024-07-26 02:22:27
export PATH="$PATH:$HOME/.local/bin"

export PATH="$PATH:$HOME/.dotnet/tools"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/jeffknaggs/.dart-cli-completion/zsh-config.zsh ]] && . /Users/jeffknaggs/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

