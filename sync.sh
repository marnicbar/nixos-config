#!/bin/sh

# Credit: https://github.com/librephoenix

# Script to synchronize system state
# with configuration files for nixos system
# and home-manager

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Build system (creates ./result)
nixos-rebuild build --flake $SCRIPT_DIR || exit 1

# Switch to it, unless a switch inhibitor blocks it
if sudo ./result/bin/switch-to-configuration check; then
  sudo nixos-rebuild switch --flake $SCRIPT_DIR;
else
  sudo nixos-rebuild boot --flake $SCRIPT_DIR;
  echo
  echo "NOTICE: The system was NOT switched. Reboot to use the new configuration."
fi

rm -f result
