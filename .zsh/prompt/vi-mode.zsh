bindkey -v

INSERT_MODE="%F{10}❯"
CMD_MODE="%F{9}❯"
VIM_MODE=$INSERT_MODE

zle-keymap-select() {
  VIM_MODE="${${KEYMAP/vicmd/${CMD_MODE}}/(main|viins)/${INSERT_MODE}}"

  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
      echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
      echo -ne '\e[3 q'
  fi

  zle reset-prompt
}

zle-line-finish() {
  VIM_MODE=$INSERT_MODE
}

zle -N zle-keymap-select
zle -N zle-line-finish

export KEYTIMEOUT=1
