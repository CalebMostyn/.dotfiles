#!/bin/bash

# home directory configs
stow bash/
stow btop/
stow nvim/
stow tmux/
stow fonts/

# / directory configs
sudo stow -t / reflector/
