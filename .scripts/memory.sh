#! /bin/bash

tier8='#b0e687'
tier7='#55ff00'
tier6='#aaff00'
tier5='#ffff00'
tier4='#ffc000'
tier3='#ff8000'
tier2='#ff4000'
tier1='#ff0000'

memory_list=$(ps x -o rss,command | egrep "\d+ nvim" | awk -F " " '{print $1}')

max=0

for i in ${memory_list[@]}; do
  if [[ $i -gt $max ]]; then
    max=$i
  fi
done

let max=(max/1024)

if [ $max -gt 5000 ]; then
  fg=$tier1
  symbol=""
elif [ $max -gt 1000 ]; then
  fg=$tier2
  symbol=""
elif [ $max -gt 500 ]; then
  fg=$tier3
  symbol=""
elif [ $max -gt 300]; then
  fg=$tier4
  symbol=""
elif [ $max -gt 200 ]; then
  fg=$tier5
  symbol=""
elif [ $max -gt 100 ]; then
  fg=$tier6
  symbol=""
elif [ $max -gt 80 ]; then
  fg=$tier6
  symbol=""
elif [ $max -gt 40 ]; then
  fg=$tier7
  symbol=""
elif [ $max -gt 10 ]; then
  fg=$tier7
  symbol=""
else
  fg=$tier8
  symbol=""
fi

echo "#[fg=$fg]${max}MB"
