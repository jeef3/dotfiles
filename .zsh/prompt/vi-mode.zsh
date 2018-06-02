bindkey -v

INSERT_MODE="$DARK_GRAY❯"
CMD_MODE="$(hex_to_true 00dfff)❯"
VIM_MODE=$INSERT_MODE

zle-keymap-select() {
  VIM_MODE="${${KEYMAP/vicmd/${CMD_MODE}}/(main|viins)/${INSERT_MODE}}"
  zle reset-prompt
}

zle-line-finish() {
  VIM_MODE=$INSERT_MODE
}

zle -N zle-keymap-select
zle -N zle-line-finish

export KEYTIMEOUT=1
