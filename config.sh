#!/bin/bash

# home directory configs
stow bash/
stow gdb/
stow btop/
stow nvim/
stow tmux/
stow fonts/
rm ~/.config/ghostty/config.ghostty # will conflict on first run
stow ghostty/
stow wallpaper/
