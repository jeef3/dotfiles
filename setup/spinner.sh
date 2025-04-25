function draw_spinner()
{
  local -a marks=("⠋⠁" "⠈⠙" " ⠹" " ⠸" " ⠼" "⠠⠴" "⠦⠄" "⠧ " "⠇ " "⠏ ")
  local i=0

  delay=${SPINNER_DELAY:-0.1}
  title=${1:-}
  description=${2:-}

  while :; do
    printf '%s\r' "  $(tput setab 4; tput setaf 15) ${marks[i++ % ${#marks[@]}]} $(tput sgr0) $(tput bold)${title}$(tput sgr0) $(tput setaf 7)${description}$(tput sgr0)"
    sleep "${delay}"
  done
}

function start_spinner()
{
  title=${1:-}
  description=${2:-}

  # Hide the cursor and disable input
  printf '\e[?25l'
  stty -echo -icanon

  draw_spinner "${title}" "${description}" &

  SPIN_PID=$!

  declare SPIN_PID

  trap stop_spinner $(seq 0 15)
}

function stop_spinner()
{
  if [[ "${SPIN_PID}" -gt 0 ]]; then
    kill -9 "${SPIN_PID}" > /dev/null 2>&1;
  fi
  SPIN_PID=0

  # Show the cursor and enable input
  printf '\e[?25h'
  stty echo icanon

  printf '\033[2K'
}

