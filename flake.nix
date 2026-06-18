{
  description = "Flake for the server";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    { self, nixpkgs, nixpkgs-unstable }:
    let
      linux = "x86_64-linux";
      mkSystem =
        pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          networking.hostName = hostname;
          modules = [
            ./hosts/${hostname}/user.nix
          ];

        };
    in
    {
      nixosConfigurations = {
        nixserver01 = mkSystem nixpkgs linux "nixserver01";
      };

    };
}
