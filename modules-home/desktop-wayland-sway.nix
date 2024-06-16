# ==================================
# Configuration for sway
# It contains sway configuration, notification center alternative for sway, status bar, auto-tiling, and some scripts
# ==================================

{
  config,
  pkgs,
  lib,
  ...
}:
let

  inherit (lib) mkForce;
  inherit (config.lib.stylix.colors)
    base00
    base03
    base08
    base0A
    ;

  # ===============
  # Behavior  stuff
  # ===============

  idle-dim-time = "600";
  idle-lock-time = "900";
  idle-screen-time = "1800";

  menu = "rofi -show combi -combi-modi 'drun' -terminal ${term} -ssh-command '{terminal} {ssh-client} {host} [-p {port}]' -run-shell-command '{terminal} {cmd}' -show-icons";

  # ============
  # Applications  
  # ============
  term = "${pkgs.alacritty}/bin/alacritty";
  term_float = "${term} --class floating-shell"; # Change app_id for window rules

  # ==========
  # Workspaces
  # ==========
  ws1 = "number 1";
  ws2 = "number 2";
  ws3 = "number 3";
  ws4 = "number 4";
  ws5 = "number 5";
  ws6 = "number 6";
  ws7 = "number 7";
  ws8 = "number 8";
  ws9 = "number 9";
  ws10 = "number 10";
  ws11 = "number 11";
  ws12 = "number 12";
  ws13 = "number 13";
  ws14 = "number 14";
  ws15 = "number 15";
  ws16 = "number 16";
  ws17 = "number 17";
  ws18 = "number 18";
  ws19 = "number 19";
  ws20 = "number 20";
in
{
  # ========
  # Packages
  # ========
  home.packages = with pkgs; [
    libnotify # keyboard-toggle, volume-notify, brightness-notify, screenshot
    jq # keyboard-toggle
    gron # keyboard-toggle
    pamixer # volume-notify
    light # brightness-notify
    playerctl # Media keys

    # rofi                    # Menus
    nwg-drawer # Full apps list
    nwg-displays # Display manager
    swaynotificationcenter # Notification center
    waybar # Status bar
    autotiling # Auto-tiling on sway (vertical/horizontal)
    kanshi # Dynamic output configuration - kanshi is a wayland daemon that listens to events from wlroots based compositors and configures outputs accordingly
    swayr # Window switcher for sway

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

    (writeShellScriptBin "sph-volume-down" "pamixer --decrease 5; sph-volume-notify")
    (writeShellScriptBin "sph-volume-up" "pamixer --increase 5; sph-volume-notify")
    (writeShellScriptBin "sph-volume-mute" "pamixer --toggle-mute; sph-volume-notify")
    (writeShellScriptBin "sph-volume-notify" ''
      VALUE=$(pamixer --get-volume)
      if [ "$(pamixer --get-mute)" = "true" ]; then
        TEXT="Volume: Muted"
      else
        TEXT="Volume: $VALUE%"
      fi
      notify-send \
          --expire-time 800 \
          --hint "int:transient:1" \
          --hint "int:value:$VALUE" \
          --category "hud" \
          "$TEXT"
    '')

    (writeShellScriptBin "sph-brightness-step" "echo $(( $(light -Mr) / 100 * 5 < 1 ? 1 : $(( $(light -Mr) / 100 * 5 )) ))")
    (writeShellScriptBin "sph-brightness-up" "light -r -A $(sph-brightness-step) && sph-brightness-notify")
    (writeShellScriptBin "sph-brightness-down" "light -r -U $(sph-brightness-step) && sph-brightness-notify")
    (writeShellScriptBin "sph-brightness-notify" ''
      VALUE=$(light -G)
      notify-send \
          --expire-time 800 \
          --hint string:x-canonical-private-synchronous:brightness \
          --hint "int:transient:1" \
          --hint "int:value:$VALUE" \
          --category "hud" \
          "Brightness" \
          "Current brightness: <b>$VALUE%</b>"
    '')

    (pkgs.writers.writePython3Bin "sph-first-empty-workspace" {
      libraries = with pkgs.python3.pkgs; [ i3ipc ];
      flakeIgnore = [ "E501" ];
    } (builtins.readFile ../resources/first-empty-workspace.py))

    (pkgs.writers.writePython3Bin "sph-autoname-workspaces" {
      libraries = with pkgs.python3.pkgs; [ i3ipc ];
      flakeIgnore = [ "E501" ];
    } (builtins.readFile ../resources/autoname-workspaces.py))

    (writeShellScriptBin "sph-run-or-show" (builtins.readFile ../resources/run-or-show.sh))

    (pkgs.writers.writePython3Bin "sph-waybar-bluetooth" {
      libraries = [ python311Packages.dbus-python ];
      flakeIgnore = [ "E501" ];
    } (builtins.readFile ../resources/waybar-bluetooth.py))
  ];

  # =====
  # Files
  # =====
  home.file = {
    ".config/swaync" = {
      source = ../resources/swaync;
      recursive = true;
    };

    ".config/waybar/config.jsonc".source = ../resources/waybar-config.jsonc;
    ".config/waybar/style.css".source = ../resources/waybar-style.css;

    ".config/networkmanager-dmenu/config.ini" = {
      text = ''
          [dmenu]
        	dmenu_command = rofi -dmenu -i
        	highlight = True
        	wifi_chars = ▂▄▆█
        	wifi_icons = 󰤯󰤟󰤢󰤥󰤨
      '';
    };
  };

  # ========
  # Sway cfg
  # ========  
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    package = null; # Use system package, with --unsupported-gpu
    config = {

      # ==============
      # Behavior stuff
      # ==============
      modifier = "Mod4";
      focus.followMouse = false;
      floating.modifier = "${config.wayland.windowManager.sway.config.modifier} normal";
      defaultWorkspace = "${ws1}";

      # ==========
      # Appearance
      # ==========
      gaps.inner = 4;
      gaps.smartGaps = false;
      gaps.smartBorders = "off";
      bars = [ ];
      window.titlebar = false;
      window.border = 2;
      floating.titlebar = false;
      floating.border = 2;
      window.hideEdgeBorders = "none";

      colors.focused.border = mkForce "${base0A}";
      colors.focused.childBorder = mkForce "${base0A}";
      colors.focused.indicator = mkForce "${base0A}";
      colors.unfocused.indicator = mkForce "${base03}";
      colors.focusedInactive.indicator = mkForce "${base03}";
      # output = {
      #   "*" = {
      #     bg = mkForce "/home/sphink/wallpaper.jpg fill";
      #   };
      # };

      #      colors.focused         = {border = "${color2}"; background = "${color0}"; text = "${color6}"; indicator = "${color2}"; childBorder = "${color2}";};
      #      colors.focusedInactive = {border = "${color1}"; background = "${color1}"; text = "${color5}"; indicator = "${color3}"; childBorder = "${color1}";};
      #      colors.unfocused       = {border = "${color1}"; background = "${color0}"; text = "${color5}"; indicator = "${color6}"; childBorder = "${color1}";};
      #      colors.urgent          = {border = "${color8}"; background = "${color8}"; text = "${color0}"; indicator = "${color9}"; childBorder = "${color8}";};
      #      colors.placeholder     = {border = "${color0}"; background = "${color0}"; text = "${color5}"; indicator = "${color0}"; childBorder = "${color0}";};
      #      colors.background      = "${color7}";

      # ============
      # Key bindings
      # ============
      bindkeysToCode = true;
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {

          # Kill focused window
          "${modifier}+Shift+q" = "kill";

          # Reload sway configuration
          "${modifier}+Shift+c" = "reload";

          # Exit sway
          "${modifier}+Shift+e" = "exec rofi -show menu -modi 'menu:rofi-power-menu --choices=shutdown/reboot/logout/lockscreen'  -theme-str 'listview {lines:4;} window {width:400;}'";

          # Launchers
          "${modifier}+space" = "exec ${menu}";
          "${modifier}+Shift+space" = "exec nwg-drawer";

          # Media keys
          "XF86AudioLowerVolume" = "exec sph-volume-down";
          "XF86AudioRaiseVolume" = "exec sph-volume-up";
          "XF86AudioMute" = "exec sph-volume-mute";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioStop" = "exec playerctl stop";
          "XF86AudioNext" = "exec playerctl next";
          "${modifier}+F2" = "exec sph-volume-down";
          "${modifier}+F3" = "exec sph-volume-up";
          "${modifier}+F4" = "exec sph-volume-mute";
          "${modifier}+F5" = "exec playerctl play-pause";
          "${modifier}+F6" = "exec playerctl previous";
          "${modifier}+F7" = "exec playerctl stop";
          "${modifier}+F8" = "exec playerctl next";

          # Brightness keys
          "XF86MonBrightnessDown" = "exec sph-brightness-down; sph-brightness-notify";
          "XF86MonBrightnessUp" = "exec sph-brightness-up; sph-brightness-notify";

          # Keyboard toggle        
          "${modifier}+backspace" = "exec sph-keyboard-toggle";

          # Other media keys (lock, search, display, poweroff)
          "XF86Search" = "exec ${menu}";
          "XF86TouchpadToggle" = "input type:touchpad events toggle enabled disabled";
          "XF86Display" = "exec nwg-displays";
          "XF86PowerOff" = "exec systemctl poweroff";

          # Moving around
          "${modifier}+Left" = "focus left";
          "${modifier}+Right" = "focus right";
          "${modifier}+Up" = "focus up";
          "${modifier}+Down" = "focus down";

          # Move focused window
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Right" = "move right";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Down" = "move down";

          # List all open windows
          "${modifier}+Ctrl+Space" = "exec env RUST_BACKTRACE=1 swayr switch-window &>> /tmp/swayr.log";

          # Switch to the last recently used window
          "Mod1+Tab" = "exec env RUST_BACKTRACE=1 swayr switch-to-urgent-or-lru-window &>> /tmp/swayr.log";

          # Next/Previous workspace
          "${modifier}+Tab" = "workspace next_on_output";
          "${modifier}+Shift+Tab" = "workspace prev_on_output";

          # Switch Workspaces
          "${modifier}+1" = "workspace ${ws1}";
          "${modifier}+2" = "workspace ${ws2}";
          "${modifier}+3" = "workspace ${ws3}";
          "${modifier}+4" = "workspace ${ws4}";
          "${modifier}+5" = "workspace ${ws5}";
          "${modifier}+6" = "workspace ${ws6}";
          "${modifier}+7" = "workspace ${ws7}";
          "${modifier}+8" = "workspace ${ws8}";
          "${modifier}+9" = "workspace ${ws9}";
          "${modifier}+0" = "workspace ${ws10}";
          "${modifier}+Ctrl+1" = "workspace ${ws11}";
          "${modifier}+Ctrl+2" = "workspace ${ws12}";
          "${modifier}+Ctrl+3" = "workspace ${ws13}";
          "${modifier}+Ctrl+4" = "workspace ${ws14}";
          "${modifier}+Ctrl+5" = "workspace ${ws15}";
          "${modifier}+Ctrl+6" = "workspace ${ws16}";
          "${modifier}+Ctrl+7" = "workspace ${ws17}";
          "${modifier}+Ctrl+8" = "workspace ${ws18}";
          "${modifier}+Ctrl+9" = "workspace ${ws19}";
          "${modifier}+Ctrl+0" = "workspace ${ws20}";

          # Move focused window to workspace
          "${modifier}+Shift+1" = "move container to workspace ${ws1}, workspace ${ws1}";
          "${modifier}+Shift+2" = "move container to workspace ${ws2}, workspace ${ws2}";
          "${modifier}+Shift+3" = "move container to workspace ${ws3}, workspace ${ws3}";
          "${modifier}+Shift+4" = "move container to workspace ${ws4}, workspace ${ws4}";
          "${modifier}+Shift+5" = "move container to workspace ${ws5}, workspace ${ws5}";
          "${modifier}+Shift+6" = "move container to workspace ${ws6}, workspace ${ws6}";
          "${modifier}+Shift+7" = "move container to workspace ${ws7}, workspace ${ws7}";
          "${modifier}+Shift+8" = "move container to workspace ${ws8}, workspace ${ws8}";
          "${modifier}+Shift+9" = "move container to workspace ${ws9}, workspace ${ws9}";
          "${modifier}+Shift+0" = "move container to workspace ${ws10}, workspace ${ws10}";
          "${modifier}+Ctrl+Shift+1" = "move container to workspace ${ws11}, workspace ${ws11}";
          "${modifier}+Ctrl+Shift+2" = "move container to workspace ${ws12}, workspace ${ws12}";
          "${modifier}+Ctrl+Shift+3" = "move container to workspace ${ws13}, workspace ${ws13}";
          "${modifier}+Ctrl+Shift+4" = "move container to workspace ${ws14}, workspace ${ws14}";
          "${modifier}+Ctrl+Shift+5" = "move container to workspace ${ws15}, workspace ${ws15}";
          "${modifier}+Ctrl+Shift+6" = "move container to workspace ${ws16}, workspace ${ws16}";
          "${modifier}+Ctrl+Shift+7" = "move container to workspace ${ws17}, workspace ${ws17}";
          "${modifier}+Ctrl+Shift+8" = "move container to workspace ${ws18}, workspace ${ws18}";
          "${modifier}+Ctrl+Shift+9" = "move container to workspace ${ws19}, workspace ${ws19}";
          "${modifier}+Ctrl+Shift+0" = "move container to workspace ${ws20}, workspace ${ws20}";

          # Window layout modes
          "${modifier}+t" = "layout toggle tabbed splith splitv";

          # Fullscreen
          "${modifier}+f" = "fullscreen";

          # Floating
          "${modifier}+Shift+f" = "floating toggle";

          # Toggle focus between tiling and floating
          "${modifier}+Ctrl+f" = "focus mode_toggle";

          # Move workspace to output right
          "${modifier}+x" = "move workspace to output right";

          # Move workspace to center
          "${modifier}+v" = "move absolute position center";

          # Launch apps
          "${modifier}+Return" = "exec ${term}";
          "${modifier}+Shift+Return" = "exec ${term_float}";
          "${modifier}+e" = "exec 'nautilus'";
          "${modifier}+w" = "exec nmcli d wifi rescan && networkmanager_dmenu";
          "${modifier}+c" = "exec rofi -show calc -modi calc -no-show-match -no-sort | wl-copy";

          # Show notifications
          "${modifier}+n" = "exec swaync-client -t";

          # Toggle apps
          "${modifier}+k" = "exec sph-run-or-show -i 'org.keepassxc.KeePassXC' 'keepassxc'";
          "${modifier}+h" = "exec sph-run-or-show -i 'com.rafaelmardojai.Blanket' 'blanket'";
          "${modifier}+b" = "exec sph-run-or-show -i '.blueman-manager-wrapped' 'blueman-manager'";
          "${modifier}+s" = "exec sph-run-or-show -i 'pavucontrol' 'pavucontrol'";
          "${modifier}+backslash" = "exec sph-run-or-show -c 'obsidian' 'obsidian'";
          "${modifier}+m" = "exec sph-run-or-show -c 'Plexamp' plexamp";
        };

      keycodebindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        {
          "${modifier}+49" = "exec sph-first-empty-workspace --switch";
          "${modifier}+Shift+49" = "exec sph-first-empty-workspace --move --switch";
        };

      input = {
        "type:keyboard" = {
          xkb_layout = "br,us";
          xkb_variant = ",alt-intl";
          xkb_options = "grp:shift_caps_toggle";
          xkb_model = "pc105";
          repeat_delay = "300";
          repeat_rate = "40";
          xkb_numlock = "enabled";
        };
      };

      seat = {
        "*" = {
          shortcuts_inhibitor = "disable";
        };
      };

      floating.criteria = [
        { app_id = "floating-shell"; }
        { app_id = "nm-connection-editor"; }
        { app_id = "qt5ct"; }
        { app_id = "qt6ct"; }
        { app_id = "pavucontrol"; }
        { app_id = "nwg-look"; }
        { app_id = "nwg-displays"; }
        { title = "Firefox .*— Sharing Indicator"; }
        { title = ".* is sharing your screen."; }
        { title = "Save File"; }
        { title = "Android Emulator - .*"; }
        { class = "^serpro-ppgd-app-IRPFPGD"; }
        { class = "zoom"; }
        { window_role = "pop-up"; }
        { window_role = "bubble"; }
        { window_role = "dialog"; }
        { window_role = "task_dialog"; }
        { window_role = "GtkFileChooserDialog"; }
        { window_role = "GtkFiileChooserDialog"; }
        { window_role = "Preferences"; }
        { window_type = "dialog"; }
        { window_type = "menu"; }
        { title = "(?:Open|Save) (?:File|Folder|As)"; }
      ];

      # ===============
      # Window commands
      # ===============
      window.commands = [
        {
          criteria = {
            title = "(?:Open|Save) (?:File|Folder|As)";
          };
          command = "resize set 600 400";
        }

        # Disable idle if fullscreen
        {
          criteria = {
            class = ".*";
          };
          command = "inhibit_idle fullscreen";
        }
        {
          criteria = {
            app_id = ".*";
          };
          command = "inhibit_idle fullscreen";
        }

        # Toggle apps
        {
          criteria = {
            app_id = "org.keepassxc.KeePassXC";
          };
          command = "floating enable, move scratchpad, focus";
        }
        {
          criteria = {
            app_id = "com.rafaelmardojai.Blanket";
          };
          command = "floating enable, move scratchpad, focus";
        }
        {
          criteria = {
            app_id = ".blueman-manager-wrapped";
          };
          command = "floating enable, move scratchpad, focus";
        }
        {
          criteria = {
            app_id = "pavucontrol";
          };
          command = "floating enable, move scratchpad, focus";
        }
        {
          criteria = {
            class = "obsidian";
          };
          command = "floating enable, move scratchpad, focus";
        }
        {
          criteria = {
            class = "Plexamp";
          };
          command = "floating enable, move scratchpad, focus";
        }
      ];

      # ====================
      # Startup applications
      # ====================
      startup = [

        # Once
        { command = "swaync"; }
        { command = "autotiling"; }
        { command = "sph-autoname-workspaces"; }
        { command = "syncthing -no-browser"; }
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }

        # Always 
        {
          always = true;
          command = "pkill kanshi; ${pkgs.kanshi}/bin/kanshi";
        }
        {
          always = true;
          command = "pkill swayrd; env RUST_BACKTRACE=1 RUST_LOG=swayr=debug swayrd &> /tmp/swayrd.log";
        }
        {
          always = true;
          command = "pkill poweralertd; sleep 5; poweralertd -s -i 'line power'";
        }
        {
          always = true;
          command = "nwg-drawer -r -ovl";
        }
        {
          always = true;
          command = "pkill playerctl; playerctl -a metadata --format \'{{status}} {{title}}\' --follow | while read line; do pkill -RTMIN+5 waybar; done";
        }
      ];
    };

    # =======================================================
    # Extra configurations (keyboard, etc, set by other apps)
    # =======================================================
    extraConfig = ''
      # Extra configurations defined by nwg-displays
      include outputs

      # Set workspace 1 as default (instead of 10)
      workspace ${ws1}

      # Waybar
      bar {
        id default
        swaybar_command waybar
      }
    '';
  };
}
