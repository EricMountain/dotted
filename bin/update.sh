#!/bin/sh

set -euo pipefail

# Oh my zsh and p10k #######################################################
my_zsh_custom=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
for x in zsh-syntax-highlighting zsh-autosuggestions; do
    if [ ! -d ${my_zsh_custom}/plugins/${x} ]; then
        git clone https://github.com/zsh-users/${x} "${my_zsh_custom}/plugins/${x}"
    fi
    git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/${x}" pull
done

git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" pull

# MacOS ####################################################################
if [ "$(uname)" = "Darwin" ]; then
    brew update && brew upgrade && brew upgrade --cask

    # TODO: remove once done on all Macs
    brew install --cask font-caskaydia-cove-nerd-font
fi

# Local ####################################################################
if [ -x ~/.local-config.d/update.sh ]; then
    ~/.local-config.d/update.sh
fi
