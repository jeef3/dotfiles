#!/bin/sh

percentage=$(pmset -g batt | grep -o "[0-9]\{1,3\}%" | sed 's/.$//')
status=$(pmset -g batt | awk -F '; *' 'NR==2 { print $2  }')

tier8='#00ff00'
tier7='#55ff00'
tier6='#aaff00'
tier5='#ffff00'
tier4='#ffc000'
tier3='#ff8000'
tier2='#ff4000'
tier1='#ff0000'

# percentage=100

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

if [ $status == 'charged' ]; then
  symbol=""
fi

echo "#[fg=$fg]$symbol"
