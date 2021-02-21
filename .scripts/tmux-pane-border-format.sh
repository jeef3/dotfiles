#!/bin/zsh

PANE_CURRENT_PATH="$1"
PANE_ACTIVE="$2"
TEST="$3"

BRANCH_ICON="\ue725"
INACTIVE_BORDER_COLOR='#444444'
YELLOW="#d9c97c"

PRETTY_PATH=$(sed "s:^$HOME:~:" <<< $PANE_CURRENT_PATH)

git_branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

if [ $TEST -lt 60 ]; then
  echo " ❯ "
elif [ $TEST -lt 90 ]; then
  echo " $(cd $PANE_CURRENT_PATH && git_branch) "
else
    echo " #[fg=$YELLOW]$PRETTY_PATH#[fg=$INACTIVE_BORDER_COLOR] $(cd $PANE_CURRENT_PATH && git_branch) "
fi
