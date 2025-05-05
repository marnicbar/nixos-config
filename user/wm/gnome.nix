{ pkgs, ... }:
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
      "org/gnome/desktop/calendar".show-weekdate = true;
      "org/gnome/desktop/interface".enable-hot-corners = false;
      "org/gnome/evince/default".continuous = true;
      "org/gnome/mutter".edge-tiling = true;

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          pkgs.gnomeExtensions.auto-power-profile.extensionUuid
        ];
        disabled-extensions = [];
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
