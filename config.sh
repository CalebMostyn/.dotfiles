#!/bin/bash

# home directory configs
rm ~/.bashrc # will conflict on first run
stow bash/
stow btop/
stow nvim/
stow tmux/
stow fonts/

# / directory configs
sudo stow -t / reflector/
