{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  networking.hostName = "nixserver01";
  imports = [
    ../../nixos/configuration.nix
    ../../nixos/packages.nix
    ./hardware-configuration.nix
  ];
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs-unstable.minecraft-server;
    declarative = true;
    # /var/lib/minecraft
    # minecraft-server.service systemd

    serverProperties = {
      gamemode = "survival";
      difficulty = "medium";
      simulation-distance = 10;
    };
  };
}
