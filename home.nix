{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) mkForce;
  inherit (config.lib.formats.rasi) mkLiteral;
  inherit (config.lib.stylix.colors)
    base00
    base01
    base02
    base03
    base04
    base05
    base0B
    base08
    ;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sphink";
  home.homeDirectory = "/home/sphink";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  xdg.enable = true;

  imports = [
    ./modules-home/desktop-wayland-sway.nix
    ./modules-home/sunset-wayland-wlsunset.nix
    ./modules-home/screenshot-wayland-grimshot.nix
    ./modules-home/clipboard-any-cliphist.nix
    ./modules-home/menu-wayland-rofi.nix
    ./modules-home/lock-wayland-swaylock.nix
    # ./modules/cursor-any-vanilladmz.nix
  ];

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Diego Pereyra";
    userEmail = "diesphink@gmail.com";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    pinentry-gnome3

    calcurse # Text-based calendar and scheduling application
    pavucontrol # PulseAudio Volume Control
    rofi-power-menu
    networkmanager_dmenu
    blueman
    pkgs.vscode.fhs
    blanket
    keepassxc
    fastfetch
    telegram-desktop
    obsidian

    # qt6ct
    # qt6Packages.qt6gtk2

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sphink/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
  };

  qt = {
    enable = true;
    # platformTheme.name = "qt5ct";
    style.name = "Adwaita-Dark";
  };

  programs.alacritty = {
    enable = true;
  };

  # qt.enable = true;

  # gtk = {
  #  enable = true;
  #  theme = {
  #    name = "gruvbox-dark";
  #    package = pkgs.gruvbox-dark-gtk;
  #  };
  #};

  #gtk = {
  #    enable = true;

  #    iconTheme = {
  #      name = "Papirus-Dark";
  #      package = pkgs.papirus-icon-theme;
  #    };

  #    cursorTheme = {
  #      name = "Numix-Cursor";
  #      package = pkgs.numix-cursor-theme;
  #    };

  #    gtk3.extraConfig = {
  #      gtk-application-prefer-dark-theme = "1";
  #      
  #    };

  #    gtk4.extraConfig = {
  #      gtk-application-prefer-dark-theme = "1";
  #    };
  #  };
}
