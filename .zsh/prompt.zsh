ROOT=${0:A:h}
source $ROOT/prompt/output.zsh

source $ROOT/prompt/current-dir.zsh
source $ROOT/prompt/exit-status.zsh
source $ROOT/prompt/git-line.zsh
source $ROOT/prompt/jobbies.zsh
source $ROOT/prompt/vi-mode.zsh
source $ROOT/prompt/border.zsh

setopt prompt_subst

function noop() {}

function my_prompt() {
  RPROMPT='$(git_line)'

  zle && zle .reset-prompt
  async_stop_worker prompt_worker -n
}

async_load_prompt() {
  async_init
  async_start_worker prompt_worker -n
  async_register_callback prompt_worker my_prompt
  async_job prompt_worker noop

  RPROMPT="…"
}

function precmd() {
  PROMPT='$(border)
$(current_dir)$(jobbies)
$(exit_status)${VIM_MODE}${RESET} '
  RPROMPT=''

  async_load_prompt
}
