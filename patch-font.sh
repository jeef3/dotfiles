#!/bin/sh

set -e

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }
fail() { printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"; exit; }

NERD_FONT_PATH="$HOME/.tmp/nerd-fonts"
FONT_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Fonts/OperatorMono"

if [ -e "$NERD_FONT_PATH" ]; then
  info "Nerd Fonts already downloaded, updating..."
  cd $NERD_FONT_PATH && git pull
else
  info "Nerd Fonts not found, cloning..."
  # mkdir -p .tmp
  git clone git@github.com:ryanoasis/nerd-fonts.git $NERD_FONT_PATH
fi

success "Nerd Fonts up-to-date"
info "Patching font..."

fonts=(
  OperatorMono-Book
  OperatorMono-BookItalic
  OperatorMono-Bold
  OperatorMono-BoldItalic
)

cd $NERD_FONT_PATH

for font in ${fonts[@]}
do
  info "Patch and install ${font}"

  ./font-patcher "$FONT_PATH/${font}.otf" \
    --mono \
    --complete \
    --out "$HOME/Desktop"

  success "${font} patched and moved to your Desktop"
done

success "All font patched and moved to your Desktop. Just move them into FontBook."
