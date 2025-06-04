{ pkgs, lib, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    # Automatically switch between power profiles based on power supply and battery status
    auto-power-profile
  ];
  dconf = {
    enable = true;
    # Find dconf parameters with: dconf watch /
    settings = {
      "system/locale".region = "de_DE.UTF-8";
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/input-sources".show-all-sources = true;
      "org/gnome/desktop/input-sources".sources = [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "de+neo_qwertz"
        ])
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "de"
        ])
      ];
      "org/gnome/desktop/calendar".show-weekdate = true;

      # Power saving and screen settings
      "org/gnome/desktop/lockdown".disable-lock-screen = false; # Enable lock screen
      "org/gnome/desktop/session".idle-delay = 0; # Disable screen blank after
      "org/gnome/desktop/screensaver".lock-enabled = true; # Enable lock screen when blanked (lid closed)
      "org/gnome/desktop/screensaver".lock-delay = 0; # Disable lock delay
      "org/gnome/settings-daemon/plugins/power".idle-dim = false; # Disable screen dimming
      "org/gnome/settings-daemon/plugins/power".power-saver-profile-on-low-battery = false; # Disable power saver profile on low battery
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-battery-type = "suspend"; # Suspend on battery
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-battery-timeout = 900; # 15 minutes
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "suspend"; # Suspend on AC
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-timeout = 1200; # 20 minutes

      "org/gnome/evince/default".continuous = true; # Enable continuous scrolling in PDF viewer

      # Window management
      "org/gnome/mutter".attach-modal-dialogs = false; # Allow movement of modal dialogs (child windows)
      "org/gnome/desktop/interface".enable-hot-corners = false;
      "org/gnome/mutter".edge-tiling = true; # Enable snapping of windows to screen edges
      "org/gnome/mutter".dynamic-workspaces = false; # Fixed number of workspaces
      "org/gnome/desktop/wm/preferences".num-workspaces = 4;
      "org/gnome/mutter".workspaces-only-on-primary = false; # Use workspaces on all displays

      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Console.desktop"
          "org.gnome.Nautilus.desktop"
          "brave-browser.desktop"
        ];
        disable-user-extensions = false;
        enabled-extensions = [
          pkgs.gnomeExtensions.auto-power-profile.extensionUuid
        ];
        disabled-extensions = [ ];
      };
      "org/gnome/shell/extensions/auto-power-profile" = {
        ac = "performance";
        bat = "balanced";
        lapmode = true;
        threshold = 20;
      };
    };
  };
}
