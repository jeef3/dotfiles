# Origin source https://github.com/sindresorhus/pure

prompt_check_git_arrows() {
  # check if there is an upstream configured for this branch
  command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

  # local arrow_status
  arrow_status="$(command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)"
  (( !$? )) || return

  # # left and right are tab-separated, split on tab and store as array
  arrow_status=(${(ps:\t:)arrow_status})
  local arrows left=${arrow_status[1]} right=${arrow_status[2]}

  (( ${right:-0} > 0 )) && arrows+="${PURE_GIT_DOWN_ARROW:-⇣}"
  (( ${left:-0} > 0 )) && arrows+="${PURE_GIT_UP_ARROW:-⇡}"

  [[ -n $arrows ]] && echo "${arrows}"
}
