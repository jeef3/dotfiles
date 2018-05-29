DIR=$(dirname $0)

source $DIR/zsh-git-prompt/zshrc.sh

BRANCH_ICON="\ue725"
BEHIND_ICON="\uf433"
AHEAD_ICON="\uf431"

STAGED_ICON="\uf429"
CONFLICTS_ICON="\uf421"
CHANGED_ICON="\uf040"
UNTRACKED_ICON="\u2026"
CLEAN_ICON="\uf00c"

git_status() {
  local SEPARATOR="${DARK_GRAY}•"

  if [ -n "$__CURRENT_GIT_STATUS" ]; then

    # Branch name
    STATUS="${MAGENTA}${BOLD}${BRANCH_ICON} ${GIT_BRANCH}${RESET}"

    if [ "$GIT_BEHIND" -ne "0" ]; then
      STATUS="${STATUS} ${SEPARATOR} ${BEHIND_ICON}${GIT_BEHIND}${RESET}"
    fi
    if [ "$GIT_AHEAD" -ne "0" ]; then
      STATUS="${STATUS} ${SEPARATOR} ${AHEAD_ICON}${GIT_AHEAD}${RESET}"
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

    if [ $(tput cols) -gt 100 ]; then
      REMOTE_ORIGIN_URL=$(git config --get remote.origin.url | sed -En 's/(https:\/\/|git@)[^:\/]+(:|\/)(.+)\.git/\3/p')
      REMOTE="${ITALIC}${DARK_GRAY}${REMOTE_ORIGIN_URL}"

      STATUS="${STATUS} ${REMOTE}"
    fi

    echo "${STATUS}${RESET}"
  fi
}
