#!/bin/sh

set -e

info() { printf "  [ \033[00;34m..\033[0m ] $1\n"; }
success() { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }
fail() { printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"; exit; }

NERD_FONT_PATH="$HOME/.tmp/nerd-fonts"
OPERATOR_MONO_LIG_PATH="$HOME/.tmp/operator-mono-lig"

FONT_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Fonts/OperatorMono For Patch"

if [ -e "$NERD_FONT_PATH" ]; then
  info "Nerd Fonts already downloaded, updating..."
  cd $NERD_FONT_PATH && git pull
else
  info "Nerd Fonts not found, cloning..."
  # mkdir -p .tmp
  git clone --depth=1 git@github.com:ryanoasis/nerd-fonts.git $NERD_FONT_PATH
fi

if [ -e "$OPERATOR_MONO_LIG_PATH" ]; then
  info "Operator Mono Lig already downloaded, updating..."
  cd $OPERATOR_MONO_LIG_PATH&& git pull
else
  info "Operator Mono Lig not found, cloning..."
  git clone --depth=1 git@github.com:kiliman/operator-mono-lig.git $OPERATOR_MONO_LIG_PATH

  cd $OPERATOR_MONO_LIG_PATH
  npm install
fi

success "Nerd Fonts and Operator Mono Lig up-to-date"

fonts=(
  OperatorMono-Book
  OperatorMono-BookItalic
  OperatorMonoSSm-Bold
  OperatorMonoSSm-BoldItalic
)

info "Adding ligatures"
cd "$FONT_PATH"
cp *.otf "$OPERATOR_MONO_LIG_PATH/original"
cd "$OPERATOR_MONO_LIG_PATH"
./build.sh

fonts=(
  OperatorMonoLig-Book
  OperatorMonoLig-BookItalic
  OperatorMonoSSmLig-Bold
  OperatorMonoSSmLig-BoldItalic
)

info "Patching font..."

cd $NERD_FONT_PATH

for font in ${fonts[@]}
do
  info "Patch and install ${font}"

  ./font-patcher "$OPERATOR_MONO_LIG_PATH/build/${font}.otf" \
    --quiet \
    --careful \
    --complete \
    --out "$HOME/Desktop"

  success "${font} patched and moved to your Desktop"
done

success "All font patched and moved to your Desktop. Just move them into FontBook."
