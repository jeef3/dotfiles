EXIT_STATUS_ICON="\uf0da"

exit_status() {
  echo "%(?.%F{8}.%F{9})${EXIT_STATUS_ICON}${RESET}"
}
