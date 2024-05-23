{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.file = {
    ".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  };
}
