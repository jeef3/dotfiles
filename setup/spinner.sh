function draw_spinner()
{
  local -a marks=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local i=0

  delay=${SPINNER_DELAY:-0.1}
  message=${1:-}

  while :; do
    printf '%s\r' "  $(tput setab 12; tput setaf 15) ${marks[i++ % ${#marks[@]}]}  $(tput sgr0) ${message}"
    sleep "${delay}"
  done
}

function start_spinner()
{
  message=${1:-}

  draw_spinner "${message}" &

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
  printf '\033[2K'
}
