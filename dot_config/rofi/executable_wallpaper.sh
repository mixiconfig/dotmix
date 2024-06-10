#!/bin/bash
#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
blurred="$HOME/.cache/blurred_wallpaper.png"
square="$HOME/.cache/square_wallpaper.png"
rasi_file="$HOME/.cache/current_wallpaper.rasi"
blur_file="$HOME/.config/rofi/blur.sh"

blur="50x30"
blur=$(cat $blur_file)

# Create cache file if not exists
if [ ! -f $cache_file ]; then
	touch $cache_file
	echo "$HOME/wallpaper/default.jpg" >"$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ]; then
	touch $rasi_file
	echo "* { current-image: url(\"$HOME/wallpaper/default.jpg\", height); }" >"$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in

# Load wallpaper from .cache of last session
"init")
	sleep 1
	if [ -f $cache_file ]; then
		swww img $current_wallpaper -t grow
	else
		swww img ~/wallpaper/$current_wallpaper
	fi
	;;

# Select wallpaper with rofi
"select")
	sleep 0.2
	selected=$(find "$HOME/wallpaper" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile; do
		echo -en "$rfile\x00icon\x1f$HOME/wallpaper/${rfile}\n"
	done | rofi -dmenu -i -replace -config ~/.config/rofi/config-wallpaper.rasi)
	if [ ! "$selected" ]; then
		echo "No wallpaper selected"
		exit
	fi
	swww img ~/wallpaper/$selected -t random
	;;

# Randomly select wallpaper
*)
	wal -q -i ~/wallpaper/
	;;

esac

# -----------------------------------------------------
# get wallpaper image name
# -----------------------------------------------------
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# -----------------------------------------------------
# Set the new wallpaper
# -----------------------------------------------------
transition_type="grow"
# transition_type="outer"
# transition_type="random"

wallpaper_engine=$(cat $HOME/.config/rofi/wallpaper-engine.sh)
if [ "$wallpaper_engine" == "swww" ]; then
	# swww
	echo ":: Using swww"

	swww img $wallpaper -t grow

elif [ "$wallpaper_engine" == "hyprpaper" ]; then
	# hyprpaper
	echo ":: Using hyprpaper"
	killall hyprpaper
	wal_tpl=$(cat $HOME/.config/rofi/hyprpaper.tpl)
	output=${wal_tpl//WALLPAPER/$wallpaper}
	echo "$output" >$HOME/.config/hypr/hyprpaper.conf
	hyprpaper &
else
	echo ":: Wallpaper Engine disabled"
fi

if [ "$1" == "init" ]; then
	echo ":: Init"
else
	sleep 1
	dunstify "Changing wallpaper ..." "with image $newwall" -h int:value:25 -h string:x-dunst-stack-tag:wallpaper

	# -----------------------------------------------------
	# Reload Hyprctl.sh
	# -----------------------------------------------------
	$HOME/.config/rofi/hyprctl.sh &
fi

# -----------------------------------------------------
# Write selected wallpaper into .cache files
# -----------------------------------------------------
echo "$wallpaper" >"$cache_file"
echo "* { current-image: url(\"$blurred\", height); }" >"$rasi_file"

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------

if [ "$1" == "init" ]; then
	echo ":: Init"
else
	dunstify "Wallpaper procedure complete!" "with image $newwall" -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"
