BREW_HOME=$(brew --prefix)

# Good ol z
. $BREW_HOME/etc/profile.d/z.sh

# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load scripts
[[ -d "$HOME/.scripts" ]] && export PATH=$HOME/.scripts:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}

setopt hist_expire_dups_first

# Completion
zstyle ':completion:*' menu select

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# [[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
# [[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
# [[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh

source ~/.zsh/plugins.zsh
source ~/.zsh/prompt.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/jeffknaggs/projects/new-player/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/jeffknaggs/projects/new-player/node_modules/tabtab/.completions/slss.zsh

# Add Homebrew's sbin to PATH
export PATH="/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
