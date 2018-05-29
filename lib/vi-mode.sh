bindkey -v

vim_ins_mode="$DARK_GRAY❯"
vim_cmd_mode="$(hex_to_true 00dfff)❯"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

export KEYTIMEOUT=1
