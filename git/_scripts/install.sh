#!/bin/bash

echo "[-][git] Begin configuration ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")

#add git
if ! brew list git; then
    echo "Install git"
    brew install  git
fi

if [ -f ~/.gitconfig ]; then
    echo "Backup .gitconfig"
    mv ~/.gitconfig ~/.gitconfig.$DATE.bak && echo "Rename ~/.gitconfig as ~/.gitconfig.$DATE.bak"
fi

echo "Symlinking From" `pwd`
ln -fs "`pwd`/.gitconfig" ~/.gitconfig

if ! [ -x "$(command -v diff-so-fancy)" ]; then
    echo "Install diff-so-fancy"
    brew install diff-so-fancy
fi
echo "[+][git] installation complete."
