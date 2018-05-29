hex_to_true() {
  hex=$1
  r=$(printf "%d" 0x${hex:0:2})
  g=$(printf "%d" 0x${hex:2:2})
  b=$(printf "%d" 0x${hex:4:2})

  echo "%{\x1b[38;2;${r};${g};${b}m%}"
}

BOLD="%{\e[1m%}"
ITALIC="%{\e[3m%}"
UNDERLINE="%{\e[4m%}"
RESET="%{\e[0m%}"

DARK_GRAY=$(hex_to_true 75715e)
YELLOW=$(hex_to_true e6db74)
MAGENTA=$(hex_to_true f92a72)
GREEN=$(hex_to_true a6e22e)
CYAN=$(hex_to_true 66d9ef)
ORANGE=$(hex_to_true fd971f)
