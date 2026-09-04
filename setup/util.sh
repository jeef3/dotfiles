if [ -n "${BASH_SOURCE:-}" ]; then
  util_file="${BASH_SOURCE[0]}"
else
  util_file="${(%):-%N}"
fi

source "$(dirname "$util_file")/colors.sh"

title() { printf "${SGR0}\n  ${BOLD}${UNDERLINE}${FG_BRIGHT_WHITE}$1${SGR0}\n\n"; }

success() { printf "${SGR0}  ${BOLD}${FG_GREEN} OK ${SGR0} ${BOLD}$1 ${SGR0}${FG_WHITE}${2:-}\n"; }
warn() { printf "${SGR0}  ${BOLD}${FG_YELLOW}   ${SGR0} ${BOLD}$1 ${SGR0}${FG_WHITE}${2:-}\n"; }
fail() { printf "${SGR0}  ${BOLD}${FG_RED}  ${SGR0} ${BOLD}$1 ${SGR0}${FG_WHITE}${2:-}\n"; }
info() { printf "${SGR0}  ${BOLD}${FG_BLUE} 󱩖  ${SGR0} ${BOLD}$1 ${SGR0}${FG_WHITE}${2:-}\n"; }
skip() { printf "${SGR0}  ${BOLD}${FG_BLUE} 󰑎  ${SGR0} ${BOLD}$1 ${SGR0}${FG_WHITE}${2:-}\n"; }

quote() { printf "  ${FG_WHITE}│${SGR0}${ITALIC}${FG_WHITE} $1\n"; }

cmd() { printf "${SGR0}  ${FG_BRIGHT_BLACK}›  ${FG_BRIGHT_CYAN} \t${SGR0}${BOLD}$1${SGR0}\n"; }
