source ~/.zsh/plugged/zsh-async/async.zsh

noop() {}

load() {
  autoload bashcompinit; bashcompinit
  autoload -Uz compinit; compinit

  load_async_plugins
}

async_init
async_start_worker load_worker -n
async_register_callback load_worker load
async_job load_worker noop

# ==========
# Sync
#

load_plugins() {
  # Auto-suggestions
  source $BREW_HOME/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  export ZSH_AUTOSUGGEST_USE_ASYNC=1
  fpath=(~/.zsh/plugged/zsh-completions/src $fpath)

  # Touchbar
  # source ~/.zsh/plugged/zsh-iterm-touchbar/zsh-iterm-touchbar.plugin.zsh
}
load_plugins

# ==========
# Async
#

load_async_plugins() {
  # Git Prompt
  if [ ! -e ~/.zsh/plugged/zsh-git-prompt/.stack-work ]; then
    echo "\n"
    info "Setting up Haskell support for zsh-git-prompt"
    (cd ~/.zsh/plugged/zsh-git-prompt && \
      stack setup && \
      stack build && stack install)
  fi
  export GIT_PROMPT_EXECUTABLE="haskell"
  source ~/.zsh/plugged/zsh-git-prompt/zshrc.sh

  # .. ... .... aliases
  source ~/.zsh/plugged/up.zsh/up.plugin.zsh

  # Syntax Highlighting
  source $BREW_HOME/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # FZF
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
  export FZF_DEFAULT_OPTS='--height 40% --border'
}
