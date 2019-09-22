#!/bin/bash

set -euo pipefail

# These should have code reviews before installing really...
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if grep -q 'NAME="Ubuntu"' /etc/os-release; then
    if [ ! -d ~/.awesome-terminal-fonts ]; then
        git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts ~/.awesome-terminal-fonts
        cd ~/.awesome-terminal-fonts
        ./install.sh
        cd - >/dev/null
        sed -i 's/PragmataPro/Source Code Pro for Powerline/' ~/.config/fontconfig/conf.d/10-symbols.conf
    fi
    sudo apt-get install ranger
elif grep -q 'NAME="Arch Linux"' /etc/os-release; then
    sudo pacman -S ranger

    [[ -d ~/.local/share/fonts/S ]] || mkdir -p ~/.local/share/fonts/S
    v=v2.0.0
    for f in Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete%20Mono.ttf \
        Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete.ttf; do
        (
            fn=$(echo $f | sed 's/%20/ /g')
            cd ~/.local/share/fonts/S &&
                curl -Lo $fn "https://github.com/ryanoasis/nerd-fonts/raw/${v}/patched-fonts/SourceCodePro/Medium/complete/${f}"
        )
    done
fi

if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi

cd dotfiles/home
[[ -L ~/.bashrc ]] || ln --backup -s $(pwd)/bashrc ~/.bashrc
[[ -L ~/.zshrc ]] || ln --backup -s $(pwd)/zshrc ~/.zshrc
[[ -L ~/.p10k.zsh ]] || ln --backup -s $(pwd)/p10k.zsh ~/.p10k.zsh
[[ -L ~/.emacs ]] || ln --backup -s $(pwd)/emacs ~/.emacs
[[ -L ~/.pam_environment ]] || ln --backup -s $(pwd)/pam_environment ~/.pam_environment
