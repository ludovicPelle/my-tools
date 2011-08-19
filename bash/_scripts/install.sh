#!/bin/bash

echo "[-][Bash] Begin installation ..."

# we create symbolic links to the config files if they don't already exist
[ ! -e ~/.bashrc ] && ln -s "`pwd`/.bashrc" ~/.bashrc
echo `pwd`
[ ! -e ~/.bash_aliases ] && ln -s "`pwd`/.bash_aliases" ~/.bash_aliases

echo "[+][Bash] installation complete."
