# Customisable spinner appearance
SPINNER_FRAMES=("⠋⠁" "⠈⠙" " ⠹" " ⠸" " ⠼" "⠠⠴" "⠦⠄" "⠧ " "⠇ " "⠏ ")
SPINNER_DELAY=${SPINNER_DELAY:-0.1}
SPINNER_BG="${BG_BLUE}"
SPINNER_FG="${FG_BRIGHT_WHITE}"
SPINNER_TITLE_STYLE="${BOLD}"
SPINNER_DESC_STYLE="${FG_WHITE}"

# Internal state
SPINNER_DIR=""
TITLE_PIPE=""
DESCRIPTION_PIPE=""
SPIN_PID=0

function draw_spinner()
{
  local i=0

  local title=""
  local description=""
  local previous_title=""
  local previous_description=""

  while :; do
    # Non-blocking read for title/description updates
    if read -t 0.01 -u 3 line; then
      title="$line"
    fi

    if read -t 0.01 -u 4 line; then
      description="$line"
    fi

    if [[ "$title" != "$previous_title" || "$description" != "$previous_description" ]]; then
      printf '\033[2K\r'  # Clear the line

      previous_title="$title"
      previous_description="$description"

    fi

    printf '%s\r' "  ${SPINNER_BG}${SPINNER_FG} ${SPINNER_FRAMES[i++ % ${#SPINNER_FRAMES[@]}]} ${SGR0} ${SPINNER_TITLE_STYLE}${title}${SGR0} ${SPINNER_DESC_STYLE}${description}${SGR0}"

    sleep "${SPINNER_DELAY}"
  done

  exec 3>&-
  exec 4>&-
}

function start_spinner()
{
  SPINNER_DIR=$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-spinner.XXXXXX")
  TITLE_PIPE="$SPINNER_DIR/title.pipe"
  DESCRIPTION_PIPE="$SPINNER_DIR/description.pipe"

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

  trap stop_spinner EXIT INT TERM HUP
}

function update_spinner() {
  echo "$1" > "$TITLE_PIPE"
  echo "$2" > "$DESCRIPTION_PIPE"
}

function stop_spinner()
{
  if [[ "${SPIN_PID}" -gt 0 ]]; then
    kill -TERM "${SPIN_PID}" > /dev/null 2>&1
    wait "${SPIN_PID}" 2>/dev/null
  fi
  SPIN_PID=0

  # Show the cursor and enable input
  printf '\e[?25h'
  stty echo icanon

  printf '\033[2K'

  rm -rf "$SPINNER_DIR"
}
