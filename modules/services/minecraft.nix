{ pkgs, inputs, config, lib, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.survival = {
      enable = true;
      package = pkgs.vanillaServers.vanilla-26_2;

      jvmOpts = "-Xms2G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1";

      serverProperties = {
        server-port = 25565;
        online-mode = false;
        white-list = false;
        enforce-whitelist = false;
        difficulty = "normal";
        gamemode = "survival";
        motd = "karim's server";
        max-players = 10;
        view-distance = 10;
        simulation-distance = 8;
        resource-pack = "https://download.mc-packs.net/pack/77d080d2fe207a886c8c784ac239dec54a213065.zip";
        resource-pack-sha1 = "77d080d2fe207a886c8c784ac239dec54a213065";
        resource-pack-id = "6caea614-d594-44bd-9b3d-ae4a4788ddfe";
        resource-pack-prompt = "{\"text\":\"Our server uses a custom resource pack!\", \"color\":\"gold\"}";
        require-resource-pack = true;
      };
    };
  };

  virtualisation.oci-containers.backend = "docker";

  sops.secrets.playit_secret_key = {
    mode = "0400";
  };

  virtualisation.oci-containers.containers.playit = {
    image = "ghcr.io/playit-cloud/playit-agent:1.0";
    environmentFiles = [ config.sops.secrets.playit_secret_key.path ];
    extraOptions = [ "--network=host" ];
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}
