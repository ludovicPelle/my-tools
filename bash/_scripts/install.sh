#!/bin/bash

echo "[-][Bash] Begin installation ..."

# we create symbolic links to the config files if they don't already exist
# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")


if [ -f ~/.bashrc ];then
    echo "Backup previous files"
    mv ~/.bashrc ~/.bashrc.$DATE.bak && echo "Rename ~/.bashrc as ~/.bashrc.$DATE.bak"
fi
if [ -f ~/.bash_aliases ]; then
    mv ~/.bash_aliases ~/.bash_aliases.$DATE.bak && echo "Rename ~/.bash_aliases as ~/.bash_aliases.$DATE.bak"
fi
if [ -f ~/.bash_prompt ];then
    echo "Backup previous files"
    mv ~/.bash_prompt ~/.bash_prompt.$DATE.bak && echo "Rename ~/.bash_prompt as ~/.bash_prompt.$DATE.bak"
fi
echo "From" `pwd`
ln -fs "`pwd`/.bashrc" ~/.bashrc
ln -fs "`pwd`/.bash_aliases" ~/.bash_aliases
ln -fs "`pwd`/.bash_prompt" ~/.bash_prompt
source ~/.bashrc


if ! [ -x "$(command -v trash)" ]; then
    sudo pacman -S trash-cli
fi
#add autocompletion
sudo pacman -S bash-completion

echo "[+][Bash] installation complete."
