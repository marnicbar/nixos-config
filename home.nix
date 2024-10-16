{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
      ./user/app/sync/syncthing.nix
      ./user/app/sync/onedrive.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mbaer";
  home.homeDirectory = "/home/mbaer";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    _1password-gui
    brave
    cmake
    doxygen
    gcc-arm-embedded
    gcc12
    git
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    inkscape
    libreoffice-qt
    magic-wormhole
    mailspring
    mono
    nixd
    obsidian
    octaveFull
    stlink
    stm32cubemx
    typst
    typst-lsp
    vim
    vscode
  ];

  programs.git = {
    enable=true;
    userName="Marius Bär";
    userEmail = "marius.baer@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = (with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-vscode-remote.remote-containers
      myriad-dreamin.tinymist
      # (nixpkgs-unstable.vscode-extensions.github.copilot)
    ]) ++ (with pkgs-unstable.vscode-extensions; [
      github.copilot
      github.copilot-chat
    ]);
    userSettings = {
      "window.zoomLevel" = 1;
      # Disable automatic updates of extensions
      "extensions.autoUpdate" = false;
      # Enable language server for code completion with nixd
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
