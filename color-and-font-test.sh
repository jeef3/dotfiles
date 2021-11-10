#!/bin/bash

printf "\n\n     "
for j in {0..8}; do
  printf "${j}    "
done

for j in {0..5}; do
  printf "\n\n ${j}   "
  for i in {0..8}; do
    echo -en "\033[38;${j};${i}mfoo\033[m  "
  done
done

echo -e "\n"

awk 'BEGIN{
    s="               "; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'

printf '\e[4:3mUndercurl'

echo -e "\n"
