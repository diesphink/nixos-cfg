# =======
# Liferea
# =======

{
  config,
  pkgs,
  lib,
  ...
}:
{

  xdg.configFile."liferea/feedlist.opml".source = ../resources/liferea/feedlist.opml;

  # programs.bash.enable = true;
  home.packages = with pkgs; [ liferea ];
}
