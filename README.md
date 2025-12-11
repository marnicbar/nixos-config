# NixOS configuration for my personal computers

## Rebuild the configuration

`sudo nixos-rebuild switch --flake .`

## Update the flake and rebuild

`nix flake update; sudo nixos-rebuild switch --flake .`

or

`bash upgrade.sh`

## Remove old system generations

`sudo nix-collect-garbage --delete-older-than 30d`

## Compare the current system configuration with the previous (NuShell)

`nvd diff ...(ls /nix/var/nix/profiles/system-*-link | last 2 | get name)`

# Configuration for specific applications

## Octave
Octave stores its configuration in the ini-file `~/nixos-config/octave-gui.ini`. This configuration file includes configuration for UI colors, font, language etc. but it also includes the state of the application like opened files. Home Assistant is not able to merge just the color configuration into an existing file.

Copy the file [octave-gui.ini](./user/app/octave-gui.ini) into the above mentioned directory before the first launch of octave. Octave will use this configuration and add state data afterwards. This file included configuration for a dark theme because the Octave defaults are awful.
