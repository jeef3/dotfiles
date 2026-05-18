#!/usr/bin/env zsh

# Font styles
printf "\n"
printf " \e[1mbold\e[0m\n"
printf " \e[2mdim\e[0m\n"
printf " \e[3mitalic\e[0m\n"
printf " \e[1m\e[3mbold italic\e[0m\n"
printf "\n"
printf " \e[4munderline\e[0m\n"
printf " \e[4:2mdouble underline\e[0m\n"
printf " \e[4:3mundercurl\e[0m\n"
printf " \e[9mstrikethrough\e[0m\n"
printf "\n"
printf " \e[4:3m\e[58;2;240;143;104m\e[32mgreen text with orange undercurl\e[0m\n"
printf "\n"
printf " Ligatures => === !== ->>\n"
printf "\n"

# 16-color palette
colors=(black red green yellow blue purple cyan white)
printf " Normal (0-7)   Bright (8-15)\n"
for i in {0..7}; do
  printf "\e[%dm %-8s \e[0m     \e[%dm %-8s \e[0m\n" \
    $((30+i)) "${colors[$((i+1))]}" \
    $((90+i)) "${colors[$((i+1))]}"
done
printf "\n"

# Palette swatches (background blocks)
printf " "
for i in {0..7};  do printf "\e[48;5;%dm   \e[0m" "$i"; done
printf "\n "
for i in {8..15}; do printf "\e[48;5;%dm   \e[0m" "$i"; done
printf "\n\n"

# Truecolor gradient
cols=$(tput cols)
label="True color test"
awk -v cols="$cols" -v label="$label" 'BEGIN{
    len = length(label);
    pad = int((cols - len) / 2);
    for (colnum = 0; colnum<cols; colnum++) {
        r = 255-(colnum*255/(cols-1));
        g = (colnum*510/(cols-1));
        b = (colnum*255/(cols-1));
        if (g>255) g = 510-g;
        printf "\033[38;2;%d;%d;%dm", r,g,b;
        if (colnum >= pad && colnum < pad + len)
            printf "%s", substr(label, colnum - pad + 1, 1);
        else
            printf " ";
    }
    printf "\033[0m\n";
    for (colnum = 0; colnum<cols; colnum++) {
        r = 255-(colnum*255/(cols-1));
        g = (colnum*510/(cols-1));
        b = (colnum*255/(cols-1));
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm ", r,g,b;
    }
    printf "\033[0m\n\n";
}'
