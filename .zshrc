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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load scripts
[[ -d "$HOME/.scripts" ]] && export PATH=$HOME/.scripts:$PATH

# init z
. ~/tools/z/z.sh

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Prompts
function git_branch_name() {
  branch=$(command git symbolic-ref HEAD --short 2> /dev/null) || \
  branch=$(command git branch | sed -n '/\* /s///p' 2> /dev/null) || return 0

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
  
  local url="$(git config --get remote.origin.url)"
  url=${url#*:}
  url=${url%\.git}

  echo $url
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[black]%}%Bon%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""

local user_host=""
local current_dir="%{$fg[yellow]%}%B%~%{$reset_color%}"
local git_line='$(git_info)'

PROMPT="%{$fg[black]%}%B╭─%{$reset_color%} ${current_dir} ${git_line}
%{$fg[black]%}%B╰●%{$reset_color%} "

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
