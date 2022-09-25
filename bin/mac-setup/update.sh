#!/bin/sh

brew update && brew upgrade && brew upgrade --cask

git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull

