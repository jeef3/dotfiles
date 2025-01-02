BRANCH_ICON=""
BEHIND_ICON=" "
AHEAD_ICON=" "

STAGED_ICON="󰅌 "
CONFLICTS_ICON="\uf421"
CHANGED_ICON=" "
UNTRACKED_ICON="\u2026"
CLEAN_ICON="\uf00c"

SEPARATOR="${DARK_GRAY}•"

git_line() {
  precmd_update_git_vars

  if [ -n "$__CURRENT_GIT_STATUS" ]; then
    typeset BRANCH=$GIT_BRANCH

    if [ $(tput cols) -lt 120 ]; then
      BRANCH="${BRANCH:0:15}"
    fi
    if [ $(tput cols) -lt 90 ]; then
      BRANCH="${BRANCH:0:10}"
    fi
    if [ $(tput cols) -lt 60 ]; then
      BRANCH="${BRANCH:0:5}"
    fi

    if [ ${#BRANCH} -lt ${#GIT_BRANCH} ] ; then
      BRANCH="$BRANCH…"
    fi

    # Branch name
    STATUS="${MAGENTA}${BOLD}${BRANCH_ICON} ${BRANCH}${RESET}"

    if [ "$GIT_BEHIND" -ne "0" ]; then
      STATUS="${STATUS} ${SEPARATOR} ${PINK}${BEHIND_ICON}${GIT_BEHIND}${RESET}"
    fi
    if [ "$GIT_AHEAD" -ne "0" ]; then
      STATUS="${STATUS} ${SEPARATOR} ${PINK}${AHEAD_ICON}${GIT_AHEAD}${RESET}"
    fi

    STATUS="${STATUS} ${SEPARATOR}"

    if [ "$GIT_CONFLICTS" -ne "0" ]; then
      STATUS="${STATUS} ${MAGENTA}${CONFLICTS_ICON}${GIT_CONFLICTS}"
    fi
    if [ "$GIT_STAGED" -ne "0" ]; then
      STATUS="${STATUS} ${ORANGE}${STAGED_ICON}${GIT_STAGED}"
    fi
    if [ "$GIT_CHANGED" -ne "0" ]; then
      STATUS="${STATUS} ${GREEN}${CHANGED_ICON}${GIT_CHANGED}"
    fi
    if [ "$GIT_UNTRACKED" -ne "0" ]; then
      STATUS="${STATUS} ${CYAN}${UNTRACKED_ICON}"
    fi
    if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
      STATUS="${STATUS} ${GREEN}${CLEAN_ICON}"
    fi

    STATUS="${STATUS}${RESET}"

    COLS=$(tput cols)

    if [ "$COLS" -gt 100 ]; then
      REMOTE_ORIGIN_URL=$(git config --get remote.origin.url | sed -En 's/(https:\/\/|git@)[^:\/]+(:|\/)(.+)\.git/\3/p')
      REMOTE="${ITALIC}${DARK_GRAY}${REMOTE_ORIGIN_URL}"

      STATUS="${STATUS} ${REMOTE}"
    fi

    if [ "$COLS" -lt 55 ]; then
      STATUS="$MAGENTA$BOLD$BRANCH_ICON"
    fi

    echo "${STATUS}${RESET}"
  fi
}
