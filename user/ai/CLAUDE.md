# System
- OS: NixOS
- WM: Gnome
- Shell: nushell (nu)
- Package management: nix flakes + home-manager
- Use `nix shell` to get/use software not installed on the system
- NOT installed: `gh`, `python3`, `npm`. Do not invoke these directly. Use `nix shell nixpkgs#<pkg>` if one is needed, or another approach (e.g. WebFetch/curl instead of gh).
