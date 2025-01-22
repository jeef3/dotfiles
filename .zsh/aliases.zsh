alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias hd="hidedesktop; hide.applescript"
alias sd="showdesktop; show.applescript"

alias bubu="bubu.sh"

# App shortcuts
alias t="todo.sh"
alias todo="todotxt-machine ./todo.txt"

alias lg="lazygit"

alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))"'

alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'


alias du="ncdu --color dark -rr --exclude .git --exclude node_modules"

alias ssh="TERM=xterm ssh"

alias python=python3

alias la="ls -la"
alias le="eza -la --git --icons --no-user --no-permissions"
