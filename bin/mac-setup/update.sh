#!/bin/sh

brew update && brew upgrade && brew upgrade --cask

# remove once done on all Macs
brew install font-cascadia-code font-cascadia-code-{nf,pl,mono,mono-nf,mono-pl}

git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull
