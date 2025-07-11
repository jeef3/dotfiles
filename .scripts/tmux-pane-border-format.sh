#!/usr/bin/env bash

source $(dirname "$0")/../setup/color.sh
source $(dirname "$0")/../setup/icon.sh

while [ ! -z "$1"  ]; do
  case "$1" in
    --pid)
      shift
      CURRENT_PID="$1"
      ;;
    -c|--command)
      shift
      CURRENT_COMMAND="$1"
      ;;
    -p|--path)
      shift
      CURRENT_PATH="$1"
      ;;
    --is-active)
      shift
      IS_ACTIVE="$1"
      ;;
    -w|--width)
      shift
      WIDTH="$1"
      ;;
    *)
  esac
shift
done

BRANCH_ICON=""

PRETTY_PATH=$(sed "s:^$HOME:~:" <<< $CURRENT_PATH)

git_branch() {
  echo $(cat .git/HEAD | sed 's/ref: refs\/heads\///')
}

strip_formatting() {
  echo $1 | perl -pe 's|#\[.*?\]||g'
}

count_width() {
  ESCAPED=$(strip_formatting "$1")
  echo "${#ESCAPED}"
}

print_title() {
  while [ ! -z "$1"  ]; do
    case "$1" in
      -l|--left)
        shift
        LEFT_CONTENT="$1"
        ;;
      -c|--center)
        shift
        CENTER_CONTENT="$1"
        ;;
      -r|--right)
        shift
        RIGHT_CONTENT="$1"
        ;;
      *)
    esac
    shift
  done

  COUNT=`expr $WIDTH - 4`

  LEFT_WIDTH=$(count_width "$LEFT_CONTENT")
  CENTER_WIDTH=$(count_width "$CENTER_CONTENT")
  RIGHT_WIDTH=$(count_width "$RIGHT_CONTENT")

  GAP=`expr $COUNT - ${LEFT_WIDTH} - ${CENTER_WIDTH} - ${RIGHT_WIDTH}`
  GAP=`expr $GAP / 2`

  if [ $IS_ACTIVE -eq 0 ]; then
    PAD=$(printf "%.0s─" $(eval "echo {1..$GAP}"))
  else
    PAD=$(printf "%.0s━" $(eval "echo {1..$GAP}"))
    PAD="#[fg=$GREEN_500]$PAD"
  fi

  echo "${LEFT_CONTENT}\
${PAD}\
${CENTER_CONTENT}\
${PAD}\
${RIGHT_CONTENT}"
}

icon=$(get_icon "$CURRENT_COMMAND")
CMD="${icon} $CURRENT_COMMAND"

if [ $WIDTH -lt 90 ]; then
  if [ $IS_ACTIVE -eq 0 ]; then
    STAT="┤#[fg=$SILVER_600] $CMD #[default]├"
  else
    STAT="#[fg=$GREEN_500]┫#[fg=$BLUE_500]#[bold] $CMD #[fg=$GREEN_500]┣"
  fi

  echo $(print_title -c "$STAT")
else
  GIT_STAT=$(cd $CURRENT_PATH && git_branch)

  if [ $IS_ACTIVE -eq 0 ]; then
    STAT_L="┤#[fg=$SILVER_600] $CMD #[default,fg=$SILVER_600]  $PRETTY_PATH #[default]├"
  else
    STAT_L="#[fg=$GREEN_500]┫#[fg=$BLUE_500]#[bold] $CMD #[default,fg=$SILVER_200]  $PRETTY_PATH #[fg=$GREEN_500]┣"
  fi

  if [ -n "$GIT_STAT" ]; then
    if [ $IS_ACTIVE -eq 0 ]; then
      STAT_R="#[fg=$SILVER_800,bg=default]┤#[fg=$SILVER_500] $BRANCH_ICON $GIT_STAT #[fg=$SILVER_800]├#[default]"
    else
      STAT_R="#[fg=$GREEN_600,bg=default]┫#[fg=$SILVER_200] $BRANCH_ICON $GIT_STAT #[fg=$GREEN_500]┣#[default]"
    fi
  else
    STAT_R=""
  fi

  if tmux list-panes -F '#F' | grep -q Z; then
    STAT_R="${STAT_R}#[fg=$GREEN_500]━┫ 󰊔 ┣"
  fi

  echo $(print_title -l "$STAT_L" -r "$STAT_R")
fi
