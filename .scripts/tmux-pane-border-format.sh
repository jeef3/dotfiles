#!/bin/zsh

while [ ! -z "$1"  ]; do
  case "$1" in
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

BRANCH_ICON="\ue725"
INACTIVE_BORDER_COLOR='#444444'
YELLOW="#d9c97c"

PRETTY_PATH=$(sed "s:^$HOME:~:" <<< $CURRENT_PATH)

git_branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
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
  BORDER="-"

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

  # LEFT_COUNT=$(echo "$LEFT_CONTENT" |  wc -c)
  # CENTER_COUNT=$(echo "$CENTER_CONTENT" |  wc -c)
  # RIGHT_COUNT=$(echo "$RIGHT_CONTENT" |  wc -c)

  GAP=`expr $COUNT - ${#LEFT_CONTENT} - ${#CENTER_CONTENT} - ${#RIGHT_CONTENT}`
  GAP=`expr $GAP / 2`
  LINE="─"

  PAD=$(printf "%.0s$LINE" $(eval "echo {1..$GAP}"))
  echo "${LEFT_CONTENT}\
${PAD}\
${CENTER_CONTENT}\
${PAD}\
${RIGHT_CONTENT}"
}

if [ $WIDTH -lt 60 ]; then
  echo "$(print_title)"
elif [ $WIDTH -lt 90 ]; then
  # echo " $(cd $CURRENT_PATH && git_branch) "
  echo "$(print_title)"
else
  # STAT=" #[fg=$YELLOW]$PRETTY_PATH#[fg=$INACTIVE_BORDER_COLOR] $(cd $CURRENT_PATH && git_branch) "
  # echo "$(print_title -r "$STAT")"
  # echo "$(print_title -r " #[fg=$YELLOW]$(git_branch) ")"
  echo "$(print_title -r " $(git_branch) ")"
fi
