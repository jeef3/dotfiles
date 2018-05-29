bindkey -v

fromhex(){
  hex=${1#"#"}
  r=$(printf '0x%0.2s' "$hex")
  g=$(printf '0x%0.2s' ${hex#??})
  b=$(printf '0x%0.2s' ${hex#????})

  printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 +
                   (g<75?0:(g-35)/40)*6     +
                   (b<75?0:(b-35)/40)       + 16 ))"
}

blue=$(fromhex 00DFFF)
yellow=$(fromhex DFFF00)

vim_ins_mode="%{$(tput setaf $yellow)%}❯%{$(tput sgr0)%}"
vim_cmd_mode="%{$(tput setaf $blue)%}❯%{$(tput sgr0)%}"
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
