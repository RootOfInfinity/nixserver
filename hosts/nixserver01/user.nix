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
  networking.interfaces.eno1 = {
    ipv4.addresses = [{
      address = "192.168.0.200";
      prefixLength = 24;
    }];
  };
  networking.defaultGateway = {
    address = "192.168.0.1";
    interface = "eno1";
  };
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    package = pkgs-unstable.minecraft-server;
    declarative = true;
    # /var/lib/minecraft
    # minecraft-server.service systemd
    whitelist = {
      BeefyBoy9009 = "a5892266-991e-47d4-9662-cd69a7426633";
      urfavgirlriver = "3e4cf579-783b-4dea-ab4c-35e8930fecb1";
    };

    serverProperties = {
      gamemode = "survival";
      difficulty = "medium";
      simulation-distance = 10;
      white-list = true;
      motd = "Celebration Youth Group Minecraft Server!";
      online-mode = true;
      allow-flight = true;
      
    };
  };
}
