
BREW=$(brew --prefix)

# TODO: This one is a little slow?
source ~/.zsh/plugged/zsh-git-prompt/zshrc.sh

source $BREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=(~/.zsh/plugged/zsh-completions/src $fpath)

# Should be last
source $BREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
