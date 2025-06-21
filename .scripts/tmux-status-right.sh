#!/usr/bin/env bash

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

if [ $percentage -lt 20 ]; then
  fg=$tier1
  symbol="󱊡 "
elif [ $percentage -lt 70 ]; then
  fg=$tier3
  symbol="󱊢 "
else
  fg=$tier7
  symbol="󱊣 "
fi

if [ -z "$status" ]; then
  fg=$tier5
  symbol=""
fi

if [ "$status" == "charged" ]; then
  fg=$tier8
  symbol="󱊣 "
fi

if [ "$status" == "AC attached" ]; then
  echo "#[fg=$fg]$percentage% 󱐥 "
  exit
fi

if [ "$status" == "charging" ]; then
  fg=$tier8
  symbol="$percentage% 󱊦 "
fi

echo "#[fg=$fg]$symbol"
