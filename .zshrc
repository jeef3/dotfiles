# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
source $HOME/projects/dotfiles/lib/collapsed-wd.sh
source $HOME/projects/dotfiles/lib/jobbies.sh
source $HOME/projects/dotfiles/lib/git-line.sh
source $HOME/projects/dotfiles/lib/vi-mode.sh

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

ITALIC=$'%{\x1b[3m%}'

local current_dir="%F{11}%B$(collapsed_wd)%{$reset_color%}"
local exit_status="%(?.%F{8}.%F{9})⇢ %{$reset_color%}"
PROMPT='${current_dir} $(jobbies)${exit_status}${vim_mode} '
RPROMPT='$(git_status)'

# For nicer diff highlighting
# ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
unalias imgcat # I'm using one installed from brew instead

source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source `brew --prefix`/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
