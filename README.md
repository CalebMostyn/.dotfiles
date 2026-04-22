# Linux Configuration Files
This branch is for Ubuntu, as I've had enough issues trying to keep things the same between Ubuntu and Arch that it warranted seperating. I don't have any nice scripts for tracking and installing packages, as typically that is not needed in Ubuntu. This setup is for Ubuntu 24.04.

# Usage

Run `config.sh` to symlink the dotfiles with GNU Stow.

## Neovim

The main issue I've had linking my installs was Neovim. 24.04's install is out of date, but the latest version causes me a plethora of issues with nvim-treesitter. I have a working configuration for Arch, but for simplicities sake, until I'm on an Ubuntu version that can work with treesitter out of the box, I am pinning nvim at 11.4 and treesitter at working commits.

```bash
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```
