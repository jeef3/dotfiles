# Jeff's .files

I was going to fork a dotfiles from elsewhere, but there were too many good ones to choose from, so I decided to just start my own and grab what I wanted as I needed it.

## Install

`git clone git@github.com:jeef3/dotfiles.git`

`./install-deps.sh`

## Set-up Custom/private

Add additional custom/private info to `~/.extra`, e.g.: Git name/email:

```
GIT_AUTHOR_NAME="Mr Smith"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL="mr.smith@example.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

## Update

`./sync.sh`
