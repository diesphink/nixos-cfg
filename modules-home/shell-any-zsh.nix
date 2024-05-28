{
  config,
  pkgs,
  lib,
  ...
}:

{

  # Install from zsh4humans
  home.file = {
    ".zshrc" = {
      source = ../resources/zshrc;
    };
    ".zshenv" = {
      source = ../resources/zshenv;
    };
    ".p10k.zsh" = {
      source = ../resources/p10k.zsh;
    };
    ".p10k-vscode.zsh" = {
      source = ../resources/p10k-vscode.zsh;
    };
    ".p10k-ascii-8color.zsh" = {
      source = ../resources/p10k-ascii-8color.zsh;
    };
  };
}
