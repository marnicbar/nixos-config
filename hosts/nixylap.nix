{ pkgs, ... }:

{
  imports = [
    ./nixylap-hw.nix
    ../configuration.nix
    ../users/mbaer.nix
  ];

  networking.hostName = "nixylap";

  environment.systemPackages = with pkgs; [
    libinput
    libwacom
  ];
}
