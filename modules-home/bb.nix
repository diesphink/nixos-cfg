# ==================================
# BB
# ==================================

{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waypipe

    (writeShellScriptBin "sph-bb" ''
      virsh --connect qemu:///system net-start "default"
      virsh --connect qemu:///system start "debian12"
      false
      while [ $? -ne 0 ]; do
        echo Trying ssh...
        waypipe ssh 192.168.122.164 firefox "https://www2.bancobrasil.com.br/aapf/login.html"
      done
      virsh --connect qemu:///system shutdown "debian12"
      virsh --connect qemu:///system net-destroy "default"
    '')
  ];

  xdg.desktopEntries = {

    bb = {
      name = "BB";
      genericName = "Banco do Brasil";
      exec = "alacritty -e sph-bb";
      categories = [ "Application" ];
    };
  };

}
