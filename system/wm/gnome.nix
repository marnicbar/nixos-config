{ config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome = {
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

  # Allow Electron and Chromium applications to run without Xwayland under Wayland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # `nixos-rebuild switch` restarts changed *user* units, and GNOME Shell's unit
  # (org.gnome.Shell@.service) hardcodes the gnome-shell store path. Any nixpkgs
  # bump that rebuilds gnome-shell - even without a version change - therefore
  # kills the running Wayland session mid-switch, which in turn can abort the
  # switch before stopped system services (NetworkManager!) are started again.
  # Refuse to switch in that case; use `nixos-rebuild boot` + reboot instead, or
  # set NIXOS_NO_CHECK=1 to switch anyway.
  system.switch.inhibitors.gnome-shell = "${pkgs.gnome-shell}";

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
