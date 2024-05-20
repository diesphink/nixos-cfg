# ==================================
# Sunset
# Uses wlsunset to change color temperature of displays
# ==================================

{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    cliphist

    (writeShellScriptBin "sph-clipboard" "cliphist list | rofi -dmenu -p 'Select item to copy' -theme-str 'window {width:1000; font: \"FiraCode Nerd Font Medium 9\";}' | cliphist decode | wl-copy")
    (writeShellScriptBin "sph-clipboard-del" "cliphist list | rofi -dmenu -p 'Select item to delete' -theme-str 'window {width:1000; font: \"FiraCode Nerd Font Medium 9\";}' | cliphist delete")
  ];

  wayland.windowManager.sway.config.keybindings =
    let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in
    lib.mkOptionDefault { "${modifier}+Shift+p" = "exec sph-clipboard"; };

  wayland.windowManager.sway.config.startup = [ { command = "wl-paste --watch cliphist store"; } ];
}
