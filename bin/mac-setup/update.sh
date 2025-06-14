#!/bin/sh

set -euo pipefail

brew update && brew upgrade && brew upgrade --cask

# TODO: remove once done on all Macs
brew install --cask font-caskaydia-cove-nerd-font

git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull
