#!/bin/bash
echo "[-][Bash] Begin installation ..."

# we create symbolic links to the config files if they don't already exist, else rename as FILE.DATE.BAK
DATE=$(date "+%Y.%m.%d-%H.%M.%S")

if [ -f ~/.bashrc ];then
    echo "Backup bashrc"
    mv ~/.bashrc ~/.bashrc.$DATE.bak && echo "Rename ~/.bashrc as ~/.bashrc.$DATE.bak"
fi
if [ -f ~/.bash_aliases ];then
    echo "Backup alias"
    mv ~/.bash_aliases ~/.bash_aliases.$DATE.bak && echo "Rename ~/.bash_aliases as ~/.bash_aliases.$DATE.bak"
fi
if [ -f ~/.bash_prompt ];then
    echo "Backup prompt"
    mv ~/.bash_prompt ~/.bash_prompt.$DATE.bak && echo "Rename ~/.bash_prompt as ~/.bash_prompt.$DATE.bak"
fi
if [ -f ~/.bash_profile ];then
    echo "Backup profile"
    mv ~/.bash_profile ~/.bash_profile.$DATE.bak && echo "Rename ~/.bash_profile as ~/.bash_profile.$DATE.bak"
fi

echo "Symlinking From" `pwd`
ln -fs "`pwd`/.bashrc" ~/.bashrc
ln -fs "`pwd`/.bash_aliases" ~/.bash_aliases
ln -fs "`pwd`/.bash_prompt" ~/.bash_prompt
ln -fs "`pwd`/.bash_profile" ~/.bash_profile
source ~/.bashrc

if ! [ -x "$(command -v trash)" ]; then
    echo "Install trash-cli -> soft rm command"
    brew install trash-cli
fi
#add autocompletion
if ! brew list bash-completion; then
    echo "Install bash completion"
    brew install bash-completion
fi
echo "[+][Bash] installation complete."
