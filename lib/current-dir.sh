collapsed_wd() {
  echo $(pwd | perl -pe '
    BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
    }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
  ')
}

current_dir() {
  echo "$YELLOW$BOLD$(collapsed_wd)$RESET"
}
