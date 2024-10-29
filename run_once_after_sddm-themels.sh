#!/bin/bash

sudo cp -r $HOME/.config/sddm-theme/sddm-astronaut-theme/ /usr/share/sddm/themes/
sudo cp $HOME/.config/hyde/themes/Tokyo\ Night/wallpapers/mafu_trad_wall.png /usr/share/sddm/themes/sddm-astronaut-theme 
sudo nvim /usr/lib/sddm/sddm.conf.d/default.conf
