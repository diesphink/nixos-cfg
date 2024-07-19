# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules-sys/syncthing.nix
    ./modules-sys/stylix.nix
    ./modules-sys/login-gdm.nix
    ./modules-sys/bluetooth.nix
    ./modules-sys/fonts.nix
    ./modules-sys/homepage.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # services.xserver.desktopManager.pantheon.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  programs.direnv = {
    enable = true;
    silent = true;
  };

  xdg.mime.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ford"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.flatpak.enable = true;
  # For the sandboxed apps to work correctly, desktop integration portals need to be
  # installed. If you run GNOME, this will be handled automatically for you; 
  # in other cases, you will need to add something like the following to your
  # configuration.nix:
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "${pkgs.sway}/bin/sway";
  services.xrdp.openFirewall = true;
  services.gnome.gnome-remote-desktop.enable = true;

  # Enable udisks2, a DBus service that allows applications to query and manipulate storage devices.
  # Gnome disks use this
  services.udisks2.enable = true;

  # Enable GVfs, a userspace virtual filesystem.
  services.gvfs.enable = true;

  # Enable polkit
  security.polkit.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3389 ];
    allowedUDPPorts = [ 3389 ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";

  };

  programs.nix-ld.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  programs.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
    '';
    extraOptions = [ "--unsupported-gpu" ];
  };
  xdg.portal.wlr.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    polkit
    polkit_gnome
    gparted
    fuse
    zsh
    rsync
    jq

    (writeShellScriptBin "nrs" ''
      nh os switch ~/devel/nixos-cfg $*
    '')

  ];

  virtualisation.docker.enable = true;

  programs.file-roller.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sphink = {
    isNormalUser = true;
    description = "Diego Pereyra";
    hashedPassword = "$y$j9T$C2kehlCtN4ThJnIWWT6I11$dkB89nIGt0rOW2t2qf18m6x7/htCZXOXbCylAcx5ZK8";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "alacritty";
  services.gnome.sushi.enable = true;

  environment.variables = with config.lib.stylix.colors; {
    WLR_NO_HARDWARE_CURSORS = "1";
    BASE00 = base00;
    BASE01 = base01;
    BASE02 = base02;
    BASE03 = base03;
    BASE04 = base04;
    BASE05 = base05;
    BASE06 = base06;
    BASE07 = base07;
    BASE08 = base08;
    BASE09 = base09;
    BASE0A = base0A;
    BASE0B = base0B;
    BASE0C = base0C;
    BASE0D = base0D;
    BASE0E = base0E;
    BASE0F = base0F;
  };

  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  security.sudo = {
    enable = true;
    extraConfig = ''
      sphink ford = (root) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
      sphink ford = (root) NOPASSWD: /run/current-system/sw/bin/nrs
    '';
    # sphink ford = (root) NOPASSWD: ${nrs}/bin/nrs
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # nix.gc = {
  #   automatic = true;
  #   dates = "daily";
  #   options = "--delete-older-than 8d";
  # };

  programs.nh = {
    enable = true;
    flake = "/home/sphink/devel/nixos-cfg";
    clean = {
      enable = true;
      extraArgs = "--keep 2";
      dates = "daily";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
