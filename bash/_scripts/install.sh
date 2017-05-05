#!/bin/bash

echo "[-][Bash] Begin installation ..."

# we create symbolic links to the config files if they don't already exist
# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")


if [ -h ~/.bashrc ] || [ -e ~/.bash_aliases ]; then
    echo "Backup previous files"
    mv ~/.bashrc ~/.bashrc.$DATE.bak && echo "Rename ~/.bashrc as ~/.bashrc.$DATE.bak"
    mv ~/.bash_aliases ~/.bash_aliases.$DATE.bak && echo "Rename ~/.bash_aliases as ~/.bash_aliases.$DATE.bak"
fi
ln -s "`pwd`/.bashrc" ~/.bashrc
echo `pwd`
ln -s "`pwd`/.bash_aliases" ~/.bash_aliases
source ~/.bashrc

echo "[+][Bash] installation complete."
