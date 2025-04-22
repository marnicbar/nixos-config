{ pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Exclude certain (otherwise preinstalled) packages
  environment.gnome.excludePackages = with pkgs; [
    epiphany    # Web Browser
    gedit       # Text Editor
    simple-scan # Document Scanner
    yelp        # Help Viewer
    geary       # Email Client
    seahorse    # Password Manager
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-maps
    gnome-weather
    gnome-connections
  ];
}
