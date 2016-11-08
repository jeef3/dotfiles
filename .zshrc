# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
source $HOME/projects/dotfiles/lib/zsh-git-prompt/zshrc.sh

# User configuration
export PATH=~/bin:/usr/local/sbin:/usr/local/bin:$PATH

. `brew --prefix`/etc/profile.d/z.sh

# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load scripts
[[ -d "$HOME/.scripts" ]] && export PATH=$HOME/.scripts:$PATH

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Prompts


git_status() {
  precmd_update_git_vars

  local PREFIX="%F{13}\uE0A0%B%{$reset_color%} "
  local SEPARATOR="%F{8}•%{${reset_color}%}"

  if [ -n "$__CURRENT_GIT_STATUS" ]; then
    STATUS="$PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"

    if [ "$GIT_BEHIND" -ne "0" ]; then
      STATUS="$STATUS $SEPARATOR $ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%{${reset_color}%}"
    fi
    if [ "$GIT_AHEAD" -ne "0" ]; then
      STATUS="$STATUS $SEPARATOR $ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%{${reset_color}%}"
    fi

    STATUS="$STATUS $SEPARATOR"

    ZSH_THEME_GIT_PROMPT_STAGED="%F{3}☝️ "
    # ZSH_THEME_GIT_PROMPT_CONFLICTS=""
    ZSH_THEME_GIT_PROMPT_CHANGED="%F{2}✏️ "
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{6}…"

    if [ "$GIT_STAGED" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
    fi
    if [ "$GIT_CONFLICTS" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
    fi
    if [ "$GIT_CHANGED" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
    fi
    if [ "$GIT_UNTRACKED" -ne "0" ]; then
      STATUS="$STATUS $ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
    fi
    if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi

    STATUS="$STATUS%{${reset_color}%}"
    echo "$STATUS"
  fi
}

git_info() {
  git rev-parse --is-inside-work-tree &> /dev/null || return

  echo "%F{8}%Bon%{$reset_color%} $branch $gstatus"
}

git_origin() {
  git rev-parse --is-inside-work-tree &> /dev/null || return

  local url=$(git config --get remote.origin.url | sed -En 's/(https:\/\/|git@)[^:\/]+(:|\/)(.+)\.git/\3/p')
  echo $url
}

collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

local user_host=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  user_host="${USER}@%m "
fi
local current_dir='%F{11}%B$(collapsed_wd)%{$reset_color%}'
local git_line='$(git_status)'
local exit_status="%(?.%F{8}.%F{9})»%{$reset_color%}"

PROMPT="${user_host}${current_dir} ${git_line}
${exit_status} "

ITALIC=$'%{\x1b[3m%}'
local repo='$(git_origin)'
RPROMPT="${ITALIC}%F{8}${repo}%{$reset_color%}"

export NVM_DIR="/Users/jeffknaggs/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# For nicer diff highlighting
ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
