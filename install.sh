#!/bin/bash
set -e

if [ $1 == '-h' ]; then
    echo "$0 [-d --dry-run] [-a --arch] [-y --yay] [-n --no-install]"
    echo "-d : dry run, no actual install or modifications made"
    echo "-a : arch packages only"
    echo "-y : yay packages only"
    echo "-n : no package installs, only runs other setup steps"
    exit 0
fi

DRY_RUN=0
ARCH_ONLY=0
YAY_ONLY=0
NO_PACKAGES=0

for arg in "$@"; do
    if [[ $arg == "-d" || $arg == "--dry-run" ]]; then
        DRY_RUN=1
    elif [[ $arg == "-a" || $arg == "--arch" ]]; then
        ARCH_ONLY=1
    elif [[ $arg == "-y" || $arg == "--yay" ]]; then
        YAY_ONLY=1
    elif [[ $arg == "-n" || $arg == "--no-install" ]]; then
        NO_PACKAGES=1
    else
        echo "Unrecognized argument : $arg"
    fi
done

CMD_PREFIX=""
if [ $DRY_RUN -eq 1 ]; then
    CMD_PREFIX="echo"
fi

if [[ ! $YAY_ONLY -eq 1 && ! $NO_PACKAGES -eq 1 ]]; then
    packages=$(grep -v '^#' packages.conf | tr '\n' ' ')
    echo "Installing Arch Packages:"
    echo "========================="
    echo "$packages"
    echo "========================="
    $CMD_PREFIX sudo pacman -S --needed $packages
    echo
fi

if [[ ! $ARCH_ONLY -eq 1 && ! $NO_PACKAGES -eq 1 ]]; then
    # install yay if not already
    if [ ! command -v yay &> /dev/null ]; then
        echo "No yay installation detected, building from source"
        echo "=================================================="
        $CMD_PREFIX git clone https://aur.archlinux.org/yay-bin.git
        $CMD_PREFIX cd yay-bin
        $CMD_PREFIX sudo pacman -S base-devel
        $CMD_PREFIX makepkg -si
        $CMD_PREFIX bash -c 'cd ../ && rm -rf yay-bin'
        echo
    fi
    
    aur_packages=$(grep -v '^#' packages-aur.conf | tr '\n' ' ')
    echo "Installing AUR Packages:"
    echo "========================"
    echo $aur_packages
    echo "========================"
    $CMD_PREFIX yay -S --needed $aur_packages
    echo
fi

# install git autocomplete script
if [ ! -f ~/.git-completion.bash ]; then
    echo "Getting git bash autocomplete script"
    echo "===================================="
    $CMD_PREFIX curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    echo
fi

# setup python venv for konsave
if [ ! -d kde/venv/ ]; then
    echo "No venv detected, installing konsave"
    echo "===================================="
    $CMD_PREFIX bash -c 'cd kde/ && python -m venv venv && source venv/bin/activate && pip install konsave && cd -'
    echo
fi
# import dumped kde profile, apply
echo "Importing and applying kde profile"
echo "=================================="
$CMD_PREFIX bash -c 'source kde/venv/bin/activate && konsave -r caleb && konsave -i kde/caleb.knsv && konsave -a caleb && deactivate'
echo

# run services
echo "Running systemd services"
echo "========================"
$CMD_PREFIX sudo systemctl enable --now NetworkManager
$CMD_PREFIX sudo systemctl enable --now firewalld
$CMD_PREFIX sudo systemctl enable --now bluetooth
$CMD_PREFIX sudo systemctl enable --now sddm # login
$CMD_PREFIX sudo systemctl enable --now sshd # ssh
$CMD_PREFIX sudo systemctl enable --now docker # ssh
# update arch mirrors
$CMD_PREFIX sudo systemctl enable reflector # run on boot
$CMD_PREFIX sudo systemctl enable --now reflector.timer # run on timer
echo

# add user to docker group
if ! id -nG "$USER" | grep -qw "docker"; then
    echo "Adding user to docker group"
    echo "========================"
    $CMD_PREFIX sudo usermod -aG docker $USER
    echo
fi
