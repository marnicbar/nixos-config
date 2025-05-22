{ pkgs, ... }:
{
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
}
