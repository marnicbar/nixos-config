flake-overlays:

{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./hardware-configuration.nix ./system/wm/gnome.nix ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable caching for Hyprland
  nix.settings = {
    substituters = ["https://cache.nixos.org/" "https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixylap"; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networkmanager

  # Set time zone
  time.timeZone = "Europe/Berlin";

  # Enable the X11 windowing system for xwayland.
  services.xserver.enable = true;

  # Configure keyboard settings
  services.xserver.xkb = {
    layout = "de";
    variant = "neo_qwertz";
  };

  virtualisation.docker = {
    enable = true;
  };

  # Enable the onedrive service
  services.onedrive.enable = true;

  nixpkgs.overlays = [
    (final: prev: {

    })
  ] ++ flake-overlays;

  # Enable the printing service and network printer autodiscovery.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Allow any user read/write access to ADI PlutoSDR devices
  services.udev.extraRules = ''
    # DFU Device
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0456", ATTRS{idProduct}=="b674", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2fa2", ATTRS{idProduct}=="5a32", MODE="0666"
    # SDR Device
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0456", ATTRS{idProduct}=="b673", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2fa2", ATTRS{idProduct}=="5a02", MODE="0666"
    # tell the ModemManager (part of the NetworkManager suite) that the device is not a modem, 
    # and don't send AT commands to it
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0456", ATTRS{idProduct}=="b673", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2fa2", ATTRS{idProduct}=="5a02", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mbaer = {
    isNormalUser = true;
    shell = pkgs.nushell;
    # wheel -> Enable ‘sudo’ for the user.
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    epson-escpr # Epson printer driver
    home-manager
    libinput
    libwacom
    matlab
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
