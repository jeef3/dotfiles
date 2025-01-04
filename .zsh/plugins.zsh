autoload -Uz compinit bashcompinit
compinit
bashcompinit

zinit light mafredri/zsh-async

zinit light Aloxaf/fzf-tab
zinit light Freed-Wu/fzf-tab-source

zinit light zsh-users/zsh-autosuggestions
zinit light olivierverdier/zsh-git-prompt

# Syntax highlighting must be last
zinit light zsh-users/zsh-syntax-highlighting

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=10'

ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=11'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=9,bold'
ZSH_HIGHLIGHT_STYLES[comment]='fg=8,italic'
