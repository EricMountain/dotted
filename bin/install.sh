#!/bin/bash

set -euo pipefail

cd dotfiles/home
ln --backup -s $(pwd)/bashrc ~/.bashrc
ln --backup -s $(pwd)/emacs ~/.emacs
cd -
