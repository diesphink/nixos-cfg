{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # Dev Dependencies 
    nixfmt-rfc-style

    # stub program to encapsulate code configuration inside project
    (writeShellScriptBin "ide" ''
      code --user-data-dir "$PROJECT_ROOT/.vscode/data" --extensions-dir "$PROJECT_ROOT/.vscode/extensions" . $*
    '')
  ];

  shellHook = ''
    cd $PROJECT_ROOT

    # Will use clean environment for code, if you don't want that, comment next line
    # The environment folders will be created inside .vscode folder
    alias code="ide"

    [[ -x "$(command -v sph-install-default-extensions)" ]] && sph-install-default-extensions
    [[ -x "$(command -v sph-install-default-settings)" ]] && sph-install-default-settings

  '';

  PROJECT_ROOT = builtins.toString ./.;
}
