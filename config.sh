#!/bin/bash

# home directory configs
stow tmux/
stow nvim/
stow fonts/

# / directory configs
sudo stow -t / reflector
