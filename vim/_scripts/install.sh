#!/bin/bash

echo "[-][vim] Begin installation ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")


if [ -h ~/.vimrc ] || [ -e ~/.vimrc ] || [ -e ~/.ctags ]; then
    echo "Backup previous files"
    mv ~/.vimrc ~/.vimrc.$DATE.bak && echo "Rename ~/.vimrc as ~/.vimrc.$DATE.bak"
    mv ~/.vim ~/.vim.$DATE.bak && echo "Rename ~/.vim as ~/.vim.$DATE.bak"
    mv ~/.ctags ~/.ctags.$DATE.bak && echo "Rename ~/.ctags as ~/.ctags.$DATE.bak"
fi

ln -s "`pwd`/.vimrc" ~/.vimrc
ln -s "`pwd`/.vim" ~/.vim
ln -s "`pwd`/.ctags" ~/.ctags

if [ -d ~/.vim/backups ]; then
  mkdir ~/.vim/backups
fi

if [ -d ~/.vim/tmp ]; then
  mkdir ~/.vim/tmp
fi
echo "Clone vundle"
git clone --recursive 'https://github.com/gmarik/Vundle.vim.git' '~/.vim/bundle/Vundle.vim'
echo "Install plugins"
vim +PluginInstall +qall

echo "In order to use YoucompleteMe and tern_js you must have cmake and npm installed"

cd ~/.vim/bundle/YouCompleteMe && ./install.py --tern-completer && cd ~/my-tools

cd ~/.vim/bundle/tern_for_vim && npm install && cd ~/my-tools

echo "[+][vim] installation complete."
