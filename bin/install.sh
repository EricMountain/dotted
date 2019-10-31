#!/bin/bash

set -euo pipefail

# Crude OS check ###########################################################
if grep -q 'NAME="Ubuntu"' /etc/os-release 2>/dev/null; then
    OS_CLASS=Linux
    OS_DIST=Ubuntu
elif grep -q 'NAME="Arch Linux"' /etc/os-release 2>/dev/null; then
    OS_CLASS=Linux
    OS_DIST=ArchLinux
elif [ "$(uname)" = "Darwin" ]; then
    OS_CLASS=Darwin
    OS_DIST=Apple
else
    echo Unknown OS/distribution.
    exit 1
fi

# Pre-reqs and settings ####################################################
case ${OS_CLASS} in
Linux)
    FONT_DIR=~/.local/share/fonts
    ;;
Darwin)
    FONT_DIR=~/Library/Fonts
    ;;
esac
[[ -d ${FONT_DIR} ]] || mkdir -p ${FONT_DIR}

case ${OS_DIST} in
Ubuntu)
    sudo apt-get install ranger
    ;;
ArchLinux)
    sudo pacman -S ranger
    ;;
Apple)
    brew install ranger
    ;;
esac

# Oh-my-zsh & P10k #########################################################
# These should have code reviews before installing really...
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

my_zsh_custom=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
for x in zsh-syntax-highlighting zsh-autosuggestions ; do
    if [ ! -d ${my_zsh_custom}/plugins/${x} ] ; then
        git clone https://github.com/zsh-users/${x} "${my_zsh_custom}/plugins/${x}"
    fi
done
chmod g-w,o-w -R ${my_zsh_custom}

if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Fonts ####################################################################
# Awesome
if [ ! -d ~/.awesome-terminal-fonts ]; then
    git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts ~/.awesome-terminal-fonts

    cp -f ~/.awesome-terminal-fonts/build/*.ttf ${FONT_DIR}
    cp -f ~/.awesome-terminal-fonts/build/*.sh ${FONT_DIR}

    if [ ${OS_DIST} != "Apple" ]; then
        mkdir -p ~/.config/fontconfig/conf.d
        cp -f ~/.awesome-terminal-fonts/config/10-symbols.conf ~/.config/fontconfig/conf.d
        fc-cache -fv ${FONT_DIR}

        sed 's/PragmataPro/Source Code Pro for Powerline/' ~/.config/fontconfig/conf.d/10-symbols.conf >~/.config/fontconfig/conf.d/10-symbols-source_code_pro.conf
        sed 's/PragmataPro/Cascadia Code/' ~/.config/fontconfig/conf.d/10-symbols.conf >~/.config/fontconfig/conf.d/10-symbols-cascadia.conf
    fi
fi

# Nerd fonts (not used: doesn't look as good as the Source Code Pro for
# Powerline font from system packages on Arch)
# [[ -d ${FONT_DIR}/S ]] || mkdir -p ${FONT_DIR}/S
# v=v2.0.0
# for f in Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete%20Mono.ttf Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete.ttf; do
#     (
#         fn=$(echo $f | sed 's/%20/ /g')
#         cd ${FONT_DIR}/S
#         if [[ ! -e "${fn}" ]] ; then
#             curl -Lo "${fn}" "https://github.com/ryanoasis/nerd-fonts/raw/${v}/patched-fonts/SourceCodePro/Medium/complete/${f}"
#         fi
#     )
# done

# MS' Cascadia Code (ligatures)
(
    [[ -d ${FONT_DIR} ]] || mkdir -p ${FONT_DIR}
    cd ${FONT_DIR}
    curl -LO 'https://github.com/microsoft/cascadia-code/releases/download/v1909.16/Cascadia.ttf'
)

# Fuzzy matching ###########################################################
if [ -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi

# PATH overrides for MacOS #################################################
# brew coreutils is a prereq
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Links ####################################################################
cd dotfiles/home
[[ -L ~/.bashrc ]] || ln --backup -s $(pwd)/bashrc ~/.bashrc
[[ -L ~/.zshrc ]] || ln --backup -s $(pwd)/zshrc ~/.zshrc
[[ -L ~/.p10k.zsh ]] || ln --backup -s $(pwd)/p10k.zsh ~/.p10k.zsh
[[ -L ~/.emacs ]] || ln --backup -s $(pwd)/emacs ~/.emacs
[[ -L ~/.pam_environment ]] || ln --backup -s $(pwd)/pam_environment ~/.pam_environment
[[ -L ~/.toprc ]] || ln --backup -s $(pwd)/toprc ~/.toprc
