PROG='@a = split " ";
print join " ", @a[0..($#a-1)];
if (rindex($a[$#a], "/") != -1) {
  if (scalar @a > 1) { print " "; }
  @b = split "/", $a[$#a];
  print join "/", @b[0..($#b-1)]
}'

function _up-dir {
  if [ -z "$BUFFER" ]; then
    parent="$(dirname "$PWD")"
    cd "$parent"
    zle reset-prompt
  else
    BUFFER=$(echo "$BUFFER" | perl -ne "$PROG")
  fi

}
zle -N _up-dir
bindkey "^h" _up-dir

function wtcd {
  if [[ -n "${TMUX:-}" && -n "${TMUX_PANE:-}" ]] &&
    tmux display-message -p -t "$TMUX_PANE" '#{pane_id}' >/dev/null 2>&1; then
    command wtcd
    return
  fi

  local destination
  destination="$(command wtcd)" || return

  if [[ -n "$destination" && -d "$destination" ]]; then
    cd -- "$destination"
  fi
}

function _change-to-worktree {
  local destination
  destination="$(tmux show-option -pv -t "$TMUX_PANE" @wtcd-destination 2>/dev/null)"

  if [[ -n "$destination" && -d "$destination" ]]; then
    cd -- "$destination"
    zle reset-prompt
  fi
}
zle -N _change-to-worktree
for keymap in emacs viins vicmd; do
  bindkey -M "$keymap" "^X^W" _change-to-worktree
done
