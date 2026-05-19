#!/usr/bin/env bash
# =============================================================================
# Theme Generator
# =============================================================================
# Reads palette.sh and generates:
#   1. .config/nvim/lua/theme/palette.lua  (lua color table)
#   2. Updates .config/ghostty/config       (palette lines)
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
PALETTE_FILE="$SCRIPT_DIR/palette.sh"

# Source the palette to resolve variables
source "$PALETTE_FILE"

# --- Generate Lua palette ---

generate_lua() {
  local outdir="$DOTFILES_DIR/.config/nvim/lua/theme"
  local outfile="$outdir/palette.lua"
  mkdir -p "$outdir"

  cat >"$outfile" <<'HEADER'
-- =============================================================================
-- ⚠️  DO NOT EDIT — generated from theme/palette.sh
-- =============================================================================

local M = {}

HEADER

  # Parse palette.sh for color assignments (skip comments, PALETTE_* mappings)
  while IFS= read -r line; do
    # Skip comments, empty lines, and PALETTE_ mappings
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ "$line" =~ ^[[:space:]]*$ ]] && continue
    [[ "$line" =~ ^PALETTE_ ]] && continue

    # Match VAR="value" patterns
    if [[ "$line" =~ ^([A-Z_][A-Z_0-9]*)=\"([^\"]+)\" ]]; then
      local name="${BASH_REMATCH[1]}"
      local value="${BASH_REMATCH[2]}"

      # Resolve variable references like $SILVER_700
      if [[ "$value" =~ ^\$ ]]; then
        local ref="${value#\$}"
        value="${!ref}"
      fi

      # Convert to lowercase for lua (SILVER_100 → silver_100)
      local lua_name="${name,,}"
      echo "M.$lua_name = \"$value\"" >>"$outfile"
    fi
  done <"$PALETTE_FILE"

  # Add palette mapping table using variable references
  echo "" >>"$outfile"
  echo "-- Terminal palette mapping (0-15)" >>"$outfile"
  echo "M.palette = {" >>"$outfile"

  while IFS= read -r line; do
    if [[ "$line" =~ ^PALETTE_([0-9]+|FG|BG)=\"\$([A-Z_0-9]+)\" ]]; then
      local slot="${BASH_REMATCH[1]}"
      local ref="${BASH_REMATCH[2],,}" # lowercase

      case "$slot" in
      FG) printf '  fg   = M.%s,\n' "$ref" >>"$outfile" ;;
      BG) printf '  bg   = M.%s,\n' "$ref" >>"$outfile" ;;
      *) printf '  [%s]%s= M.%s,\n' "$slot" "$(printf '%*s' $((3 - ${#slot})) '')" "$ref" >>"$outfile" ;;
      esac
    fi
  done <"$PALETTE_FILE"

  echo "}" >>"$outfile"
  echo "" >>"$outfile"
  echo "return M" >>"$outfile"

  echo "  ✓ Generated $outfile"
}

# --- Generate Ghostty palette ---

generate_ghostty() {
  local config="$DOTFILES_DIR/.config/ghostty/config"

  if [[ ! -f "$config" ]]; then
    echo "  ✗ Ghostty config not found: $config"
    return 1
  fi

  # Remove existing palette/bg/fg lines, header comment, and cleanup extra blank lines
  local tmp
  tmp=$(mktemp)
  grep -v -E '^(palette|background|foreground) = |^# =+$|^# .* (generated from|DO NOT EDIT)' "$config" | sed '/^$/N;/^\n$/d' > "$tmp"

  # Rebuild config: existing settings + palette block appended at bottom
  {
    cat "$tmp"
    cat <<EOF

# =============================================================================
# ⚠️  DO NOT EDIT BELOW — generated from theme/palette.sh
# =============================================================================
background = ${PALETTE_BG}
foreground = ${PALETTE_FG}

palette = 0=${PALETTE_0}
palette = 1=${PALETTE_1}
palette = 2=${PALETTE_2}
palette = 3=${PALETTE_3}
palette = 4=${PALETTE_4}
palette = 5=${PALETTE_5}
palette = 6=${PALETTE_6}
palette = 7=${PALETTE_7}

palette = 8=${PALETTE_8}
palette = 9=${PALETTE_9}
palette = 10=${PALETTE_10}
palette = 11=${PALETTE_11}
palette = 12=${PALETTE_12}
palette = 13=${PALETTE_13}
palette = 14=${PALETTE_14}
palette = 15=${PALETTE_15}
EOF
  } >"$config"

  rm "$tmp"
  echo "  ✓ Updated $config"
}

# --- Main ---

echo "Generating theme from $PALETTE_FILE"
echo ""

case "${1:-all}" in
lua | nvim)
  generate_lua
  ;;
ghostty)
  generate_ghostty
  ;;
all)
  generate_lua
  generate_ghostty
  ;;
*)
  echo "Usage: $0 [all|lua|ghostty]"
  exit 1
  ;;
esac

echo ""
echo "Done!"
