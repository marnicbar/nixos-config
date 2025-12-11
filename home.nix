{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-winboat,
  ...
}:

{
  imports = [
    ./user/app/sync/syncthing.nix
    ./user/app/sync/onedrive.nix
    ./user/wm/gnome.nix
  ];

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
  home.packages =
    (with pkgs; [
      _1password-gui
      anki-bin
      cm_unicode
      distrobox
      drawio
      doxygen
      freecad-wayland
      gcc-arm-embedded
      gcc12
      gnuradio
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_US
      inkscape
      kdePackages.okular
      magic-wormhole
      mono
      mpv # for audio playback in Anki
      musescore
      nixd
      nixfmt-rfc-style
      nvd
      obsidian
      (octaveFull.withPackages (
        ps: with ps; [
          signal
          communications
        ]
      ))
      onlyoffice-desktopeditors
      recoll
      rnote
      rustdesk-flutter # Use rustdesk-flutter over rustdesk because the latter uses unfree components and therefore won't be cached by hydra.
      signal-desktop
      stlink
      stm32cubemx
      thunderbird
      vim
      xkeyboard_config
      zotero
    ])
    ++ (with pkgs-unstable; [
      vscode
      qucs-s
      typst
    ])
    ++ (with pkgs-winboat; [
      winboat
    ]);

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
      { id = "jdbnofccmhefkmjbkkdkfiicjkgofkdh"; } # bookmark sidebar
    ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "libsecret";
    };
    aliases = {
      lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      lg = "lg1";
    };
  };

  programs.nushell = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;
    profiles = {
      default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions =
          (with pkgs.vscode-extensions; [
            # Stable extensions
          ])
          ++ (with pkgs-unstable.vscode-extensions; [
            jnoortheen.nix-ide
            ms-vscode-remote.remote-containers
            ms-vscode-remote.remote-ssh
            myriad-dreamin.tinymist
            github.copilot
            github.copilot-chat
            github.vscode-github-actions
            streetsidesoftware.code-spell-checker
            streetsidesoftware.code-spell-checker-german
          ]);
        userSettings = {
          "window.zoomLevel" = 0;
          # Disable automatic updates of extensions
          "extensions.autoUpdate" = false;
          # Enable language server for code completion with nixd
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.formatterPath" = "nixfmt";
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [ "nixfmt" ];
              };
            };
          };
          "tinymist.formatterMode" = "typstyle";
          "cSpell.language" = "en,de-de";
        };
      };
    };
  };
}
