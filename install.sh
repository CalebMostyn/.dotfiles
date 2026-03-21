#!/bin/bash
set -e

packages=$(grep -v '^#' packages.txt | tr '\n' ' ')
echo "Installing Arch Packages: $packages"
sudo pacman -S $packages

# install yay if not already
if [ ! command -v yay &> /dev/null ]; then
    echo "No yay installation detected, building from source"
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    sudo pacman -S base-devel
    makepkg -si
    cd ../ && rm -rf yay-bin
fi

aur_packages=$(grep -v '^#' packages-aur.txt | tr '\n' ' ')
echo "Installing AUR Packages: $aur_packages"
yay -S $aur_packages

# install git autocomplete script
curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# run services
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
sudo systemctl enable --now sddm # login
sudo systemctl enable --now sshd # ssh
# update arch mirrors
sudo systemctl enable reflector # run on boot
sudo systemctl enable --now reflector.timer # run on timer
