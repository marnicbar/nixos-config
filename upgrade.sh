#!/bin/sh

# Credit: https://github.com/librephoenix

# Script to update system and sync
# Does not pull changes from git

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Ask for root password
sudo -v

# Update flake
$SCRIPT_DIR/update.sh;

# Synchronize system
$SCRIPT_DIR/sync.sh;
