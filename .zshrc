source "$BREW_HOME/opt/zinit/zinit.zsh"

eval "$(zoxide init zsh)"

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export EDITOR="nvim"
export LESS="-FXR --mouse"

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

for file in ~/.zsh/{plugins,prompt,aliases,functions}.zsh; do
  [ -r "$file" ] && source "$file"
done
unset file

export NODE_OPTIONS="--max-old-space-size=8192"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(fnm completions --shell zsh)"

((${+commands[rush]})) && {
  _rush_completion() {
    local words=("${(@s: :)LBUFFER}")
    local completions=$(rush tab-complete --position ${CURSOR} --word "${words[-1]}" 2>/dev/null)
    reply=(${(f)completions})
  }
  compctl -K _rush_completion rush
}
