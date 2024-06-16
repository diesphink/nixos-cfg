{
  pkgs ? import <nixpkgs> { },
}:

let
  title = "Nix OS Configurations";

  dependencies = with pkgs; [ ];

  shellHook = ''
    # Add extra shell hook here
  '';

  shellHookDescription = [
    # Add shell hook description here, as an array of strings
  ];

  commands = {
    "scode" = "Sandboxed version of Visual Studio Code";
  };

  title_color = "$(tput setaf 4)";
  item_color = "$(tput setaf 8)";
  command_color = "$(tput setaf 2)";
  reset = "$(tput sgr0)";
  mark = "${item_color} ● ${reset}";
in

pkgs.mkShell {
  nativeBuildInputs = dependencies;

  shellHook =
    shellHook
    + ''
      cat <<EOF| boxes -d ansi-rounded -p t1h4b0
      ${title_color + title + reset}  

      ${
        reset
        + (if builtins.lessThan 0 (builtins.length dependencies) then "Packages installed:\n" + (builtins.foldl' (x: y: x + mark + y.name + "\n") "" dependencies) + "\n" else "")
        + (if builtins.lessThan 0 (builtins.length shellHookDescription) then "On start:\n" + (builtins.foldl' (x: y: x + mark + y + "\n") "" shellHookDescription) + "\n" else "")
        + (if builtins.lessThan 0 (builtins.length (builtins.attrNames commands)) then "Commands:\n" else "")
        + (builtins.foldl' (x: y: x + mark + command_color + y + reset + ": " + commands.${y} + "\n") "" (builtins.attrNames commands))
      }
      EOF
    '';

  PROJECT_ROOT = builtins.toString ./.;
}
