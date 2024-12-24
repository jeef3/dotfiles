eval "$(zoxide init zsh)"

export CLICOLOR=1

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,aliases,functions}; do
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
