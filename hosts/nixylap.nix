{ pkgs, ... }:

{
  imports = [
    ./nixylap-hw.nix
    ../configuration.nix
    ../users/mbaer.nix
  ];

  networking.hostName = "nixylap";

  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    libwacom
  ];
}
