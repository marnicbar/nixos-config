# System
- OS: NixOS
- WM: Gnome
- Shell: nushell (nu)
- Package management: nix flakes + home-manager
- Use `nix shell` to get/use software not installed on the system
- NOT installed: `python3`, `npm`. Do not invoke these directly. Use `nix shell nixpkgs#<pkg>` if one is needed, or another approach.
