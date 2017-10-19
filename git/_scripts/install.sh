#!/bin/bash

echo "[-][git] Begin configuration ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")


if [ -f ~/.gitconfig ]; then
	echo "Backup .gitconfig"
	mv ~/.gitconfig ~/.gitconfig.$DATE.bak && echo "Rename ~/.gitconfig as ~/.gitconfig.$DATE.bak"
fi

echo "From" `pwd`
ln -fs "`pwd`/.gitconfig" ~/.gitconfig

#add autocompletion
sudo pacman -S bash-completion

echo "[+][git] installation complete."
