FOLDER_ICON="\uf07c"

START_SEGMENT=$(hex_to_true 999999)

FOLDER="${START_SEGMENT} ${FOLDER_ICON} ${RESET} "

the_dir() {
  typeset collapsed_dir=$(pwd | perl -pe '
    BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
    }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
  ')

  echo "$collapsed_dir"
}

current_dir() {
  typeset collapsed_dir=$(pwd | perl -pe '
    BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
    }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
  ')

  if [ $(tput cols) -gt 54 ]; then
    echo "${FOLDER}${RESET}${YELLOW}${BOLD}${collapsed_dir}${RESET}"
  fi
}
