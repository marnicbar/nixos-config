{ ... }:
{
  dconf = {
    enable = true;
    # Find dconf parameters with: dconf watch /
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/evince/default".continuous = true;
      "org/gnome/desktop/calendar".show-weekdate = true;
      "system/locale".region = "de_DE.UTF-8";
    };
  };
}
