#!/bin/bash
set -e

packages=$(grep -v '^#' packages.conf | tr '\n' ' ')
echo "Installing Arch Packages: $packages"
sudo pacman -S --needed $packages

# install yay if not already
if [ ! command -v yay &> /dev/null ]; then
    echo "No yay installation detected, building from source"
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    sudo pacman -S base-devel
    makepkg -si
    cd ../ && rm -rf yay-bin
fi

aur_packages=$(grep -v '^#' packages-aur.conf | tr '\n' ' ')
echo "Installing AUR Packages: $aur_packages"
yay -S --needed $aur_packages

# install git autocomplete script
if [ ! -f ~/.git-completion.bash ]; then
    echo "Getting git bash autocomplete script"
    curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi

# setup python venv for konsave
if [ ! -d kde/venv/ ]; then
    cd kde/ && python -m venv venv && source venv/bin/activate && pip install konsave && cd -
fi
# import dumped kde profile, apply
source kde/venv/bin/activate && konsave -r caleb && konsave -i kde/caleb.knsv && konsave -a caleb && deactivate

# run services
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now firewalld
sudo systemctl enable --now bluetooth
sudo systemctl enable --now sddm # login
sudo systemctl enable --now sshd # ssh
sudo systemctl enable --now docker # ssh
# update arch mirrors
sudo systemctl enable reflector # run on boot
sudo systemctl enable --now reflector.timer # run on timer

# add user to docker group
sudo usermod -aG docker $USER
