#!/bin/bash
sudo pacman -S git 
cd ~ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
