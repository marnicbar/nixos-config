# NixOS configuration for my personal computers

## Rebuild the configuration

`sudo nixos-rebuild switch --flake .`

## Update the flake and rebuild

`nix flake update; sudo nixos-rebuild switch --flake .`

or

`bash upgrade.sh`
