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
	mv ~/.ctags ~/.ctags.$DATE.bak && echo "Rename ~/.ctags as ~/.ctags.$DATE.bak"
fi

echo "Symlinks from:" `pwd`
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

if ! [ -x "$(command -v ctags)" ]; then
    echo "Install ctags"
    sudo pacman -S ctags
fi
if ! [ -x "$(command -v jshint)" ]; then
    echo "Install jshint"
    sudo pacman -S jshint
fi
if ! yay -Qi closure-linter ; then
    echo "Install closure-linter"
    sudo yay -S closure-linter
fi
if ! yay -Qi flake8 ; then
    echo "Install flake8"
    sudo yay -S flake8
fi
if ! yay -Qi autopep8 ; then
    echo "Install autopep8"
    sudo yay -S autopep8
fi
#if ! [ -x "$(command -v yay)" ]; then
    #echo "Install yay"
    #sudo pacman -S yay
#fi
echo "Install & Build YCM Plugin"
cd ~/.vim/bundle/YouCompleteMe && ./install.py --ts-completer --go-completer && cd -
#echo "Install YCM AUR for autocompletion servers ok"
#if ! yay -Qi vim-youcompleteme-git ; then
    #sudo yay -S vim-youcompleteme-git
#fi
echo "[+][vim] installation complete."
