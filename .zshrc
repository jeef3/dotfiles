# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh
source $HOME/projects/dotfiles/lib/collapsed-wd.sh
source $HOME/projects/dotfiles/lib/jobbies.sh
source $HOME/projects/dotfiles/lib/git-line.sh

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

ITALIC=$'%{\x1b[3m%}'

local current_dir='%F{11}%B$(collapsed_wd)%{$reset_color%}'
local job_list='$(jobbies)'
local exit_status="%(?.%F{8}.%F{9})❯%{$reset_color%}"
PROMPT="${current_dir} ${job_list}${exit_status} "
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
