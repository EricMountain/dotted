# Dotted

Repository and install scripts for dot-files used across multiple systems.  Includes configuration for Emacs, Bash... and Docker images for certain tools.

## Font setup

### VSCode, Konsole, JetBrains, iTerm…

After running the installations, select 'CaskaydiaCove Nerd Font' in each app.

## Macs

### Before

This has to be done by hand first. It opens a dialog.

```shell
xcode-select --install
```

### After

Stuff that maybe needs doing after running install:

* Fzf: To install useful keybindings and fuzzy completion: /usr/local/opt/fzf/install
    * To use fzf in Vim, add the following line to your .vimrc: set rtp+=/usr/local/opt/fzf
* Unbound: sudo brew services start unbound (automatic?)
* [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

### Optional stuff

E.g. not installed on Y’s machine at least to begin with:

```shell
for x in ack httpie ipcalc sipcalc hub git-delta rbenv unnaturalscrollwheels \
    datamash zotero bluesnooze bats-core; do
    ${brew_prefix}/bin/brew install $x
done
brew tap bats-core/bats-core
brew install bats-assert
brew install bats-support
brew install bats-file
brew install bats-detik
for y in github finicky notunes; do
    ${brew_prefix}/bin/brew install --cask $y
done
```

#### Not yet done on R's machine

* rbenv
* sipcalc

#### Todo when installing for N

* signal
* libreoffice
* libreoffice-language-pack (requires running a subsequent installer)

### Keybindings

Make Home/End work properly… except this doesn’t work…

```shell
# https://stackoverflow.com/a/246128
# script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
# mkdir -p ~/Library/KeyBindings
# cp "${script_dir}/DefaultKeyBinding.dict" ~/Library/KeyBindings
```

## Upstream sources

* Oh-my-zsh
* Powerlevel 10k
* Fonts
    * Source Code Pro Medium
    * Delugia Code
    * Caskaydia Cove

### Git prompt

Includes `git-prompt.sh` from the original [Git source](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh) with minor modifications (mainly to use Unicode characters outside the ASCII range).
