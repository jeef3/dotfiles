jobbies() {
  list=$(jobs | cut -d " " -f 6 | tr '\n' ', ' | rev | cut -c 2- | rev)

  if [ -n "${list}" ]; then
    echo "%F{8}${ITALIC}($list)%{$reset_color%} "
  else
    echo ''
  fi
}
