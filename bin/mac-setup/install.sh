#!/bin/bash

set -euo pipefail

# Stuff that maybe needs doing after running this:
# * Fzf: To install useful keybindings and fuzzy completion: /usr/local/opt/fzf/install
# * To use fzf in Vim, add the following line to your .vimrc: set rtp+=/usr/local/opt/fzf
# * Unbound: sudo brew services start unbound (done?)
# * [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# https://github.com/derekparker/delve/blob/master/Documentation/installation/osx/install.md

# This has to be done by hand first. It opens a dialog.
#xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

for x in bash ack httpie git watch autojump ipcalc \
    wget coreutils gnu-sed tmux fzf jq python virtualenv\
    ncdu parallel zsh findutils gcc make gpg2 pinentry bat gnu-tar \
    gnu-time hub grep git-delta tree yq \
    direnv datamash zotero pyenv bluesnooze java ; do
	/opt/homebrew/bin/brew install $x
done

# Others: alfred spectacle
# virtualbox: not compatible with arm64 chip
for y in iterm2 gimp github finicky ; do
    /opt/homebrew/bin/brew install --cask $y
done
