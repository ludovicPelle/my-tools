#!/bin/bash

echo "[-][vim] Begin installation ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")


if [ -h ~/.vimrc ] || [ -e ~/.vimrc ]; then
    echo "Backup previous files"
    mv ~/.vimrc ~/.vimrc.$DATE.bak && echo "Rename ~/.vimrc as ~/.vimrc.$DATE.bak"
    mv ~/.vim ~/.vim.$DATE.bak && echo "Rename ~/.vim as ~/.vim.$DATE.bak"
fi

ln -s "`pwd`/.vimrc" ~/.vimrc
ln -s "`pwd`/.vim" ~/.vim

if [ -d ~/.vim/backups ]; then
  mkdir ~/.vim/backups
fi

if [ -d ~/.vim/tmp ]; then
  mkdir ~/.vim/tmp
fi

echo "Install plugins"
vim +PluginInstall +qall

echo "[+][vim] installation complete."
