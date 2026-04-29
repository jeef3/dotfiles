ROOT=${0:A:h}
source $ROOT/prompt/output.zsh

source $ROOT/prompt/current-dir.zsh
source $ROOT/prompt/exit-status.zsh
source $ROOT/prompt/git-line.zsh
source $ROOT/prompt/jobbies.zsh
source $ROOT/prompt/vi-mode.zsh
source $ROOT/prompt/border.zsh
source $ROOT/prompt/node.sh

setopt prompt_subst

function noop() { }

function render_git_status() {
  # Escape codes move the git status up one row
  RPROMPT='%{'$'\e[1A''%}$(git_line)%{'$'\e[1B''%}'

  zle && zle .reset-prompt
  async_stop_worker prompt_worker -n
}

function async_load_rprompt() {
  async_init
  async_start_worker prompt_worker -n
  async_register_callback prompt_worker render_git_status
  async_job prompt_worker noop

  RPROMPT="…"
}

# Redraw prompt on terminal focus (requires focus reporting)
function _enable_focus_reporting() { printf '\e[?1004h'; }
function _disable_focus_reporting() { printf '\e[?1004l'; }

function _terminal_focus_in() {
  zle && zle .reset-prompt
}
function _terminal_focus_out() { }

function zle-line-init() {
  _enable_focus_reporting
}

function precmd() {
  PROMPT='$(border)
$(current_dir) $(node_version) $(jobbies)
$(exit_status)${VIM_MODE}${RESET} '
  RPROMPT=''

  async_load_rprompt
}

function preexec() {
  _disable_focus_reporting
}

zle -N zle-line-init
zle -N _terminal_focus_in
zle -N _terminal_focus_out

bindkey '\e[I' _terminal_focus_in
bindkey '\e[O' _terminal_focus_out
