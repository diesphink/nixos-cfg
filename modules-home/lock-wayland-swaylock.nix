# ==================================
# Lock using swaylock
# ==================================

{
  config,
  pkgs,
  lib,
  ...
}:
let

  inherit (lib) mkForce;
  inherit (config.lib.stylix.colors) base00 base03 base08;

  # ===============
  # Behavior  stuff
  # ===============

  idle-dim-time = "600";
  idle-lock-time = "900";
  idle-screen-time = "1800";
in
{
  # ========
  # Packages
  # ========
  home.packages = with pkgs; [
    grim # lock
    ffmpeg # lock
    swaylock # lock

    (writeShellScriptBin "sph-lock" ''
      OUTPUTS=$(swaymsg -t get_outputs --raw | jq -r '.[] | select(.active) | .name')
      SWAYLOCK_ARGS=""
      for OUTPUT in $OUTPUTS; do
        rm /tmp/screen-out-$OUTPUT.png
        grim -o $OUTPUT /tmp/screen-$OUTPUT.png
        ffmpeg -i /tmp/screen-$OUTPUT.png -vf "gblur=15, vignette=PI/5" -c:a copy /tmp/screen-out-$OUTPUT.png
        SWAYLOCK_ARGS="$SWAYLOCK_ARGS -i $OUTPUT:/tmp/screen-out-$OUTPUT.png"
      done
      swaylock $SWAYLOCK_ARGS --daemonize
    '')

    (writeShellScriptBin "sph-dim" "light -G > /tmp/brightness && light -S 10")
    (writeShellScriptBin "sph-undim" "light -S $([ -f /tmp/brightness ] && cat /tmp/brightness || echo 100%)")

    (writeShellScriptBin "sph-idle" ''
      swayidle -w \
        timeout ${idle-dim-time} 'sph-dim' resume 'sph-undim' \
        timeout ${idle-lock-time} 'sph-lock' \
        timeout ${idle-screen-time} 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
        before-sleep 'playerctl pause' \
        before-sleep 'sph-lock' \
        lock 'sph-lock' &
    '')

  ];

  # ========
  # Sway cfg
  # ========  

  wayland.windowManager.sway.config.startup = [ { command = "sph-idle"; } ];

  wayland.windowManager.sway.config.keybindings =
    let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in
    lib.mkOptionDefault {
      "XF86ScreenSaver" = "exec sph-lock";
      "${modifier}+Escape" = "exec sph-lock";      
    };


  # ========
  # Swaylock
  # ========
  programs.swaylock = {
    enable = true;
    settings = {
      indicator-caps-lock = true;
      indicator-idle-visible = true;
      ignore-empty-password = true;
      show-failed-attempts = true;
      show-keyboard-layout = true;
      font = "FiraCode Nerd Font";
      font-size = "12";

      ring-color = mkForce "${base03}";
      ring-caps-lock-color = mkForce "${base08}";
      text-caps-lock-color = mkForce "${base08}";
      inside-caps-lock-color = mkForce "${base00}";
    };
  };
}
