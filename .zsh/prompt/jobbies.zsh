jobbies() {
  typeset list=$(jobs | cut -d " " -f 6 | tr '\n' ', ' | rev | cut -c 2- | rev)

  if [ -n "${list}" ]; then
    echo " ${DARK_GRAY}${ITALIC}($list)%{$RESET%} "
  else
    echo ' '
  fi
}
