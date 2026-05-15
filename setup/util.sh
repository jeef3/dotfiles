source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

title() { printf "${SGR0}\n  ${BOLD}${UNDERLINE}$1${SGR0}\n\n"; }

success() { printf "${SGR0}  ${BOLD}${BG_GREEN}${FG_WHITE} OK ${SGR0} ${BOLD}$1 ${SGR0}${FG_GRAY}$2\n"; }
warn() { printf "${SGR0}  ${BOLD}${BG_YELLOW}${FG_WHITE}   ${SGR0} ${BOLD}$1 ${SGR0}${FG_GRAY}$2\n"; }
fail() { printf "${SGR0}  ${BOLD}${BG_RED}${FG_WHITE}  ${SGR0} ${BOLD}$1 ${SGR0}${FG_GRAY}$2\n"; }
info() { printf "${SGR0}  ${BOLD}${BG_BLUE}${FG_WHITE} 󱩖  ${SGR0} ${BOLD}$1 ${SGR0}${FG_GRAY}$2\n"; }
skip() { printf "${SGR0}  ${BOLD}${BG_BLUE}${FG_WHITE} 󰑎  ${SGR0} ${BOLD}$1 ${SGR0}${FG_GRAY}$2\n"; }

quote() { printf "  ${FG_DARK_GRAY}│${SGR0} $1\n"; }

cmd() { printf "${SGR0}  ${FG_DARK_GRAY}›  ${FG_CYAN} \t${BOLD}${FG_DARK_GRAY}$1${SGR0}\n"; }
