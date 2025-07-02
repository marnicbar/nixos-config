{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
