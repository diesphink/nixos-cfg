# =======
# Atuin
# =======

{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      style = "compact";
      show_help = false;
      show_tabs = true;
      enter_accept = true;
      sync.records = true;
    };
  };

  programs.bash.enable = true;
}
