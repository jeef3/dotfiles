# Customisable spinner appearance
SPINNER_FRAMES=("⠋⠁" "⠈⠙" " ⠹" " ⠸" " ⠼" "⠠⠴" "⠦⠄" "⠧ " "⠇ " "⠏ ")
SPINNER_DELAY=${SPINNER_DELAY:-0.1}
SPINNER_BG=""
SPINNER_FG="${FG_BLUE}"
SPINNER_TITLE_STYLE="${BOLD}"
SPINNER_DESC_STYLE="${FG_WHITE}"

# Whether to animate. Animating in a non-interactive log (e.g. GitHub
# Actions) just produces unreadable escape-code noise, so fall back to plain
# progress lines there. SPINNER_DISABLE=1 / SPINNER_FORCE=1 override detection.
function _spinner_should_animate() {
  if [[ -n "${SPINNER_FORCE:-}" ]]; then
    return 0
  fi
  if [[ -n "${SPINNER_DISABLE:-}" ]]; then
    return 1
  fi
  if [[ -n "${CI:-}" || -n "${GITHUB_ACTIONS:-}" ]]; then
    return 1
  fi
  if [[ ! -t 1 ]]; then
    return 1
  fi
  return 0
}

typeset -g SPINNER_ANIMATE=1
if ! _spinner_should_animate; then
  SPINNER_ANIMATE=0
fi

# Internal state
SPINNER_DIR=""
TITLE_PIPE=""
DESCRIPTION_PIPE=""
SPIN_PID=0
PLAIN_TITLE=""
PLAIN_DESCRIPTION=""

function draw_spinner() {
  trap - EXIT
  trap - INT
  trap - TERM
  trap - HUP

  local i=1

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
      printf '\033[2K\r' # Clear the line

      previous_title="$title"
      previous_description="$description"

    fi

    printf '%s\r' "  ${SPINNER_BG}${SPINNER_FG} ${SPINNER_FRAMES[i]} ${SGR0} ${SPINNER_TITLE_STYLE}${title}${SGR0} ${SPINNER_DESC_STYLE}${description}${SGR0}"
    i=$((i % ${#SPINNER_FRAMES[@]} + 1))

    sleep "${SPINNER_DELAY}"
  done

  exec 3>&-
  exec 4>&-
}

function _plain_spinner_line() {
  printf '  %s %s\n' "$1" "$2"
}

function start_spinner() {
  if [[ "$SPINNER_ANIMATE" -eq 0 ]]; then
    PLAIN_TITLE="$1"
    PLAIN_DESCRIPTION="$2"
    _plain_spinner_line "$PLAIN_TITLE" "$PLAIN_DESCRIPTION"
    return
  fi

  SPINNER_DIR=$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-spinner.XXXXXX")
  TITLE_PIPE="$SPINNER_DIR/title.pipe"
  DESCRIPTION_PIPE="$SPINNER_DIR/description.pipe"

  mkfifo "$TITLE_PIPE" "$DESCRIPTION_PIPE"

  exec 3<>"$TITLE_PIPE"
  exec 4<>"$DESCRIPTION_PIPE"

  echo "$1" >"$TITLE_PIPE"
  echo "$2" >"$DESCRIPTION_PIPE"

  # Hide the cursor and disable input
  printf '\e[?25l'
  if [[ -t 0 ]]; then
    stty -echo -icanon
  fi

  draw_spinner &

  SPIN_PID=$!

  trap 'stop_spinner' INT TERM HUP
}

function update_spinner() {
  if [[ "$SPINNER_ANIMATE" -eq 0 ]]; then
    if [[ "$1" != "$PLAIN_TITLE" || "$2" != "$PLAIN_DESCRIPTION" ]]; then
      PLAIN_TITLE="$1"
      PLAIN_DESCRIPTION="$2"
      _plain_spinner_line "$PLAIN_TITLE" "$PLAIN_DESCRIPTION"
    fi
    return
  fi

  echo "$1" >"$TITLE_PIPE"
  echo "$2" >"$DESCRIPTION_PIPE"
}

function stop_spinner() {
  if [[ "$SPINNER_ANIMATE" -eq 0 ]]; then
    PLAIN_TITLE=""
    PLAIN_DESCRIPTION=""
    return
  fi

  if [[ "${SPIN_PID}" -gt 0 ]]; then
    kill -TERM "${SPIN_PID}" >/dev/null 2>&1
    wait "${SPIN_PID}" 2>/dev/null
  fi
  SPIN_PID=0

  # Show the cursor and enable input
  printf '\e[?25h'
  if [[ -t 0 ]]; then
    stty echo icanon
  fi

  printf '\033[2K'

  rm -rf "$SPINNER_DIR"
}
