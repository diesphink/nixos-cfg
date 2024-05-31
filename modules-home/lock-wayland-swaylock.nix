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

    (writeShellScriptBin "sph-dim" "light -G > /tmp/brightness && light -S 10")
    (writeShellScriptBin "sph-undim" "light -S $([ -f /tmp/brightness ] && cat /tmp/brightness || echo 100%)")

    (writeShellScriptBin "sph-idle" ''
      swayidle -w \
        timeout ${idle-dim-time} 'sph-dim' resume 'sph-undim' \
        timeout ${idle-lock-time} 'swaylock' \
        timeout ${idle-screen-time} 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
        before-sleep 'playerctl pause' \
        before-sleep 'swaylock' \
        lock 'swaylock' &
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
      "XF86ScreenSaver" = "exec swaylock --grace 0";
      "${modifier}+Escape" = "exec swaylock --grace 0";
    };

  # ========
  # Swaylock
  # ========
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      indicator-caps-lock = true;
      indicator-idle-visible = true;
      ignore-empty-password = true;
      show-failed-attempts = true;
      show-keyboard-layout = false;
      font = "SauceCodePro Nerd Font";
      font-size = "15";
      screenshots = true;
      effect-pixelate = 10;
      grace = 10;
      clock = true;
      datestr = "󰌾 Locked";

      ring-color = mkForce "${base03}";
      ring-caps-lock-color = mkForce "${base08}";
      text-caps-lock-color = mkForce "${base08}";
      inside-caps-lock-color = mkForce "${base00}";
    };
  };
}
