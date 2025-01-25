eval "$(/opt/homebrew/bin/brew shellenv)"
export BREW_HOME=$(brew --prefix)

source "$BREW_HOME/opt/zinit/zinit.zsh"

eval "$(zoxide init zsh)"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export EDITOR="nvim"

export CLICOLOR=1

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Load scripts
[[ -d "$HOME/.scripts" ]] && export PATH=$HOME/.scripts:$PATH

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}

setopt hist_expire_dups_first
setopt interactive_comments

source ~/.config/wezterm/shell_integration.sh

for file in ~/.zsh/{plugins,prompt,path,aliases,functions}.zsh; do
    [ -r "$file" ] && source "$file"
done
unset file
