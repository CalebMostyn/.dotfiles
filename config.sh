#!/bin/bash

# home directory configs
stow bash/
stow nvim/
stow tmux/
stow fonts/

# / directory configs
sudo stow -t / reflector
