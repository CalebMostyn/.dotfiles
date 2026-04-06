#!/bin/bash

# home directory configs
rm ~/.bashrc # will conflict on first run
stow bash/
stow btop/
stow nvim/
stow tmux/
stow fonts/
rm ~/.config/ghostty/config.ghostty # will conflict on first run
stow ghostty/
stow wallpaper/

# / directory configs
sudo stow -t / reflector/
