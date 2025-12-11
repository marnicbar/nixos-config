{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mbaer = {
    isNormalUser = true;
    description = "Marius Bär";
    shell = pkgs.nushell;
    # wheel -> Enable ‘sudo’ for the user.
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
  home-manager = {
    users.mbaer = {
      imports = [ ../home.nix ];
      programs.git.settings.user = {
        name = "Marius Bär";
        email = "marius.baer@proton.me";
      };
    };
  };
}
