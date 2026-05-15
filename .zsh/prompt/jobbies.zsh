jobbies() {
  typeset list=$(jobs -s 2>/dev/null | awk '{print $NF}' | tr '\n' ', ' | sed 's/,$//')

  if [ -n "${list}" ]; then
    echo " ${BRIGHT_BLACK}${ITALIC}($list)%{$RESET%} "
  else
    echo ' '
  fi
}
