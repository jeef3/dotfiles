source ~/.zsh/plugged/zsh-async/async.zsh

noop() {}

load() {
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
  ZSH_AUTOSUGGEST_USE_ASYNC=1

  fpath=(~/.zsh/plugged/zsh-completions/src $fpath)
}
load_plugins

# ==========
# Async
#

load_async_plugins() {
  # Git Prompt
  source ~/.zsh/plugged/zsh-git-prompt/zshrc.sh

  # Autosuggestions
  source $BREW_HOME/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  ZSH_AUTOSUGGEST_USE_ASYNC=1
  fpath=(~/.zsh/plugged/zsh-completions/src $fpath)

  # Syntax Highlighting
  source $BREW_HOME/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}