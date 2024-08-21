#!/bin/sh

pm=$(pmset -g batt)
percentage=$(echo "$pm" | grep -o "[0-9]\{1,3\}%" | sed 's/.$//')
status=$(echo "$pm" | awk -F '; *' 'NR==2 { print $2  }')
on_hold=$(echo "$pm" | grep -o "not charging present: true")

tier8='#b0e687'
tier7='#55ff00'
tier6='#aaff00'
tier5='#ffff00'
tier4='#ffc000'
tier3='#ff8000'
tier2='#ff4000'
tier1='#ff0000'

if [ $percentage -lt 11 ]; then
  fg=$tier1
  symbol=""
elif [ $percentage -lt 21 ]; then
  fg=$tier2
  symbol=""
elif [ $percentage -lt 31 ]; then
  fg=$tier3
  symbol=""
elif [ $percentage -lt 41 ]; then
  fg=$tier4
  symbol=""
elif [ $percentage -lt 51 ]; then
  fg=$tier5
  symbol=""
elif [ $percentage -lt 61 ]; then
  fg=$tier6
  symbol=""
elif [ $percentage -lt 71 ]; then
  fg=$tier6
  symbol=""
elif [ $percentage -lt 81 ]; then
  fg=$tier7
  symbol=""
elif [ $percentage -lt 91 ]; then
  fg=$tier7
  symbol=""
else
  fg=$tier8
  symbol=""
fi

if [ -z "$status" ]; then
  fg=$tier5
  symbol=""
fi

if [ "$status" == "charged" ]; then
  fg=$tier8
  symbol=""
fi

if [ "$status" == "AC attached" ]; then
  echo "#[fg=$fg]$percentage% 󱐥"
  exit
fi

if [ "$status" == "charging" ]; then
  fg=$tier8
  symbol="$percentage% 󱐥"
fi

echo "#[fg=$fg]$symbol"
