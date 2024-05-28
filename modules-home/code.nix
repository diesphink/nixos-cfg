{
  config,
  pkgs,
  lib,
  ...
}:
{

  # code-default-settings = pkgs.writeText "code-default-settings" ''
  #   {
  #     "workbench.colorTheme": "Nord",
  #     "window.menuBarVisibility": "toggle",
  #     "editor.formatOnSave": true,
  #     "files.dialog.defaultPath": ".",
  #   }
  # '';

  home.packages = with pkgs; [
    vscode.fhs

    (writeShellScriptBin "sph-install-default-settings" ''
      if [ -e ~/.code-default-settings ] && [ -e .vscode ]; then
        CODE_USER_DIR=".vscode/data/User"
        mkdir -p "$CODE_USER_DIR"
        cp --no-preserve=mode ~/.code-default-settings "$CODE_USER_DIR/settings.json"
      else
        echo Nothing to do here!
      fi
    '')

    (writeShellScriptBin "sph-install-default-extensions" ''
      if [ -e ~/.code-default-extensions ] && [ -e .vscode ]; then
        while read extension
        do
          code --install-extension "$extension"
        done <~/.code-default-extensions
      else
        echo Nothing to do here!
      fi

    '')
  ];

  # nixpkgs.overlays = [ (pkgs.writeText "teste" "teste") ];

  home.file = {
    ".code-default-settings".text = ''
      {
        "workbench.colorTheme": "Nord",
        "window.menuBarVisibility": "toggle",
        "editor.formatOnSave": true,
        "workbench.iconTheme": "vs-nomo-dark",
      }
    '';

    ".code-default-extensions".text = ''
      arcticicestudio.nord-visual-studio-code
      usernamehw.errorlens
      be5invis.vscode-icontheme-nomo-dark
    '';
  };
}
