# Bluetooth

{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    package = pkgs.bluez-experimental; # Sem o experimental não consegui conectar com o bose qc
    # settings.General.Experimental = true;
    # settings.Input.ClassicBondedOnly = false;
  };
  services.blueman.enable = true;  
}
