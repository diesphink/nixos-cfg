{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Theme zathura
  home-manager.users.sphink.programs.zathura.extraConfig = builtins.readFile (
    config.scheme inputs.base16-zathura
  );

  # Theme `alacritty`. home-manager doesn't provide an `extraConfig`,
  # but gives us `settings.colors` option of attrs type to set colors. 
  # As alacritty expects colors to begin with `#`, we use an attribute `withHashtag`.
  # Notice that we now use `config.scheme` as an attrset, and that this attrset,
  # besides from having attributes `base00`...`base0F`, has mnemonic attributes (`red`, etc.) -
  # read more on that in the next section.
  home-manager.users.sphink.programs.alacritty.settings.colors =
    with config.scheme.withHashtag;
    let
      default = {
        black = base00;
        white = base07;
        inherit
          red
          green
          yellow
          blue
          cyan
          magenta
          ;
      };
    in
    {
      primary = {
        background = base00;
        foreground = base07;
      };
      cursor = {
        text = base02;
        cursor = base07;
      };
      normal = default;
      bright = default;
      dim = default;
    };
}
