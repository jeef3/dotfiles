#!/bin/sh

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

BRANCH_ICON=""

# Xcode Dark Colors
BASE_0="#292a30"
BASE_1="#2f3037"
BASE_2="#393b44"
BASE_3="#414453"
BASE_4="#53606e"
BASE_5="#7f8c98"
BASE_6="#a3b1bf"
BASE_7="#dfdfe0"
DEEP_BLUE_0="#0f5bca"
DEEP_BLUE_1="#4484d1"
DEEP_YELLOW="#fef937"
GREEN_WASH="#243330"
ORANGE_WASH="#382e27"
RED_WASH="#3b2d2b"
BLUE="#4eb0cc"
LIGHT_BLUE="#6bdfff"
ORANGE="#ffa14f"
PINK="#ff7ab2"
RED="#ff8170"
YELLOW="#d9c97c"
PURPLE="#b281eb"
LIGHT_PURPLE="#dabaff"
TEAL="#78c2b3"
LIGHT_TEAL="#acf2e4"
GREEN="#84b360"
LIGHT_GREEN="#b0e687"

PRETTY_PATH=$(sed "s:^$HOME:~:" <<< $CURRENT_PATH)

git_branch() {
  echo $(cat .git/HEAD | sed 's/ref: refs\/heads\///')

  # echo "ran $(date)" >> log.txt
  
  # ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  # ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  # echo "${ref#refs/heads/}"
  
  # echo "--"
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

  PAD=$(printf "%.0s═" $(eval "echo {1..$GAP}"))
  echo "${LEFT_CONTENT}\
${PAD}\
${CENTER_CONTENT}\
${PAD}\
${RIGHT_CONTENT}"
}

if [ $WIDTH -lt 90 ]; then
  if [ $IS_ACTIVE -eq 0 ]; then
    STAT="╡#[fg=$BASE_3,bold] $CURRENT_COMMAND #[default]╞"
  else
    STAT="╡#[fg=$BASE_6,bold] $CURRENT_COMMAND #[default]╞"
  fi

  echo $(print_title -c "$STAT")
else
  GIT_STAT=$(cd $CURRENT_PATH && git_branch)

  if [ $IS_ACTIVE -eq 0 ]; then
    STAT_L="╡#[fg=$BASE_3,bold] $CURRENT_COMMAND #[default,fg=$BASE_2]  $PRETTY_PATH #[default]╞"
  else
    STAT_L="╡#[fg=$BASE_6,bold] $CURRENT_COMMAND #[default,fg=$BASE_3]  $PRETTY_PATH #[default]╞"
  fi

  if [ -n "$GIT_STAT" ]; then
    if [ $IS_ACTIVE -eq 0 ]; then
      STAT_R="#[fg=$BASE_3,bg=default]#[fg=$BASE_0,bg=$BASE_3] $BRANCH_ICON $GIT_STAT #[fg=$BASE_3,bg=default]#[default]"
    else 
      STAT_R="#[fg=$BASE_4,bg=default]#[fg=$BASE_0,bg=$BASE_4] $BRANCH_ICON $GIT_STAT #[fg=$BASE_4,bg=default]#[default]"
    fi
  else
    STAT_R=""
  fi

  echo $(print_title -l "$STAT_L" -r "$STAT_R")
fi
