#!/bin/zsh

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
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
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
        LEFT="$1"
        ;;
      -c|--center)
        shift
        CENTER="$1"
        ;;
      -r|--right)
        shift
        RIGHT="$1"
        ;;
      *)
    esac
    shift
  done

  COUNT=`expr $WIDTH - 4`

  LEFT_BORDER="┤"
  RIGHT_BORDER="├"
                ╎
  LINE="─"

  if [ -n "$LEFT" ]; then
    LEFT_CONTENT="${LEFT_BORDER}${LEFT}${RIGHT_BORDER}"
  else
    LEFT_CONTENT=""
  fi
  
  if [ -n "$CENTER" ]; then
    CENTER_CONTENT="${LEFT_BORDER}${CENTER}${RIGHT_BORDER}"
  else 
    CENTER_CONTENT=""
  fi

  if [ -n "$RIGHT" ]; then
    RIGHT_CONTENT="${LEFT_BORDER}${RIGHT}${RIGHT_BORDER}"
  else 
    RIGHT_CONTENT=""
  fi

  LEFT_WIDTH=$(count_width "$LEFT_CONTENT")
  CENTER_WIDTH=$(count_width "$CENTER_CONTENT")
  RIGHT_WIDTH=$(count_width "$RIGHT_CONTENT")

  GAP=`expr $COUNT - ${LEFT_WIDTH} - ${CENTER_WIDTH} - ${RIGHT_WIDTH}`
  GAP=`expr $GAP / 2`

  PAD=$(printf "%.0s$LINE" $(eval "echo {1..$GAP}"))
  echo "${LEFT_CONTENT}\
${PAD}\
${CENTER_CONTENT}\
${PAD}\
${RIGHT_CONTENT}"
}

if [ $WIDTH -lt 60 ]; then
  STAT="#[fg=$BASE_6,bold] $CURRENT_COMMAND #[default]"

  echo $(print_title -c "$STAT")
elif [ $WIDTH -lt 90 ]; then
  STAT="#[fg=$BASE_6,bold] $CURRENT_COMMAND #[default]"

  echo $(print_title -c "$STAT")
else
  STAT_L="#[fg=$BASE_4,bg=$YELLOW]#[fg=$BASE_0,bg=$YELLOW,bold] $CURRENT_COMMAND #[default]#[fg=$YELLOW,bg=$BASE_3]#[fg=$BASE_3,bg=$BASE_3]"
  STAT_R="#[fg=$BASE_3,bg=$BASE_5]#[fg=$BASE_0,bg=$BASE_5] $PRETTY_PATH #[fg=$BASE_5,bg=$BASE_4]\
#[fg=$BASE_0,bg=$BASE_4] $BRANCH_ICON $(cd $CURRENT_PATH && git_branch) \
#[default]"
#
  echo $(print_title -l "$STAT_L" -r "$STAT_R")
fi
