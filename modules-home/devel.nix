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

    (writeShellScriptBin "sph-devel-menu" ''

      declare -A folders
      declare -A commands


      ROFI_OPTIONS=""
      for project in $(ls ~/devel/**/.envrc); do
          FOLDER=$(dirname "$project")

          # Project name
          PROJECT_NAME=$(basename "$FOLDER")

          # Project icon
          if [ -e "$FOLDER/.venv" ] || [ -e "$FOLDER/venv" ]; then
              ICON=""
          elif [ -e "$FOLDER/flake.nix" ]; then
              ICON="󱄅"
          else
              ICON=""
          fi

          # Project command
          if [ -e "$FOLDER/.vscode" ]; then
              COMMAND="scode $FOLDER"
          else
              COMMAND="scode $FOLDER"
          fi

          ROFI_KEY="$ICON $PROJECT_NAME"
          folders["$ROFI_KEY"]="$FOLDER"
          commands["$ROFI_KEY"]="$COMMAND"
          ROFI_OPTIONS="$ROFI_OPTIONS$ROFI_KEY\n"
      done
      CHOICE=$(printf "$ROFI_OPTIONS" | rofi -dmenu  -p "Select a project" -mesg "This will start the configured IDE inside shell.nix/flake.nix")
      if [ -z "$CHOICE" ]; then
          exit 0
      else
          echo alacritty --class floating-shell -e direnv exec ''${folders["$CHOICE"]} ''${commands["$CHOICE"]}
          alacritty --class floating-shell -e direnv exec ''${folders["$CHOICE"]} ''${commands["$CHOICE"]}
      fi


    '')

    (writeShellScriptBin "devel-init" ''
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
      echo ".direnv" >> .gitignore
      echo "done!"

      echo -n "Running direnv allow... "
      direnv allow
      echo "done!"
    '')

    (writeShellScriptBin "scode" ''

      sph-install-default-extensions "$1"
      sph-install-default-settings "$1"

      code \
        --user-data-dir "$1/.vscode/data" \
        --extensions-dir "$1/.vscode/extensions" \
        $1 \
        $*
    '')

    (writeShellScriptBin "sph-install-default-settings" ''
      CODE_USER_DIR="$1/.vscode/data/User"
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
            --user-data-dir "$1/.vscode/data" \
            --extensions-dir "$1/.vscode/extensions" \
            --list-extensions)

        while read extension
        do
          echo -n "Checking $extension... "
          if [[ ! "$EXTS" =~ "$extension" ]]; then
            echo "missing! Installing $extension"
            code \
              --user-data-dir "$1/.vscode/data" \
              --extensions-dir "$1/.vscode/extensions" \
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

  wayland.windowManager.sway.config.keybindings =
    let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in
    lib.mkOptionDefault { "${modifier}+d" = "exec sph-devel-menu"; };
}
