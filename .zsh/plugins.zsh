source ~/.zsh/plugged/zsh-async/async.zsh

autoload bashcompinit; bashcompinit
autoload -Uz compinit; compinit

# Auto-suggestions
source $BREW_HOME/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_USE_ASYNC=1
fpath=(~/.zsh/plugged/zsh-completions/src $fpath)

# FZF searching
source <(fzf --zsh)

# Shell history
# eval "$(atuin init zsh --disable-up-arrow)"

# ==========
# Async
#

load_async_plugins() {
  # Git Prompt
  source ~/.zsh/plugged/zsh-git-prompt.zsh/zshrc.sh

  # Syntax Highlighting
  source $BREW_HOME/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # FZF
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
  export FZF_DEFAULT_OPTS='--height 40% --border'
}

noop() {}

async_init
async_start_worker load_worker -n
async_register_callback load_worker load_async_plugins
async_job load_worker noop
