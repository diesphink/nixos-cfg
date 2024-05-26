# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    autoSuspend = false;
  };
  services.displayManager.defaultSession = "sway";
  
}
