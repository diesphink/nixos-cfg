# Fonts

{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts # Adicionada por causa do tema no obsidian, TODO: rever
    iosevka # Adicionada por causa do tema no obsidian, TODO: rever
    corefonts
    vistafonts

    (nerdfonts.override {
      fonts = [
        "SourceCodePro"
        "JetBrainsMono"

        # "DroidSansMono"
        # "Hack"
        "Ubuntu"
      ];
    })
  ];
}
