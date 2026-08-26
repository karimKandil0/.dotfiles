{ pkgs, inputs, config, lib, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    inputs.playit-nixos-module.nixosModules.playit
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.survival = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_1;

      jvmOpts = "-Xms2G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1";

      serverProperties = {
        server-port = 25565;
        online-mode = false;
        white-list = true;
        enforce-whitelist = true;
        difficulty = "normal";
        gamemode = "survival";
        motd = "karim's server";
        max-players = 10;
        level-seed = "608548899648438462";
        view-distance = 10;
        simulation-distance = 8;
      };
    };
  };

  sops.secrets.playit_auth_token = {
    owner = "playit";
    mode = "0400";
  };

  services.playit = {
    enable = true;
    secretFile = config.sops.secrets.playit_auth_token.path;
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}
