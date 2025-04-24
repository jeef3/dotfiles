title() { printf "$(tput sgr0)\n  $(tput bold; tput smul)$1$(tput sgr0)\n\n"; }

success() { printf "$(tput sgr0)  $(tput bold; tput setab 2; tput setaf 15) OK $(tput sgr0) $(tput bold)$1 $(tput sgr0; tput setaf 7)$2\n"; }
warn() { printf "$(tput sgr0)  $(tput bold; tput setab 3; tput setaf 15)   $(tput sgr0) $(tput bold)$1 $(tput srg0; tput setaf 7)$2\n"; }
fail() { printf "$(tput sgr0)  $(tput bold; tput setab 1; tput setaf 15)  $(tput sgr0) $(tput bold)$1 $(tput sgr0; tput setaf 7)$2\n"; }
info() { printf "$(tput sgr0)  $(tput bold; tput setab 4; tput setaf 15) 󱩖  $(tput sgr0) $(tput bold)$1 $(tput sgr0; tput setaf 7)$2\n"; }
skip() { printf "$(tput sgr0)  $(tput bold; tput setab 4; tput setaf 15) 󰑎  $(tput sgr0) $(tput bold)$1 $(tput sgr0; tput setaf 7)$2\n"; }

quote() { printf "  $(tput setaf 8)│$(tput sgr0) $1\n"; }

cmd() { printf "$(tput sgr0)  $(tput setaf 8)›  $(tput setaf 14) \t$(tput bold)$(tput setaf 8)$1$(tput sgr0)\n"; }
