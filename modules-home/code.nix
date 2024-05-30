{
  config,
  pkgs,
  lib,
  ...
}:
{

  home.file = {

    ".code-default-settings".text = builtins.toJSON {
      "workbench.colorTheme" = "Nord";
      "window.menuBarVisibility" = "toggle";
      "editor.formatOnSave" = true;
      "workbench.iconTheme" = "vs-nomo-dark";
      "github.copilot.editor.enableAutoCompletions" = true;
      "teste" = "algo";
    };

    ".code-default-extensions".text = ''
      arcticicestudio.nord-visual-studio-code
      usernamehw.errorlens
      be5invis.vscode-icontheme-nomo-dark
      github.copilot
      github.copilot-chat
    '';
  };

  home.packages = with pkgs; [
    vscode.fhs

    (writeShellScriptBin "scode-init" ''
      # Create basic shell.nix
      echo -n "Checking shell.nix... "
      if [ ! -e "shell.nix" ]; then
        echo -n "missing! Creating... "
        cat <<EOF > shell.nix
      {
        pkgs ? import <nixpkgs> { },
      }:

      pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
        ];

        PROJECT_ROOT = builtins.toString ./.;
      }
      EOF
        echo "done!"
      else
        echo "already exists!"
      fi

      # Create direnv file
      echo -n "Checking .envrc... "
      if [ ! -e ".envrc" ]; then
        echo -n "missing! Creating... "
        echo "use nix" > .envrc
        echo "done!"
      else
        echo "already exists!"
      fi

      # Add vscode data and extensions dirs to .gitignore
      echo -n "Adding to .gitignore... "      
      echo ".vscode/extensions" >> .gitignore
      echo ".vscode/data" >> .gitignore
      echo "done!"

      echo -n "Running direnv allow... "
      direnv allow
      echo "done!"
    '')

    (writeShellScriptBin "scode" ''

      sph-install-default-extensions
      sph-install-default-settings

      code \
        --user-data-dir "$PROJECT_ROOT/.vscode/data" \
        --extensions-dir "$PROJECT_ROOT/.vscode/extensions" \
        $PROJECT_ROOT \
        $*
    '')

    (writeShellScriptBin "sph-install-default-settings" ''
      CODE_USER_DIR="$PROJECT_ROOT/.vscode/data/User"
      echo -n "Checking for settings... "
      if [ -e ~/.code-default-settings ]; then
        if [ ! -e "$CODE_USER_DIR/settings.json" ]; then
          echo -n "missing! Installing default settings... "
          mkdir -p "$CODE_USER_DIR"
          cp --no-preserve=mode ~/.code-default-settings "$CODE_USER_DIR/settings.json"
          echo "done!"
        else
          echo -n "already installed! Merging settings with defaults... "
          jq -s '.[0] * .[1]' "$CODE_USER_DIR/settings.json" ~/.code-default-settings > "$CODE_USER_DIR/settings.json.tmp"
          mv "$CODE_USER_DIR/settings.json.tmp" "$CODE_USER_DIR/settings.json"
          echo "done!"
        fi
      else
        echo Nothing to do here!
      fi
    '')

    (writeShellScriptBin "sph-install-default-extensions" ''
      if [ -e ~/.code-default-extensions ] && [ -e .vscode ]; then
        EXTS=$(code \
            --user-data-dir "$PROJECT_ROOT/.vscode/data" \
            --extensions-dir "$PROJECT_ROOT/.vscode/extensions" \
            --list-extensions)

        while read extension
        do
          echo -n "Checking $extension... "
          if [[ ! "$EXTS" =~ "$extension" ]]; then
            echo "missing! Installing $extension"
            code \
              --user-data-dir "$PROJECT_ROOT/.vscode/data" \
              --extensions-dir "$PROJECT_ROOT/.vscode/extensions" \
              --install-extension "$extension"
          else
            echo "already installed!"
          fi
        done <~/.code-default-extensions
      else
        echo Nothing to do here!
      fi

    '')
  ];
}
