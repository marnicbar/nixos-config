{ config, lib, ... }:

{
  imports = [
    ./pc-marius-hw.nix
    ../configuration.nix
    ../users/mbaer.nix
  ];

  networking.hostName = "pc-marius";

  # This machine was first installed with NixOS 26.05 (the shared
  # configuration.nix pins the laptops' original 23.11).
  system.stateVersion = lib.mkForce "26.05";

  # Intel i5-13600KF (Raptor Lake): load current microcode at boot.
  hardware.cpu.intel.updateMicrocode = true;

  # NVIDIA RTX 2060 (Turing, supported by the open kernel modules)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Steam / 32-bit games
  };
  hardware.nvidia = {
    open = true;
    modesetting.enable = true; # Required for GNOME on Wayland
    powerManagement.enable = true; # Preserve VRAM across suspend
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Gaming
  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
