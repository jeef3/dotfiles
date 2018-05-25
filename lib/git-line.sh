source $HOME/projects/dotfiles/lib/zsh-git-prompt/zshrc.sh

ZSH_THEME_GIT_PROMPT_BEHIND="\uf433"
ZSH_THEME_GIT_PROMPT_AHEAD="\uf431"

ZSH_THEME_GIT_PROMPT_STAGED="%F{3}\uf429"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%F{5}\uf421"
ZSH_THEME_GIT_PROMPT_CHANGED="%F{2}\uf040"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{6}\u2026"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{2}\uf00c"

ITALIC=$'%{\x1b[3m%}'

git_status() {
  local SEPARATOR="%F{8}•%{${reset_color}%}"

  if [ -n "$__CURRENT_GIT_STATUS" ]; then

    STATUS="%F{13}\ue725 %B$GIT_BRANCH%{${reset_color}%}"

    if [ "$GIT_BEHIND" -ne "0" ]; then
      STATUS="$STATUS $SEPARATOR $ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%{${reset_color}%}"
    fi
    if [ "$GIT_AHEAD" -ne "0" ]; then
      STATUS="$STATUS $SEPARATOR $ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%{${reset_color}%}"
    fi

    STATUS="$STATUS $SEPARATOR"


    if [ "$GIT_CONFLICTS" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
    fi
    if [ "$GIT_STAGED" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
    fi
    if [ "$GIT_CHANGED" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
    fi
    if [ "$GIT_UNTRACKED" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
    fi
    if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_CLEAN"
    fi

    STATUS="$STATUS%{${reset_color}%}"

    if [ $(tput cols) -gt 100 ]; then
      REMOTE_ORIGIN_URL=$(git config --get remote.origin.url | sed -En 's/(https:\/\/|git@)[^:\/]+(:|\/)(.+)\.git/\3/p')
      STATUS="$STATUS ${ITALIC}%F{8}${REMOTE_ORIGIN_URL}"
    fi

    echo "$STATUS"
  fi
}
