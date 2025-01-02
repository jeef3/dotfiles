#!/bin/bash

printf "\n"
printf " · \e[1mbold\e[0m\n"
printf " · \e[3mItalic\e[0m\n"
printf " · \e[3m\e[1mbold italic\e[0m\n"
printf "\n"
printf " · \e[4munderline\e[0m\n"
printf " · \e[21mdouble underline\e[0m\n"
printf " · \e[4:3mundercurl\e[0m\n"
printf " · \e[9mstrikethrough\e[0m\n"
printf "\n"
printf "\e[4:3m\e[58;2;240;143;104m\e[32mCombination of green text and orange undercurl\e[0m\n"
printf "\n"
printf "Ligatures => ===\n"
printf "\n"

echo -e "\033[0;30mBlack\t\t\033[1;30mDark Grey"
echo -e "\033[0;31mDark Red\t\033[1;31mRed"
echo -e "\033[0;32mDark Green\t\033[1;32mGreen"
echo -e "\033[0;33mDark Yellow\t\033[1;33mYellow"
echo -e "\033[0;34mDark Blue\t\033[1;34mBlue"
echo -e "\033[0;35mDark Purple\t\033[1;35mLIGHT_PURPLE"
echo -e "\033[0;36mDark Cyan\t\033[1;36mCyan"
echo -e "\033[0;37mLight Grey\t\033[1;37mWhite"

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
    printf "\n\n";
}'
