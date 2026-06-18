{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/var/lib/cool-servers";

    servers.celebrationserver = {
      enable = true;
      package = pkgs.paperServers.paper-26_1_2;
      openFirewall = true;

      # whitelist = {
      #   BeefyBoy9009 = "a5892266-991e-47d4-9662-cd69a7426633";
      #   urfavgirlriver = "3e4cf579-783b-4dea-ab4c-35e8930fecb1";
      # };

      serverProperties = {
        gamemode = "survival";
        difficulty = "medium";
        simulation-distance = 10;
        white-list = false;
        motd = "Celebration Youth Group Minecraft Server!";
        online-mode = true;
        allow-flight = true;
      };

      symlinks = {
        plugins = "./celebrationserver/plugins";
      };

    };
  };

}
