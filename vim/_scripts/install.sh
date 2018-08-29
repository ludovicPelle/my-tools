#!/bin/bash

echo "[-][vim] Begin installation ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")


if [ -e ~/.vimrc ]; then
	echo "Backup .vimrc"
	mv ~/.vimrc ~/.vimrc.$DATE.bak && echo "Rename ~/.vimrc as ~/.vimrc.$DATE.bak"
fi
if [ -e ~/.vim ]; then
	echo "Backup .vim directory"
	mv ~/.vim ~/.vim.$DATE.bak && echo "Rename ~/.vim as ~/.vim.$DATE.bak"
fi

if ! [ -x "$(command -v ctags)" ]; then
    sudo pacman -S ctags
fi

if [ -e ~/.ctags ]; then
	echo "Backup .ctags"
    sudo pacman -S ctags
	mv ~/.ctags ~/.ctags.$DATE.bak && echo "Rename ~/.ctags as ~/.ctags.$DATE.bak"
fi

echo "Creat symlinks from:" `pwd`
ln -fs "`pwd`/.vimrc" ~/.vimrc
ln -fs "`pwd`/.vim" ~/.vim
ln -fs "`pwd`/.ctags" ~/.ctags

if [ ! -e ~/.vim/backups ]; then
	mkdir ~/.vim/backups
fi

if [ ! -e ~/.vim/tmp ]; then
	mkdir ~/.vim/tmp
fi
if [ ! -e ~/.vim/bundle ] ; then
	mkdir ~/.vim/bundle/
fi
echo "Clone vundle"
git clone --recursive 'https://github.com/gmarik/Vundle.vim.git' ~/.vim/bundle/Vundle.vim

echo "Install plugins"
vim +PluginInstall +qall

if ! [ -x "$(command -v yaourt)" ]; then
    echo "Install yaourt"
    sudo pacman -S yaourt
fi
cd ~/.vim/bundle/YouCompleteMe && ./install.py && cd ~/my-tools
echo "Install AUR for autocompletion servers ok"
sudo yaourt -S vim-youcompleteme-git
echo "[+][vim] installation complete."
