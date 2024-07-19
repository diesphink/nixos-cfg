{
  description = "nixos configuration - sphink";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

      # Overlays
      # nixpkgs-stable
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };

    in
    {

      nixosConfigurations = {
        ford = lib.nixosSystem {
          inherit system;

          modules = [
            stylix.nixosModules.stylix
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.sphink = {
                imports = [ ./home.nix ];
              };
            }

            # Make sure you add Overlays here
            (
              { config, pkgs, ... }:
              {
                nixpkgs.overlays = [ overlay-stable ];
              }
            )

          ];
        };
      };
    };
}
