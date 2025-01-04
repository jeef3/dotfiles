current_dir() {
  typeset collapsed_dir=$(pwd | perl -pe '
    BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
    }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
  ')

  echo "${YELLOW}${BOLD}${collapsed_dir}${RESET}"
}
