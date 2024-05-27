{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    stylish

    (writeShellScriptBin "sph-wallpaper" ''
      export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
      ${stylish}/bin/styli.sh -s "winter" --sway
    '')
  ];

}
