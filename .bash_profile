# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# init z
. ~/tools/z/z.sh

# Turn on some more colors
export CLICOLOR=1

# Flex SDK
export PATH=$PATH:'/Library/Flex SDK/bin'

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Amazon AWS Keys
if [[ -f "$HOME/.amazon_keys" ]]; then
    source "$HOME/.amazon_keys";
fi

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
complete -W "NSGlobalDomain" defaults


# -----
# Find a new home for these?

# Git branch in prompt.
# parse_git_branch() {
#     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
# export PS1=" \w\[\033[1;32m\]\$(parse_git_branch)\[\033[00m\] $ "

# if [ -f ~/.git-prompt.sh ]; then
#   source ~/.git-prompt.sh
#   GIT_PS1_SHOWDIRTYSTATE=true
#   export PS1='\W $(__git_ps1 "(%s)") $ '
# fi

# Git completion
# if [ -f `brew --prefix`/etc/bash_completion ]; then
#     . `brew --prefix`/etc/bash_completion
# fi

# Git aliases
# alias modified='for a in $(ls); do git log --pretty=format:"%h%x09%an%x09%ar%x09%C(blue)$a%C(reset)" -1 -- "$a"; done'
