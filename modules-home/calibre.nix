# ==================================
# Calibre
# ==================================

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.lib.stylix.colors)
    base00
    base01
    base02
    base03
    base04
    base05
    base06
    base07
    base08
    base09
    base0A
    base0B
    base0C
    base0D
    base0E
    base0F
    ;
in

{
  home.packages = with pkgs; [ calibre ];

  home.file = {
    ".config/calibre" = {
      source = ../resources/calibre;
      recursive = true;
    };

    ".config/calibre/nixdefault-global.py.json".text = ''
      {
        "database_path": "/home/sphink/library1.db",
        "library_path": "/home/sphink/Documents/calibre"
      }
    '';

    ".config/calibre/nixdefault-dynamic.pickle.json".text = ''
      {
        "database location dialog": "/home/sphink/Documents/calibre",
        "welcome_wizard_device": "kindle_pw",
        "welcome_wizard_was_run": true
      }
    '';

    ".config/calibre/nixdefault-customize.py.json".text = ''
      {
        "plugins": {
          "DeDRM": "/home/sphink/.config/calibre/plugins/DeDRM.zip",
          "KFX Input": "/home/sphink/.config/calibre/plugins/KFX Input.zip"
        }
      }
    '';

    ".config/calibre/nixdefault-gui.json".text = ''
      {
        "color_palette": "dark",
        "dark_palette_name": "__current__",
        "dark_palettes": {
          "__current__": {
            "AlternateBase": "#${base01}",
            "Base": "#${base00}",
            "BrightText": "#${base08}",
            "BrightText-disabled": "#${base08}",
            "Button": "#${base00}",
            "ButtonText": "#${base06}",
            "ButtonText-disabled": "#${base04}",
            "Highlight": "#${base0F}",
            "HighlightedText": "#${base06}",
            "HighlightedText-disabled": "#${base04}",
            "Link": "#${base0D}",
            "LinkVisited": "#${base0E}",
            "PlaceholderText": "#${base04}",
            "PlaceholderText-disabled": "#${base04}",
            "Text": "#${base06}",
            "Text-disabled": "#${base04}",
            "ToolTipBase": "#${base00}",
            "ToolTipText": "#${base06}",
            "ToolTipText-disabled": "#${base06}",
            "Window": "#${base00}",
            "WindowText": "#${base06}",
            "WindowText-disabled": "#${base06}"
          }
        }
      }
    '';
  };

  home.activation = {
    mergeJsons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''

      function sph-merge-json {
        if [ ! -f "$2" ]; then
          cp "$1" "$2"
          return
        fi
        jq -s '.[0] * .[1]' "$2" "$1" > "$2.tmp"
        mv "$2.tmp" "$2"
      }

      run sph-merge-json ~/.config/calibre/nixdefault-global.py.json ~/.config/calibre/global.py.json
      run sph-merge-json ~/.config/calibre/nixdefault-dynamic.pickle.json ~/.config/calibre/dynamic.pickle.json
      run sph-merge-json ~/.config/calibre/nixdefault-gui.json ~/.config/calibre/gui.json
      run sph-merge-json ~/.config/calibre/nixdefault-customize.py.json ~/.config/calibre/customize.py.json
    '';
  };
}
