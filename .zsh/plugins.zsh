autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zinit light mafredri/zsh-async

deferred_plugins=(
  "Aloxaf/fzf-tab"
  "Freed-Wu/fzf-tab-source"
  "zsh-users/zsh-autosuggestions"
)

for p in "${deferred_plugins[@]}"; do
  zinit ice wait lucid; zinit light $p
done

zinit ice wait lucid atload"async_load_rprompt"
zinit light olivierverdier/zsh-git-prompt

# Syntax highlighting must be last
zinit ice wait lucid atload"
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9'
  ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[function]='fg=10'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=11'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=9,bold'
  ZSH_HIGHLIGHT_STYLES[comment]='fg=8,italic'
"
zinit light zsh-users/zsh-syntax-highlighting
