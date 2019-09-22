#!/bin/bash

set -euo pipefail

# Pre-reqs and settings ####################################################
if grep -q 'NAME="Ubuntu"' /etc/os-release; then
    FONT_DIR=~/.fonts

    sudo apt-get install ranger
elif grep -q 'NAME="Arch Linux"' /etc/os-release; then
    FONT_DIR=~/.local/share/fonts

    sudo pacman -S ranger
fi

# Oh-my-zsh & P10k #########################################################
# These should have code reviews before installing really...
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Fonts ####################################################################
# Awesome
[[ -d ${FONT_DIR}/awesome ]] || mkdir -p ${FONT_DIR}/awesome
if [ ! -d ~/.awesome-terminal-fonts ]; then
    git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts ~/.awesome-terminal-fonts

    cp -f ~/.awesome-terminal-fonts/build/*.ttf ${FONT_DIR}/awesome
    cp -f ~/.awesome-terminal-fonts/build/*.sh ${FONT_DIR}/awesome
    mkdir -p ~/.config/fontconfig/conf.d
    cp -f ~/.awesome-terminal-fonts/config/10-symbols.conf ~/.config/fontconfig/conf.d
    fc-cache -fv ${FONT_DIR}/awesome

    sed 's/PragmataPro/Source Code Pro for Powerline/' ~/.config/fontconfig/conf.d/10-symbols.conf >~/.config/fontconfig/conf.d/10-symbols-source_code_pro.conf
    sed 's/PragmataPro/Cascadia Code/' ~/.config/fontconfig/conf.d/10-symbols.conf >~/.config/fontconfig/conf.d/10-symbols-cascadia.conf
fi

# Nerd fonts
[[ -d ${FONT_DIR}/S ]] || mkdir -p ${FONT_DIR}/S
v=v2.0.0
for f in Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete%20Mono.ttf \
    Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete.ttf; do
    (
        fn=$(echo $f | sed 's/%20/ /g')
        cd ${FONT_DIR}/S &&
            curl -Lo $fn "https://github.com/ryanoasis/nerd-fonts/raw/${v}/patched-fonts/SourceCodePro/Medium/complete/${f}"
    )
done

# MS' Cascadia Code (ligatures)
(
    [[ -d ${FONT_DIR}/C ]] || mkdir -p ${FONT_DIR}/C
    cd ${FONT_DIR}/C
    curl -LO 'https://github.com/microsoft/cascadia-code/releases/download/v1909.16/Cascadia.ttf'
)

# Fuzzy matching ###########################################################
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi

# Links ####################################################################
cd dotfiles/home
[[ -L ~/.bashrc ]] || ln --backup -s $(pwd)/bashrc ~/.bashrc
[[ -L ~/.zshrc ]] || ln --backup -s $(pwd)/zshrc ~/.zshrc
[[ -L ~/.p10k.zsh ]] || ln --backup -s $(pwd)/p10k.zsh ~/.p10k.zsh
[[ -L ~/.emacs ]] || ln --backup -s $(pwd)/emacs ~/.emacs
[[ -L ~/.pam_environment ]] || ln --backup -s $(pwd)/pam_environment ~/.pam_environment
