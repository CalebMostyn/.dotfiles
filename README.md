# NixOS Configuration Files
I'm still learning here, so *largely* a work in progress. Slowly working in my other configuration files and hopefully transitioning them to home-manager for a more *Nix* approach.

# Usage

To rebuild the NixOS configuration, use the classic command with flake. This is tied to home-manager and will run any configuration setup in `home.nix` as well.

```bash
# My configuration is currently named 'desktop' to match my hostname
sudo nixos-rebuild switch --flake .#desktop
```

Until I have fully Nix-ified my program configurations, run `config.sh` to symlink the dotfiles with GNU Stow.

```bash
./config.sh
```
