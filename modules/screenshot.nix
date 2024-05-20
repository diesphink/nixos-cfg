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
    sway-contrib.grimshot
    swappy
    wl-clipboard
    libnotify

    (writeShellScriptBin "sph-screenshot" ''
      FOLDER=~/Pictures/screenshots/$(date +%Y)
      mkdir -p $FOLDER
      IMG=$FOLDER/$(date +%Y-%m-%d_%H-%M-%S).png
      grimshot save $1 $IMG

      if [ ! -f $IMG ]; then
        notify-send 'Screenshot failed' -c 'hud'
        exit 1
      fi

      # check if $1 is not output
      if [ $1 != "output" ]; then
        swappy -f $IMG -o $IMG
      fi

      wl-copy -t "image/png" < $IMG

      notify-send 'Screenshot saved' -c 'hud'
    '')
  ];

  wayland.windowManager.sway.config.keybindings =
    let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in
    lib.mkOptionDefault {
      "Print" = "exec sph-screenshot output";
      "${modifier}+Print" = "exec sph-screenshot area";
      "Mod1+Print" = "exec sph-screenshot window";
    };
}
