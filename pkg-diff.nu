#!/usr/bin/env nu

let versions = (ls /nix/var/nix/profiles/system-*-link | last 2 | get name)
nvd diff ...$versions

