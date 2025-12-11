{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-winboat.url = "nixpkgs/ffcdcf99d65c61956d882df249a9be53e5902ea5";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-winboat,
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
      pkgs-winboat = import nixpkgs-winboat {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
        inherit pkgs-winboat;
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
