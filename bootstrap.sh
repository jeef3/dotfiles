#!/usr/bin/env bash
# =============================================================================
# Dotfiles Bootstrap
# =============================================================================
# Designed to run via: curl -fsSL <url> | bash
# Safe to re-run — all steps are idempotent.
# =============================================================================

set -euo pipefail

# --- Colors ---
BOLD=$(tput bold)
DIM=$(tput setaf 7)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

DEFAULT_DIR="$HOME/projects/dotfiles"
TARGET_DIR="${1:-$DEFAULT_DIR}"

echo ""
echo "  ${BOLD}Dotfiles Bootstrap${RESET}"
echo "  ${DIM}─────────────────────────────────${RESET}"
echo ""
echo "  This will set up your machine and clone dotfiles to:"
echo "  📁 ${BOLD}$TARGET_DIR${RESET}"
echo ""
read -n 1 -p "  Would you like to continue? (y/n): " answer
echo ""

if [ "$answer" != "y" ]; then
  echo ""
  echo "  🛑 Stopping bootstrap"
  echo ""
  exit 0
fi

echo ""
echo "  ${BOLD}Bootstrapping...${RESET}"
echo ""

# --- Xcode CLI Tools ---
if xcode-select -p &>/dev/null; then
  echo "  ${GREEN}✓${RESET} ${BOLD}Xcode CLI Tools${RESET} ${DIM}— already installed${RESET}"
else
  echo "  ${BLUE}…${RESET} ${BOLD}Xcode CLI Tools${RESET} ${DIM}— installing (this may open a dialog)…${RESET}"
  xcode-select --install 2>/dev/null || true

  # Wait for installation to complete
  until xcode-select -p &>/dev/null; do
    sleep 5
  done

  echo "  ${GREEN}✓${RESET} ${BOLD}Xcode CLI Tools${RESET} ${DIM}— installed${RESET}"
fi

# --- Homebrew ---
if command -v brew &>/dev/null; then
  echo "  ${GREEN}✓${RESET} ${BOLD}Homebrew${RESET} ${DIM}— already installed${RESET}"
else
  echo "  ${BLUE}…${RESET} ${BOLD}Homebrew${RESET} ${DIM}— installing (sudo may be required)…${RESET}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "  ${GREEN}✓${RESET} ${BOLD}Homebrew${RESET} ${DIM}— installed${RESET}"
fi

# --- Git (Homebrew version) ---
if [ "$(which git)" != "/usr/bin/git" ]; then
  echo "  ${GREEN}✓${RESET} ${BOLD}Homebrew Git${RESET} ${DIM}— already installed${RESET}"
else
  echo "  ${BLUE}…${RESET} ${BOLD}Homebrew Git${RESET} ${DIM}— installing…${RESET}"
  brew install git --quiet

  echo "  ${GREEN}✓${RESET} ${BOLD}Homebrew Git${RESET} ${DIM}— installed${RESET}"
fi

# --- Clone dotfiles ---
if [ ! -d "$TARGET_DIR" ]; then
  echo "  ${BLUE}…${RESET} ${BOLD}Dotfiles${RESET} ${DIM}— cloning…${RESET}"
  git clone https://github.com/jeef3/dotfiles.git "$TARGET_DIR" 2>/dev/null

  echo "  ${GREEN}✓${RESET} ${BOLD}Dotfiles${RESET} ${DIM}— cloned${RESET}"
else
  echo "  ${GREEN}✓${RESET} ${BOLD}Dotfiles${RESET} ${DIM}— already exists${RESET}"
fi

# --- Git submodules ---
echo "  ${BLUE}…${RESET} ${BOLD}Git submodules${RESET} ${DIM}— updating…${RESET}"
(cd "$TARGET_DIR" && git submodule init 2>/dev/null && git submodule update --recursive 2>/dev/null)
echo "  ${GREEN}✓${RESET} ${BOLD}Git submodules${RESET} ${DIM}— updated${RESET}"

# --- Done ---
echo ""
echo "  ${BOLD}Next Steps${RESET}"
echo "  ${DIM}─────────────────────────────────${RESET}"
echo ""
echo "  Run the following command to continue:"
echo ""
echo "    ${BOLD}cd $TARGET_DIR && ./setup.sh${RESET}"
echo ""
echo "  ${DIM}─────────────────────────────────${RESET}"
