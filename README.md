# Jeff's .files

## Install

First, make sure full Xcode is installed.

Run the initial Bootstrap:

```
curl -fsSL https://raw.github.com/jeef3/dotfiles/master/bootstrap.sh | bash
```

This will install Homebrew then Git and then clone this rpository to `~/projects/dotfiles`

## Next Steps

```
./setup.sh
```

Links the dotfiles and installs all my base Brews and settings.

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
