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
  programs.rofi = {
    enable = true;

    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];

    extraConfig = {
      terminal = "alacritty";
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
}
