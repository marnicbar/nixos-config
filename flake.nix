{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Pinned to the merge commit of PR #9701 (nushell direnv hook fix), used
    # only to source a single module file until the fix is backported to
    # release-26.05. `flake = false` means we consume it as a plain source tree.
    home-manager-direnv-fix = {
      url = "github:nix-community/home-manager/32de400b6ac9f43042bca706f4a64f6ad08117e8";
      flake = false;
    };
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
          # winboat bundles Electron 40, which is now EOL/insecure upstream.
          permittedInsecurePackages = [ "electron-40.10.5" ];
        };
      };
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
      };
      sharedModules = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    in
    {
      nixosConfigurations = {
        nixylap = lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ [ ./hosts/nixylap.nix ];
          inherit specialArgs;
        };
        fw1325 = lib.nixosSystem {
          inherit system;
          modules = sharedModules ++ [
            ./hosts/fw1325.nix
            nixos-hardware.nixosModules.framework-amd-ai-300-series
          ];
          inherit specialArgs;
        };
      };
    };
}
