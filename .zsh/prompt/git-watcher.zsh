# Git watcher — live git status updates via fswatch + zle -F
# Watches .git directory for meaningful changes and triggers prompt refresh

zmodload zsh/datetime
zmodload zsh/system

typeset -g _GIT_WATCHER_PID=0
typeset -g _GIT_WATCHER_FD=0
typeset -g _GIT_WATCHER_ROOT=""
typeset -g _GIT_WATCHER_LAST_REFRESH=0
typeset -g _GIT_WATCHER_DEBOUNCE=0.5

function _git_watcher_handler() {
  local fd=$1
  local line

  # Drain all pending events from the fd
  while sysread -i $fd -t 0 line 2>/dev/null; do
    :
  done

  # Debounce: only refresh if enough time has passed
  local now=$EPOCHREALTIME
  local elapsed=$(( now - _GIT_WATCHER_LAST_REFRESH ))

  if (( elapsed >= _GIT_WATCHER_DEBOUNCE )); then
    _GIT_WATCHER_LAST_REFRESH=$now
    zle && zle .reset-prompt
  fi
}

function _git_watcher_start() {
  local git_root=$1

  [[ -z "$git_root" ]] && return 1
  [[ ! -d "$git_root/.git" ]] && return 1

  local git_dir="$git_root/.git"

  # Create a pipe for fswatch output
  local pipe_file=$(mktemp -u)
  mkfifo "$pipe_file"

  # Build list of paths to watch (only include files that exist)
  local -a watch_paths
  watch_paths=("$git_dir/HEAD" "$git_dir/index" "$git_dir/refs")
  [[ -f "$git_dir/MERGE_HEAD" ]] && watch_paths+=("$git_dir/MERGE_HEAD")
  [[ -f "$git_dir/REBASE_HEAD" ]] && watch_paths+=("$git_dir/REBASE_HEAD")

  # Start fswatch watching key git paths (suppress job notifications)
  setopt local_options no_monitor no_notify

  fswatch --latency=0.3 \
    "${watch_paths[@]}" \
    > "$pipe_file" 2>/dev/null &

  _GIT_WATCHER_PID=$!

  # Open the pipe as a file descriptor for zle
  exec {_GIT_WATCHER_FD}<"$pipe_file"
  rm -f "$pipe_file"

  # Register the fd with zle
  zle -F $_GIT_WATCHER_FD _git_watcher_handler

  _GIT_WATCHER_ROOT=$git_root
  _GIT_WATCHER_LAST_REFRESH=$EPOCHREALTIME
}

function _git_watcher_stop() {
  if (( _GIT_WATCHER_PID > 0 )); then
    kill $_GIT_WATCHER_PID 2>/dev/null
    _GIT_WATCHER_PID=0
  fi

  if (( _GIT_WATCHER_FD > 0 )); then
    zle -F $_GIT_WATCHER_FD
    exec {_GIT_WATCHER_FD}<&-
    _GIT_WATCHER_FD=0
  fi

  _GIT_WATCHER_ROOT=""
}

function _git_watcher_ensure() {
  # Skip if fswatch isn't available
  command -v fswatch &>/dev/null || return

  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)

  if [[ -z "$git_root" ]]; then
    # Not in a git repo — stop any running watcher
    _git_watcher_stop
    return
  fi

  if [[ "$git_root" != "$_GIT_WATCHER_ROOT" ]]; then
    # Different repo (or first time) — restart watcher
    _git_watcher_stop
    _git_watcher_start "$git_root"
  fi
}

function _git_watcher_cleanup() {
  _git_watcher_stop
}
