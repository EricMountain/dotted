#!/bin/bash

set -euo pipefail
set -x
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
    if [ "$(uname -m)" = "x86_64" ]; then
        brew_prefix=/usr/local
    else
        brew_prefix=/opt/homebrew
    fi
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
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

my_zsh_custom=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
for x in zsh-syntax-highlighting zsh-autosuggestions; do
    if [ ! -d ${my_zsh_custom}/plugins/${x} ]; then
        git clone https://github.com/zsh-users/${x} "${my_zsh_custom}/plugins/${x}"
    fi
done
#chmod g-w,o-w -R ${my_zsh_custom}

if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Font #####################################################################
# Awesome… really just for the codepoint mappings that we source on shell startup
if [ ! -d ~/.awesome-terminal-fonts ]; then
    git clone --depth 1 https://github.com/gabrielelana/awesome-terminal-fonts ~/.awesome-terminal-fonts
    cp -f ~/.awesome-terminal-fonts/build/*.sh ${FONT_DIR}
fi

if [ -d ~/.awesome-terminal-fonts ]; then
    for x in devicons-regular.ttf fontawesome-regular.ttf octicons-regular.ttf pomicons-regular.ttf; do
        rm -f ${FONT_DIR}/awesome/${x}
    done

    if [ ${OS_DIST} != "Apple" ]; then
        rm -f ~/.config/fontconfig/conf.d/10-symbols.conf
        rm -f ~/.config/fontconfig/conf.d/10-symbols-source_code_pro.conf
        rm -f ~/.config/fontconfig/conf.d/10-symbols-cascadia.conf
        fc-cache -fv ${FONT_DIR}
    fi
fi

# Delugia font: MS' Cascadia Code (ligatures) with Nerd fonts etc
(
    [[ -d ${FONT_DIR} ]] || mkdir -p ${FONT_DIR}
    cp fonts/DelugiaCodeNerdFontComplete.ttf ${FONT_DIR}
    if [ ${OS_DIST} != "Apple" ]; then
        # Ignore missing fc-cache (e.g. headless systems) etc
        fc-cache -fv ${FONT_DIR} || true
    fi
)

# Fuzzy matching ###########################################################
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
fi

# PATH overrides for MacOS #################################################
# brew coreutils is a prereq, we need GNU ln
if [ ${OS_DIST} = "Apple" ]; then
    export PATH="${brew_prefix}/opt/coreutils/libexec/gnubin:$PATH"
fi

# Links ####################################################################
cd dotfiles/home
[[ -L ~/.bashrc ]] || ln --backup -s $(pwd)/bashrc ~/.bashrc
[[ -L ~/.zshrc ]] || ln --backup -s $(pwd)/zshrc ~/.zshrc
[[ -L ~/.p10k.zsh ]] || ln --backup -s $(pwd)/p10k.zsh ~/.p10k.zsh
[[ -L ~/.emacs ]] || ln --backup -s $(pwd)/emacs ~/.emacs
[[ -L ~/.toprc ]] || ln --backup -s $(pwd)/toprc ~/.toprc

# Git ######################################################################
git config --global rebase.autosquash true
git config --global merge.ff only
git config --global pull.ff only
git config --global diff.colorMoved dimmed-zebra
git config --global diff.colorMovedWS no
git config --global diff.wsErrorHighlight all
git config --global core.quotepath off
