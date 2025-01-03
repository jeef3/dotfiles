autoload -Uz compinit bashcompinit
compinit
bashcompinit

zinit light mafredri/zsh-async
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light olivierverdier/zsh-git-prompt

# Syntax highlighting must be last
zinit light zsh-users/zsh-syntax-highlighting

ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[value]='fg=green,bold'
