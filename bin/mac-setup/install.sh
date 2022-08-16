#!/bin/sh

# Stuff that maybe needs doing after running this:
# * Fzf: To install useful keybindings and fuzzy completion: /usr/local/opt/fzf/install
# * To use fzf in Vim, add the following line to your .vimrc: set rtp+=/usr/local/opt/fzf
# * Unbound: sudo brew services start unbound (done?)
# * [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# https://github.com/derekparker/delve/blob/master/Documentation/installation/osx/install.md
xcode-select --install
#sudo /usr/sbin/DevToolsSecurity -enable

for x in bash ack httpie git watch autojump ipcalc \
    wget coreutils gnu-sed tmux fzf jq \
    ncdu parallel zsh findutils gcc make gpg2 pinentry bat gnu-tar \
    gnu-time hub grep git-delta tree yq \
    direnv datamash zotero pyenv bluesnooze ; do
	brew install $x
done

# Others: alfred spectacle
for y in gifs iterm2 virtualbox gimp github \
         finicky ; do
    brew install --cask $y
done

pip3 install virtualenv

brew cask install homebrew/cask-versions/adoptopenjdk8
