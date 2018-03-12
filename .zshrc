# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
source $HOME/projects/dotfiles/lib/zsh-git-prompt/zshrc.sh
source $HOME/projects/dotfiles/lib/git-status.zsh

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
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Prompts

# Vi
# bindkey -v
# bindkey '^w' backward-kill-word

# function get-arrow {
#   local ARROW="\uE0B0"
#   echo "$ARROW"
# }

# function zle-line-init zle-keymap-select {
#   local ARROW='$(get-arrow)'
#   local ARROWS="%(?.%{$bg[green]%}.%{$bg[red]%})$ARROW%{$bg[black]%}%(?.%{$fg[green]%}.%{$fg[red]%})$ARROW%{$reset_color%}"
#   local EXIT_ARROW="%(?.%F{8}.%F{9})$ARROW%{$reset_color%}"

#   NORMAL_MODE="%{$bg[yellow]$fg_bold[black]%} N %{$fg[yellow]%}$ARROWS %{$reset_color%}"
#   INSERT_MODE="%{$bg[blue]$fg_bold[black]%} I %{$fg[blue]%}$ARROWS %{$reset_color%}"

#   RPS1="${${KEYMAP/vicmd/$NORMAL_MODE}/(main|viins)/$INSERT_MODE} $EPS1"

#   zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select

# export KEYTIMEOUT=1

git_status() {
  precmd_update_git_vars

  local SEPARATOR="%F{8}•%{${reset_color}%}"

  ZSH_THEME_GIT_PROMPT_BEHIND="\uf433"
  ZSH_THEME_GIT_PROMPT_AHEAD="\uf431"

  ZSH_THEME_GIT_PROMPT_STAGED="%F{3}\uf429"
  ZSH_THEME_GIT_PROMPT_CONFLICTS="%F{5}\uf421"
  ZSH_THEME_GIT_PROMPT_CHANGED="%F{2}\uf040"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{6}\u2026"
  ZSH_THEME_GIT_PROMPT_CLEAN="%F{2}\uf00c"

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
    echo "$STATUS"
  fi
}

# git_info() {
#   git rev-parse --is-inside-work-tree &> /dev/null || return

#   echo "%F{8}%Bon%{$reset_color%} $branch $gstatus"
# }

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

jobies() {
  list=$(jobs | cut -d " " -f 6 | tr '\n' ', ' | rev | cut -c 2- | rev)

  if [ -n "${list}" ]; then
    echo "%F{8}${ITALIC}$list%{$reset_color%} "
  else
    echo ''
  fi
}

local user_host=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  user_host="${USER}@%m "
fi

ITALIC=$'%{\x1b[3m%}'

local current_dir='%F{11}%B$(collapsed_wd)%{$reset_color%}'
local git_line='$(git_status)'
local exit_status="%(?.%F{8}.%F{9})❯%{$reset_color%}"
local job_list='$(jobies)'

PROMPT="${user_host}${current_dir} ${git_line}
${job_list}${exit_status} "

local repo='$(git_origin)'
RPROMPT="${ITALIC}%F{8}${repo}%{$reset_color%}"

# export NVM_DIR="/Users/jeffknaggs/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# For nicer diff highlighting
# ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
unalias imgcat # I'm using one installed from brew instead

source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# . `brew --prefix`/bin/aws_zsh_completer.sh
fpath=(/usr/local/share/zsh-completions $fpath)

export PATH="$HOME/.yarn/bin:$PATH"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh
