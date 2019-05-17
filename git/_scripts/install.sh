#!/bin/bash

echo "[-][git] Begin configuration ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")

#add git
if ! pacman -Qi git; then
    echo "Install git"
    sudo pacman -S git
fi

if [ -f ~/.gitconfig ]; then
    echo "Backup .gitconfig"
    mv ~/.gitconfig ~/.gitconfig.$DATE.bak && echo "Rename ~/.gitconfig as ~/.gitconfig.$DATE.bak"
fi

echo "Symlinking From" `pwd`
ln -fs "`pwd`/.gitconfig" ~/.gitconfig

if ! [ -x "$(command -v diff-so-fancy)" ]; then
    if ! [ -x "$(command -v yaourt)" ]; then
        echo "Install yaourt"
        sudo pacman -S yaourt
    fi
    echo "Install diff-so-fancy"
    yaourt -S diff-so-fancy-git
fi
echo "[+][git] installation complete."
