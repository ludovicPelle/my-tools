#!/bin/bash

echo "[-][xmonad] Begin installation ..."
#gnome debian
#sudo install sudo aptitude install xmonad libghc6-xmonad-dev
#gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string

#kde archlinux
sudo pacman -S xmonad xmonad-contrib
[ ! -e ~/.kde/env ] && mkdir /.kde4/env && echo "export KDEWM=/usr/bin/xmonad" >> ~/.kde4/env/set_window_manager.sh && sudo chmod 777 ~/.kde4/env/set_window_manager.sh

[ ! -e ~/.xmonad ] && ln -s "`pwd`/.xmonad" ~/.xmonad
echo "[+][xmonad] installation complete."
