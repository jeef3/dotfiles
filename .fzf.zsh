# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/jeffknaggs/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/jeffknaggs/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */Users/jeffknaggs/.fzf/man* && -d "/Users/jeffknaggs/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/Users/jeffknaggs/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/jeffknaggs/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/jeffknaggs/.fzf/shell/key-bindings.zsh"

