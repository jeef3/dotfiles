ROOT=${0:A:h}
source $ROOT/prompt/colors.zsh

source $ROOT/prompt/current-dir.zsh
source $ROOT/prompt/exit-status.zsh
source $ROOT/prompt/git-line.zsh
source $ROOT/prompt/jobbies.zsh
source $ROOT/prompt/vi-mode.zsh
source $ROOT/prompt/border.zsh
source $ROOT/prompt/node.zsh
source $ROOT/prompt/git-watcher.zsh

setopt prompt_subst

zmodload zsh/sched

# Cursor movement for RPROMPT on row above
CURSOR_UP=$'%{\e[1A%}'
CURSOR_DOWN=$'%{\e[1B%}'
typeset -g GIT_WATCHER_ENABLED=${GIT_WATCHER_ENABLED:-0}

function render_git_status() {
  # Escape codes move the git status up one row
  RPROMPT="${CURSOR_UP}$(git_line)${CURSOR_DOWN}"

  zle && zle .reset-prompt
  async_stop_worker prompt_worker -n
}

function _rprompt_timeout() {
  if [[ "$RPROMPT" == "…" ]]; then
    async_stop_worker prompt_worker -n
    RPROMPT="${CURSOR_UP}${RED}⚠${RESET}${CURSOR_DOWN}"
    zle && zle .reset-prompt
  fi
}

function async_load_rprompt() {
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    RPROMPT=""
    return
  fi

  async_init
  async_start_worker prompt_worker -n
  async_register_callback prompt_worker render_git_status
  async_job prompt_worker :

  RPROMPT="${CURSOR_UP}${BRIGHT_BLACK}▬▬▬  • ${RESET}${CURSOR_DOWN}"

  # Clear stale "…" after 5 seconds if git hasn't responded
  sched +5 _rprompt_timeout
}

# Redraw prompt on terminal focus (requires focus reporting)
function _enable_focus_reporting() { printf '\e[?1004h'; }
function _disable_focus_reporting() { printf '\e[?1004l'; }

function _terminal_focus_in() {
  if (( GIT_WATCHER_ENABLED )); then
    _git_watcher_ensure
  fi

  if git rev-parse --is-inside-work-tree &>/dev/null; then
    RPROMPT="${CURSOR_UP}$(git_line)${CURSOR_DOWN}"
  else
    RPROMPT=''
  fi

  zle && zle .reset-prompt
}
function _terminal_focus_out() { }

function zle-line-init() {
  _enable_focus_reporting
}

function precmd() {
  if (( GIT_WATCHER_ENABLED )); then
    _git_watcher_ensure
  else
    _git_watcher_cleanup
  fi

  PROMPT='$(border)
$(current_dir)$(node_version)$(jobbies)
$(exit_status)${VIM_MODE}${RESET} '
  RPROMPT=''

  async_load_rprompt
}

function preexec() {
  _disable_focus_reporting
}

function zshexit() {
  _git_watcher_cleanup
}

zle -N zle-line-init
zle -N _terminal_focus_in
zle -N _terminal_focus_out

bindkey '\e[I' _terminal_focus_in
bindkey '\e[O' _terminal_focus_out
