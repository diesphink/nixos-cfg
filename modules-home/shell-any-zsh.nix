{
  config,
  pkgs,
  lib,
  ...
}:

{

  # Install from zsh4humans
  home.file = {
    ".zshrc" = { source = ../resources/zshrc; };
    ".zshenv" = { source = ../resources/zshenv; };

  };
}
