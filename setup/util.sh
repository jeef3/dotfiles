title() { printf "$(tput sgr0)\n $(tput bold)$1$(tput sgr0)\n\n"; }

success() { printf "$(tput sgr0)  $(tput bold; tput setab 10; tput setaf 15)   $(tput setab 0; tput setaf 8) $(tput sgr0)$1\n"; }
warn() { printf "$(tput sgr0)  $(tput bold; tput setab 8; tput setaf 15)   $(tput setab 0; tput setaf 8) $(tput sgr0)$1\n"; }
warn() { printf "$(tput sgr0)  $(tput setaf 8)[ $(tput setaf 3)!$(tput setaf 8) ] $(tput setaf 3)$1\n"; }
fail() { printf "$(tput sgr0)  $(tput setaf 8)[ $(tput setaf 1)$(tput setaf 8) ] $(tput sgr0)$1\n"; }
info() { printf "$(tput sgr0)  $(tput bold; tput setab 12; tput setaf 15)   $(tput setab 0; tput setaf 8) $(tput sgr0)$1\n"; }
skip() { printf "$(tput sgr0)  $(tput setaf 8)[ $(tput setaf 12)•$(tput setaf 8) ] $(tput sgr0)$1\n"; }

cmd() { printf "$(tput sgr0)  $(tput setaf 8)›  $(tput setaf 14) \t$(tput bold)$(tput setaf 8)$1$(tput sgr0)\n"; }
