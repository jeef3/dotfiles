# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler brew heroku node npm fabric rake)

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
function git_branch_name() {
  branch=$(command git symbolic-ref HEAD --short 2> /dev/null) || \
  branch=$(command git branch --no-color | sed -n '/\* /s///p' 2> /dev/null) || return 0

  echo $branch
}

function git_status() {

}

function git_info() {
  git rev-parse --is-inside-work-tree &> /dev/null || return

  local branch="%{$fg[magenta]%}%B$(git_branch_name)%{$reset_color%}"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function git_origin() {
  git rev-parse --is-inside-work-tree &> /dev/null || return

  local url=$(git config --get remote.origin.url | sed -En 's/(https:\/\/|git@)[^:\/]+(:|\/)(.+)\.git/\3/p')
  echo $url
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[black]%}%Bon%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""

local user_host=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  user_host="${USER}@${HOSTNAME} "
fi
local current_dir="%{$fg[yellow]%}%B%~%{$reset_color%}"
local git_line='$(git_info)'

local exit_status="%(?.%{$fg_bold[black]%}$ .%{$fg_bold[red]%}$ ${reset_color})"
PROMPT="${user_host}${current_dir} ${git_line}
${exit_status}"

local repo='$(git_origin)'
RPROMPT="%{$fg[black]%}%B${repo}%{$reset_color%}"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias t='todo.sh'

export NVM_DIR="/Users/jeffknaggs/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# For nicer diff highlighting
ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
