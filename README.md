# Linux Configuration Files
These are my Arch Linux configuration files. Currently each set of configuration files is isolated to a folder that can be symlinked
with GNU stow. Ideally at some point I will have fully automated my configuration.

Out of date Nix-Os configuration files are on a branch titled `nix-os`, just in case.

# Usage

Run `config.sh` to symlink the dotfiles with GNU Stow. Ideally run this before the install script, at least the first time, for files like the wallpaper and fonts.

Run `install.sh` to install all of the packages in `packages.conf` and `packages-aur.conf`

Run `update_packages.py` to sync current packages with .conf files.
