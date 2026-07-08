alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias hd="hidedesktop; hide"
alias sd="showdesktop; show"

alias lg="lazygit"

alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))"'

alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'

alias ssh="TERM=xterm ssh"

alias python=python3

alias la="ls -la"
alias le="eza -la --git --icons --no-user --no-permissions"
