#!/bin/sh

brew update && brew upgrade && brew upgrade --cask

# remove once done on all Macs
brew install --cask font-cascadia-code font-cascadia-code-{nf,pl}

git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull
