hex_to_true() {
  hex=$1
  r=$(printf "%d" 0x${hex:0:2})
  g=$(printf "%d" 0x${hex:2:2})
  b=$(printf "%d" 0x${hex:4:2})

  echo "%{\x1b[38;2;${r};${g};${b}m%}"
}

BOLD=$(echo "%{\x1b[1m%}")
ITALIC="%{\e[3m%}"
UNDERLINE="%{\e[4m%}"
RESET=$(echo "%{\x1b[0m%}")

DARK_GRAY=$(hex_to_true 75715e)
YELLOW=$(hex_to_true e6db74)
MAGENTA=$(hex_to_true f92a72)
GREEN=$(hex_to_true a6e22e)
CYAN=$(hex_to_true 66d9ef)
ORANGE=$(hex_to_true fd971f)
PINK=$(hex_to_true fd64d5)

INDENT_ICON="\uf0da"
CHECK_ICON="\uf00c"
ELLIPSIS_ICON="\uf141"
CMD_ICON="\uf471"

tit()     { echo "\n ${BOLD}$1${RESET}\n\n"; }
check()   { echo " ${DARK_GRAY}${INDENT_ICON} ${GREEN}${CHECK_ICON}\t${RESET}$1\n"; }
success() { echo " ${DARK_GRAY}${INDENT_ICON} ${GREEN}${CHECK_ICON}\t${RESET}$1\n"; }
info()    { echo " ${DARK_GRAY}${INDENT_ICON} ${CYAN}${ELLIPSIS_ICON}\t${RESET}$1\n"; }
cmd()     { echo " ${DARK_GRAY}${INDENT_ICON} ${CYAN}${CMD_ICON}\t${GREEN}${1}${RESET}\n"; }
