#!/bin/bash
sudo pacman -S git base-devel
cd ~ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
