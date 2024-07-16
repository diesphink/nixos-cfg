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
    ./modules-home/firefox.nix
    # ./modules/cursor-any-vanilladmz.nix
    ./modules-home/atuin.nix
    ./modules-home/wallpaper.nix
    ./modules-home/mime-types.nix
    ./modules-home/shell-any-zsh.nix
    ./modules-home/devel.nix
    ./modules-home/calibre.nix
    ./modules-home/liferea.nix
  ];

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
  };

  #programs.direnv = {
  #  enable = true;
  #};
  programs.direnv.nix-direnv.enable = true;

  programs.git = {
    enable = true;
    userName = "Diego Pereyra";
    userEmail = "diesphink@gmail.com";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      rebase.autoStash = true;
    };
  };

  programs.btop.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [

    appimage-run
    baobab
    bat
    boxes
    blanket
    cava
    dbeaver-bin
    ddcutil
    dialect
    duf
    easytag
    eclipses.eclipse-committers
    electrum
    encfs
    evince
    eza
    fastfetch
    freecad
    fstl
    fstl
    gimp
    git
    git-crypt
    gnome-podcasts
    gnome-text-editor
    gnome.eog
    gnome.file-roller
    gnome.gnome-disk-utility
    gnome.nautilus
    gnupg
    google-chrome
    gping
    grsync
    handbrake
    htop
    hyprpicker
    inkscape
    irpf
    keepassxc
    lazygit
    libreoffice
    lightburn
    meld
    minder
    ncdu
    networkmanager_dmenu
    nicotine-plus
    niv
    nmap
    obsidian
    paperwork
    pavucontrol # PulseAudio Volume Control
    pdfarranger
    picard
    pinentry-gnome3
    planner
    plexamp
    prusa-slicer
    remmina
    ripgrep
    ripgrep-all
    rofi-power-menu
    screen
    setzer
    shotwell
    silver-searcher
    smartgithg
    snapshot
    steam
    stremio
    stylish
    teams-for-linux
    teamviewer
    telegram-desktop
    texstudio
    tldr
    transmission-gtk
    unzip
    virt-manager
    vlc
    whois
    zoom-us
    boxbuddy
    distrobox

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

  xdg.desktopEntries = {
    fstl = {
      name = "fstl";
      genericName = "A very fast STL file viewer";
      exec = "fstl %U";
      terminal = false;
      categories = [ "Application" ];
      mimeType = [ "model/stl" ];
    };
  };

  programs.z-lua = {
    enable = true;
    enableBashIntegration = true;
  };

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
    # platformTheme.name = "gtk2";
    style.name = "Adwaita-dark";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.dimensions = {
        lines = 40;
        columns = 150;
      };
    };
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

  # xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {

    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };

    keybindings = {

      "\\\"" = "";
      o = "";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";

      do = "dragon-out";

      "g~" = "cd";
      gh = "cd";
      "g/" = "/";

      ee = "editor-open";
      V = ''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';

      # ...
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig =
      let
        previewer = pkgs.writeShellScriptBin "pv.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
          fi

          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in
      ''
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${previewer}/bin/pv.sh
      '';
  };

}
