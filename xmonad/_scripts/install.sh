#!/bin/bash

echo "[-][xmonad] Begin installation ..."
sudo install sudo aptitude install xmonad libghc6-xmonad-dev
gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string
[ ! -e ~/.xmonad ] && ln -s "`pwd`/.xmonad" ~/.xmonad
echo "[+][xmonad] installation complete."
