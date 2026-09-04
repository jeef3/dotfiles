#!/usr/bin/env zsh

# This test exercises the real animated spinner (FIFOs, background process,
# temp dir lifecycle), so force animation even when running under CI/GitHub
# Actions, where the spinner would otherwise auto-disable.
export SPINNER_FORCE=1

source "$(dirname "$0")/../setup/util.sh"
source "$(dirname "$0")/../setup/spinner.zsh"

title "Spinner Test"

# Test 1: Basic start/stop
info "Test 1" "start_spinner + stop_spinner"
start_spinner "Installing" "something cool…"
sleep 2
stop_spinner
success "Test 1" "basic start/stop"

# Test 2: Update spinner
info "Test 2" "update_spinner"
start_spinner "Tapping" "first item…"
sleep 1
update_spinner "Tapping" "second item…"
sleep 1
update_spinner "Tapping" "third item…"
sleep 1
stop_spinner
success "Test 2" "update spinner"

# Test 3: Verify temp file cleanup
info "Test 3" "temp file cleanup"
start_spinner "Cleanup test" "checking…"
SPINNER_DIR_CHECK="$SPINNER_DIR"
sleep 1
stop_spinner
if [ -d "$SPINNER_DIR_CHECK" ]; then
  fail "Test 3" "temp directory still exists: $SPINNER_DIR_CHECK"
else
  success "Test 3" "temp directory cleaned up"
fi

# Test 4: Rapid start/stop cycles
info "Test 4" "rapid start/stop cycles"
for i in 1 2 3; do
  start_spinner "Cycle $i" "running…"
  sleep 0.5
  stop_spinner
done
success "Test 4" "rapid cycles"

# Check no leftover temp dirs
leftover=$(find "${TMPDIR:-/tmp}" -maxdepth 1 -name "dotfiles-spinner.*" -type d 2>/dev/null)
if [ -n "$leftover" ]; then
  warn "Cleanup" "leftover temp dirs found: $leftover"
else
  success "Cleanup" "no leftover temp dirs"
fi

# Test 5: Plain (non-animated) mode, as used in CI
info "Test 5" "plain mode (SPINNER_DISABLE / CI detection)"
plain_output=$(
  unset SPINNER_FORCE
  export SPINNER_DISABLE=1
  source "$(dirname "$0")/../setup/spinner.zsh"
  start_spinner "Installing" "package one…"
  update_spinner "Installing" "package one…" # no change, shouldn't repeat
  update_spinner "Installing" "package two…"
  stop_spinner
)
plain_lines=$(printf '%s\n' "$plain_output" | grep -c '^  Installing')
if [[ "$plain_output" == *$'\e['* ]]; then
  fail "Test 5" "plain mode emitted animation escape codes"
elif [[ "$plain_lines" -ne 2 ]]; then
  fail "Test 5" "expected 2 plain progress lines, got $plain_lines"
else
  success "Test 5" "plain mode prints static, deduplicated progress lines"
fi

# Test 6: CI environment auto-disables animation
info "Test 6" "CI auto-detection"
ci_output=$(
  unset SPINNER_FORCE
  export CI=true
  source "$(dirname "$0")/../setup/spinner.zsh"
  echo "SPINNER_ANIMATE=$SPINNER_ANIMATE"
)
if [[ "$ci_output" == *"SPINNER_ANIMATE=0"* ]]; then
  success "Test 6" "CI=true auto-disables animation"
else
  fail "Test 6" "expected SPINNER_ANIMATE=0 under CI=true, got: $ci_output"
fi

title "All tests passed!"
