{ config, pkgs, lib, ... }:

let
  inherit (lib) mkForce;
  inherit (config.lib.formats.rasi) mkLiteral;
  inherit (config.lib.stylix.colors) base00 base01 base02 base03 base04 base05 base0B base08;
in {
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
    ./modules/sway.nix
    ./modules/sunset.nix
    ./modules/screenshot.nix
    ./modules/clipboard-manager.nix
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
  
  programs.rofi = {
    enable = true;
    
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];
    
    extraConfig = {
      terminal = "foot";
    };
    
    font = mkForce "FiraCode Nerd Font Medium 12";
    
    theme = mkForce {
      "*" = {
        
        #lightbg = mkLiteral "#${base00}";
        #background-color = mkLiteral "#${base00}";
        #lightfg = mkLiteral "#${base01}";
        #foreground-color = mkLiteral "#${base04}";
        #border-color = mkLiteral "#${base01}";
        
        bg0 = mkLiteral "#${base00}";
        bg1 = mkLiteral "#${base01}";
        fg0 = mkLiteral "#${base04}";
        
        accent-color = mkLiteral "#${base0B}";
        urgent-color = mkLiteral "#${base08}";
        
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        
        margin = 0;
        padding = 0;
        spacing = 0;
        
      };
      
      window = {
      	location = mkLiteral "center";
      	width = 800;
      	background-color = mkLiteral "@bg0";
      };
      
      inputbar = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "8px";
        background-color = mkLiteral "@bg1";
      };
      
      "prompt, entry, element-icon, element-text" = {
        vertical-align = mkLiteral "0.5";
      };
      
      prompt = {
      	text-color = mkLiteral "@accent-color";
      };
      
      textbox = {
        padding = mkLiteral "8px";
        background-color = mkLiteral "@bg1";
      };
      
      listview = {
        padding = mkLiteral "4px 0";
        lines = 15;
        columns = 1;
        fixed-height = true;
      };
      
      element = {
        padding = mkLiteral "8px";
        spacing = mkLiteral "8px";
      };
      
      "element normal normal" = {
        text-color = mkLiteral "@fg0";
      };
      
      "element normal urgent" = {
        text-color = mkLiteral "@urgent-color";
      };
      
      "element normal active" = {
        text-color = mkLiteral "@accent-color";
      };
      
      "element selected" = {
        text-color = mkLiteral "@bg0";
      };
      
      "element selected normal, element selected active" = {
        background-color = mkLiteral "@accent-color";
      };
      
      "element selected urgent" = {
        background-color = mkLiteral "@urgent-color";
      };
      
      element-icon = {
        size = mkLiteral "0.8em";
      };
      
      element-text = {
        text-color = mkLiteral "inherit";
      };
      
      

      
      #element-icon = {vertical-align = 0.5;};
      #element-text = {vertical-align = 0.5;};
      
      

    
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    pinentry-gnome3

    foot             # Wayland terminal emulator
    calcurse         # Text-based calendar and scheduling application
    pavucontrol      # PulseAudio Volume Control
    alacritty
    rofi-power-menu
    networkmanager_dmenu

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
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
# gtk = {
#  enable = true;
#  theme = {
#    name = "gruvbox-dark";
#    package = pkgs.gruvbox-dark-gtk;
#  };
#};

gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = "1";
      
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = "1";
    };
  };

 
}
