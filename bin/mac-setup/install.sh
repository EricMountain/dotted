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

# https://stackoverflow.com/a/246128
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

if [ "$(uname -m)" = "x86_64" ]; then
    brew_prefix=/usr/local
else
    brew_prefix=/opt/homebrew
fi

if [[ ! -x ${brew_prefix}/bin/brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

for x in bash git watch autojump wget coreutils gnu-sed tmux fzf jq python virtualenv ncdu parallel \
    zsh findutils gcc make gpg2 pinentry bat gnu-tar gnu-time grep tree yq direnv pyenv java; do
    ${brew_prefix}/bin/brew install $x
done

# Others: alfred, spectacle, virtualbox
for y in iterm2 gimp font-cascadia-code font-cascadia-code-{nf,pl}; do
    ${brew_prefix}/bin/brew install --cask $y
done

# Optional stuff (e.g. not installed on Yelena’s machine at least to begin with)
# for x in ack httpie ipcalc sipcalc hub git-delta rbenv unnaturalscrollwheels \
#     datamash zotero bluesnooze java bats-core; do
#     ${brew_prefix}/bin/brew install $x
# done
# brew tap bats-core/bats-core
# brew install bats-assert
# brew install bats-support
# brew install bats-file
# brew install bats-detik
# for y in github finicky notunes; do
#     ${brew_prefix}/bin/brew install --cask $y
# done

# Make Home/End work properly… except this doesn’t work…
#mkdir -p ~/Library/KeyBindings
#cp "${script_dir}/DefaultKeyBinding.dict" ~/Library/KeyBindings

# Not on Rachael's
# * Install rbenv, sipcalc

# Todo when installing for Nat
# * Install signal, spotify, libreoffice
# * Install libreoffice-language-pack (requires running a subsequent installer)
