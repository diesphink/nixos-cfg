{config, pkgs, lib, ...}:
{
  # ========
  # Packages
  # ========
  home.packages = with pkgs; [
    jq			# keyboard-toggle		
    gron		# keyboard-toggle
    libnotify		# keyboard-toggle
    rofi
    nwg-drawer
    nwg-displays
    swaynotificationcenter
    waybar
    autotiling
    
    (writeShellScriptBin "sph-keyboard-toggle" ''
      swaymsg input $(swaymsg -t get_inputs --raw | jq '[.[] | select(.type == "keyboard")][0] | .identifier') xkb_switch_layout next

      VALUE=$(swaymsg -t get_inputs --raw | gron | grep xkb_active_layout_name | sed 's/.*"\(.*\)";/\1/' | head -n 1 )

      notify-send \
          --expire-time 800 \
          --hint "int:transient:1" \
          --category "hud" \
          "Keyboard" \
          "Current layout: <b>󰌌  $VALUE</b>"
          '')
  ];
  
  # =====
  # Files
  # =====
  home.file = {
    ".config/swaync" = {
      source = ./swaync;
      recursive = true;
    };
  };
  
  # ========
  # Sway cfg
  # ========  
  wayland.windowManager.sway = {
    enable = true;
    config = {
    
      # ==============
      # Behavior stuff
      # ==============
      modifier = "Mod4";
     
      focus.followMouse = false;
     
      # ==========
      # Appearance
      # ==========
      gaps.inner = 4;
      gaps.smartGaps = false;
      bars = [];
      window.titlebar = false;
      
      # ============
      # Key bindings
      # ============
      bindkeysToCode = true;
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+space" = "exec ${pkgs.rofi}/bin/rofi -show combi -combi-modi 'drun' -show-icons";
        "${modifier}+Shift+space" = "exec ${pkgs.nwg-drawer}/bin/nwg-drawer";
        "${modifier}+backspace" = "exec sph-keyboard-toggle"; 
      };
     
      input = {
        "type:keyboard" = {
          xkb_layout = "br,us";
          xkb_variant = ",alt-intl";
          xkb_options = "grp:shift_caps_toggle";
          xkb_model = "pc105";
        };
      };
      
      # ===============
      # Window commands
      # ===============
      window.commands = [
        { criteria = { app_id = "nwg-displays"; }; command = "floating enable"; }
      ];
      
      # ====================
      # Startup applications
      # ====================
      
      startup = [
      	{ command = "firefox"; }
      	{ command = "autotiling"; }
      ];
      
    };
    
    # =======================================================
    # Extra configurations (keyboard, etc, set by other apps)
    # =======================================================
    extraConfig = ''
    # Extra configurations defined by nwg-displays
    include outputs
    '';
    
  };
}
