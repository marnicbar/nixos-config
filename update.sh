#!/bin/sh

# Credit: https://github.com/librephoenix

# Script to update my flake without
# synchronizing configuration

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Update flake
pushd $SCRIPT_DIR &> /dev/null;
nix flake update;
# sudo nix-channel --update;
# nix-channel --update;
popd &> /dev/null;
