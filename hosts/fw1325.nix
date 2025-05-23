{ pkgs, ... }:

{
  imports = [
    # ./nixylap-hw.nix
    ../configuration.nix
    ../users/mbaer.nix
  ];

  networking.hostName = "fw1325";

  services.fwupd.enable = true;

  # Track the latest Linux kernel release for improved hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable fingerprint reader support
  services.fprintd.enable = true;
}
