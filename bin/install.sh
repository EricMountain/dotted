#!/bin/bash

set -euo pipefail

cd dotfiles/home
[[ -L ~/.bashrc ]] || ln --backup -s $(pwd)/bashrc ~/.bashrc
[[ -L ~/.emacs ]] || ln --backup -s $(pwd)/emacs ~/.emacs
[[ -L ~/.pam_environment ]] || ln --backup -s $(pwd)/pam_environment ~/.pam_environment
cd -
