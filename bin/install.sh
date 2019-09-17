#!/bin/bash

set -euo pipefail

# These should have code reviews before installing really...
if [ ! -d ~/.oh-my-zsh ] ; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ] ; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if grep -q 'NAME="Ubuntu"' /etc/os-release ; then
    if [ ! -d ~/.awesome-terminal-fonts ] ; then
        git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts ~/.awesome-terminal-fonts
        cd ~/.awesome-terminal-fonts
        ./install.sh
        cd - > /dev/null
        sed -i 's/PragmataPro/Source Code Pro for Powerline/' ~/.config/fontconfig/conf.d/10-symbols.conf
    fi
fi

if [ ! -d ~/.fzf ] ; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi

cd dotfiles/home
[[ -L ~/.bashrc ]] || ln --backup -s $(pwd)/bashrc ~/.bashrc
[[ -L ~/.zshrc ]] || ln --backup -s $(pwd)/zshrc ~/.zshrc
[[ -L ~/.emacs ]] || ln --backup -s $(pwd)/emacs ~/.emacs
[[ -L ~/.pam_environment ]] || ln --backup -s $(pwd)/pam_environment ~/.pam_environment
