{ pkgs, ... }:

{
  imports = [
    ./fw1325-hw.nix
    ../configuration.nix
    ../users/mbaer.nix
  ];

  boot.initrd.luks.devices."luks-386a2543-da8e-4ce0-a656-91c21aecd55e".device =
    "/dev/disk/by-uuid/386a2543-da8e-4ce0-a656-91c21aecd55e";

  networking.hostName = "fw1325";

  services.fwupd.enable = true;

  # Track the latest Linux kernel release for improved hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable fingerprint reader support
  # VERY buggy! This inserts some key, when logging in or decrypting the drive
  # This leads to a wrong passphrase and one can't log in.
  # services.fprintd.enable = true;
}
