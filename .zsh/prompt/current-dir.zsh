FOLDER_ICON="\uf07c"
ARROW="\ue0b0"
ANGLE="\ue0b0"

START_SEGMENT=$(hex_to_true 999999 555555)
END_SEGMENT=$(hex_to_true 555555 444444)
TAIL=$(hex_to_true 444444 000000)

FOLDER="${START_SEGMENT} ${FOLDER_ICON} ${RESET}${END_SEGMENT}${ANGLE}${RESET}${TAIL}${ANGLE} "

current_dir() {
  typeset collapsed_dir=$(pwd | perl -pe '
    BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
    }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
  ')

  echo "${FOLDER}${YELLOW}${BOLD}${collapsed_dir}${RESET}"
}
