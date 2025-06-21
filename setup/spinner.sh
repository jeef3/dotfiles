TITLE_PIPE="/tmp/title.pipe"
DESCRIPTION_PIPE="/tmp/description.pipe"

function draw_spinner()
{
  local -a marks=("⠋⠁" "⠈⠙" " ⠹" " ⠸" " ⠼" "⠠⠴" "⠦⠄" "⠧ " "⠇ " "⠏ ")
  local i=0

  local title=""
  local description=""
  local previous_title=""
  local previous_description=""

  delay=${SPINNER_DELAY:-0.1}


  while :; do
    # Check for data in TITLE_PIPE
    if read -u 3 line; then
      title="$line"
    fi

    # Check for data in DESCRIPTION_PIPE
    if read -u 4 line; then
      description="$line"
    fi

    if [[ "$title" != "$previous_title" || "$description" != "$previous_description" ]]; then
      printf '\033[2K\r'  # Clear the line

      previous_title="$title"
      previous_description="$description"

    fi

    printf '%s\r' "  $(tput setab 4; tput setaf 15) ${marks[i++ % ${#marks[@]}]} $(tput sgr0) $(tput bold)${title}$(tput sgr0) $(tput setaf 7)${description}$(tput sgr0)"

    sleep "${delay}"

    echo "$title" > "$TITLE_PIPE"
    echo "$description" > "$DESCRIPTION_PIPE"
  done

  exec 3>&-
  exec 4>&-
}

function start_spinner()
{

  if [ -p "$TITLE_PIPE" ] || [ -f "$TITLE_PIPE" ]; then
    rm "$TITLE_PIPE" "$DESCRIPTION_PIPE"
  fi

  mkfifo "$TITLE_PIPE" "$DESCRIPTION_PIPE"

  exec 3<> "$TITLE_PIPE"
  exec 4<> "$DESCRIPTION_PIPE"

  echo "$1" > "$TITLE_PIPE"
  echo "$2" > "$DESCRIPTION_PIPE"

  # Hide the cursor and disable input
  printf '\e[?25l'
  stty -echo -icanon

  draw_spinner &

  SPIN_PID=$!

  declare SPIN_PID

  trap stop_spinner $(seq 0 15)
}

function update_spinner()
{
  if read -u 3 line; then
    title="$line"
  fi

  if read -u 4 line; then
    description="$line"
  fi

  echo "$1" > "$TITLE_PIPE"
  echo "$2" > "$DESCRIPTION_PIPE"
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

  rm -f $TITLE_PIPE $DESCRIPTION_PIPE
}

