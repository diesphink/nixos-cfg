# Fonts

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    noto-fonts # Adicionada por causa do tema no obsidian, TODO: rever
    iosevka # Adicionada por causa do tema no obsidian, TODO: rever
    corefonts
    vistafonts
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "SourceCodePro"
        # "FiraCode"
        # "DroidSansMono"
        # "Hack"
        "Ubuntu"
      ];
    })
  ];

}
