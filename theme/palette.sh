# =============================================================================
# Princess Color Palette
# =============================================================================
#
# Based on Tinacious Design
# https://github.com/tinacious/vscode-tinacious-design-syntax
#
# Run `make all` to regenerate downstream configs after editing.
# =============================================================================

# --- Silver (neutral) scale ---
SILVER_100="#ffffff"
SILVER_200="#d9d8ea"
SILVER_300="#b4b3ce"
SILVER_400="#8f8fa8"
SILVER_500="#6c6c82"
SILVER_600="#4b4b5a"
SILVER_700="#2d2d35"
SILVER_800="#25252b"
SILVER_900="#1d1d23"

# --- Pink ---
PINK_100="#ffeff9"
PINK_200="#ffcbdf"
PINK_300="#ffa1c7"
PINK_400="#ff72b0"
PINK_500="#ff3399"
PINK_600="#c62f78"
PINK_700="#912858"
PINK_800="#5e203b"
PINK_900="#30151f"

# --- Blue ---
BLUE_100="#ebf8ff"
BLUE_200="#c9e9ff"
BLUE_300="#a1dbff"
BLUE_400="#70cdff"
BLUE_500="#00bfff"
BLUE_600="#1e93c3"
BLUE_700="#22698a"
BLUE_800="#1e4256"
BLUE_900="#131f26"

# --- Turquoise ---
TURQUOISE_100="#e8fafa"
TURQUOISE_200="#c4efef"
TURQUOISE_300="#9be4e5"
TURQUOISE_400="#6ad9db"
TURQUOISE_500="#00ced1"
TURQUOISE_600="#1c9ea0"
TURQUOISE_700="#207172"
TURQUOISE_800="#1c4647"
TURQUOISE_900="#122020"

# --- Green ---
GREEN_100="#e7fcea"
GREEN_200="#c3f2ca"
GREEN_300="#98e8a8"
GREEN_400="#67de86"
GREEN_500="#00d364"
GREEN_600="#1aa24f"
GREEN_700="#1e743a"
GREEN_800="#1b4827"
GREEN_900="#112114"

# --- Purple ---
PURPLE_100="#fff1ff"
PURPLE_200="#f3d2ff"
PURPLE_300="#e8afff"
PURPLE_400="#db8cff"
PURPLE_500="#cc66ff"
PURPLE_600="#9f52c5"
PURPLE_700="#743e8e"
PURPLE_800="#4b2b5b"
PURPLE_900="#26182c"

# --- Orange ---
ORANGE_100="#fff5e1"
ORANGE_200="#ffeac2"
ORANGE_300="#ffe0a4"
ORANGE_400="#ffd686"
ORANGE_500="#ffcc66"
ORANGE_600="#c29c50"
ORANGE_700="#886e3b"
ORANGE_800="#534327"
ORANGE_900="#231d12"

# =============================================================================
# Terminal Palette Mapping (16 colors)
# =============================================================================
# These map palette slots 0-15 to specific hex values from the scales above.
# Used by the generator to produce Ghostty config.
#
# Slot    Name              Value
# ----    ----              -----
PALETTE_0="$SILVER_700"     # black
PALETTE_1="$PINK_500"       # red
PALETTE_2="$GREEN_500"      # green
PALETTE_3="$ORANGE_500"     # yellow
PALETTE_4="$BLUE_500"       # blue
PALETTE_5="$PURPLE_500"     # magenta
PALETTE_6="$TURQUOISE_500"  # cyan
PALETTE_7="$SILVER_300"     # white (light gray)
PALETTE_8="$SILVER_500"     # bright black (dark gray)
PALETTE_9="$PINK_400"       # bright red
PALETTE_10="$GREEN_400"     # bright green
PALETTE_11="$ORANGE_400"    # bright yellow
PALETTE_12="$BLUE_400"      # bright blue
PALETTE_13="$PURPLE_400"    # bright magenta
PALETTE_14="$TURQUOISE_400" # bright cyan
PALETTE_15="$SILVER_100"    # bright white
PALETTE_FG="$SILVER_100"    # foreground
PALETTE_BG="$SILVER_900"    # background
