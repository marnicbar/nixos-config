{ config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides =
        if config.networking.hostName == "fw1325" then
          ''
            [org.gnome.mutter]
            experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
          ''
        else
          '''';
    };
  };

  # Allow Electron and Chromium applications to run without Xwayland under Wayland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Exclude certain (otherwise preinstalled) packages
  environment.gnome.excludePackages = with pkgs; [
    epiphany # Web Browser
    gedit # Text Editor
    simple-scan # Document Scanner
    yelp # Help Viewer
    geary # Email Client
    seahorse # Password Manager
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-maps
    gnome-weather
    gnome-connections
  ];
}
