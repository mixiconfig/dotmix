#!/bin/bash
if [ ! -d "/usr/bin/zsh" ]; then
	echo "Adding zsh as default shell"
	chsh -s /usr/bin/zsh
else
	echo ".oh-my-zsh already found, skipping."
fi
