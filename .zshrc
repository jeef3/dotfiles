# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=~/bin:/usr/local/sbin:/usr/local/bin:$PATH

. `brew --prefix`/etc/profile.d/z.sh

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
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
git_branch_name() {
  branch=$(command git symbolic-ref HEAD --short 2> /dev/null) || \
  branch=$(command git branch --no-color | sed -n '/\* /s///p' 2> /dev/null) || return 0

  echo $branch
}

git_status() {

}

git_info() {
  git rev-parse --is-inside-work-tree &> /dev/null || return

  local branch="%F{13}\uE0A0 %B$(git_branch_name)%{$reset_color%}"
  echo "%F{8}%Bon%{$reset_color%} $branch"
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
  user_host="${USER}@${HOSTNAME} "
fi
local current_dir='%F{11}%B$(collapsed_wd)%{$reset_color%}'
local git_line='$(git_info)'
local exit_status="%(?.%F{8}.%F{9})»%{$reset_color%}"

PROMPT=" ${user_host}${current_dir} ${git_line}
${exit_status} "

local repo='$(git_origin)'
RPROMPT="%F{8}%B${repo}%{$reset_color%}"

alias t='todo.sh'

export NVM_DIR="/Users/jeffknaggs/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# For nicer diff highlighting
ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
