source ~/.zsh/plugins.sh

# Source dependencies
SOURCE=${(%):-%N}
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DOTFILES_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source $DOTFILES_DIR/lib/index.sh

# Plugin Config
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Good ol z
. `brew --prefix`/etc/profile.d/z.sh

# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load scripts
[[ -d "$HOME/.scripts" ]] && export PATH=$HOME/.scripts:$PATH

setopt PROMPT_SUBST
PROMPT='$(current_dir)$(jobbies)$(exit_status)${vim_mode}${RESET} '
RPROMPT='$(git_status)'

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
unalias imgcat # I'm using one installed from brew instead

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}

setopt hist_expire_dups_first

# Completion
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit
