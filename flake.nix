{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-matlab.url = "gitlab:doronbehar/nix-matlab";
    nix-matlab.inputs.nixpkgs.follows = "nixpkgs";
  };

  # self was not used
  outputs = {nixpkgs, home-manager, nix-matlab, ...}:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      flake-overlays = [
        nix-matlab.overlay
      ];
    in {
    nixosConfigurations = {
      nixylap = lib.nixosSystem {
        inherit system;
        modules = [ (import ./configuration.nix flake-overlays) ];
      };
    };
    homeConfigurations = {
      mbaer = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
}
