{ config, pkgs, ... }:

{

  stylix.image = config.lib.stylix.pixel "base03";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  stylix.enable = true;

  stylix.targets.gnome.enable = true;

  stylix.cursor.package = pkgs.numix-cursor-theme;
  stylix.cursor.name = "Numix-Cursor";

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "Ubuntu Nerd Font";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "Ubuntu Nerd Font";
    };

    monospace = {
      package = pkgs.dejavu_fonts;
      name = "SauceCodePro Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Ubuntu Nerd Font";
    };
  };
}
