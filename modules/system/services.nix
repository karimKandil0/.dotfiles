{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  # Module imports & overlays
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Minecraft servers
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/var/lib/minecraft";

    servers = {

      za2azee2-smp = {
        enable = false;

        package = pkgs.papermc.overrideAttrs (
          finalAttrs: previousAttrs: rec {
            version = "1.21.11";
            build = "69";

            src = pkgs.fetchurl {
              url = "https://api.papermc.io/v2/projects/paper/versions/${version}/builds/${build}/downloads/paper-${version}-${build}.jar";
              sha256 = "cf374f2af9d71dfcc75343f37b722a7abcb091c574131b95e3b13c6fc2cb8fae";
            };
          }
        );

        openFirewall = false;

        serverProperties = {
          server-port = 25565;
          motd = "za'azee' smp";
          gamemode = "survival";
          difficulty = "normal";

          view-distance = 6;
          simulation-distance = 4;

          online-mode = false;
          enforce-secure-profile = false;
          enable-rcon = true;
          "rcon.password" = config.sops.secrets.rcon_password.path;
          "rcon.port" = 25576;
          level-seed = "-1110700258100175300";
        };

        jvmOpts = "-Xmx6G -Xms4G";
      };

      za2azee2-fabric = {
        enable = true;
        package = pkgs.fabricServers.fabric;

        serverProperties = {
          server-port = 25566;
          online-mode = false;
          motd = "za'azee' modded";
          gamemode = "survival";
          difficulty = "normal";
          view-distance = 6;
          simulation-distance = 4;
          enforce-secure-profile = false;
          enable-rcon = true;
          "rcon.password" = config.sops.secrets.rcon_password.path;
          resource-pack = "https://download.mc-packs.net/pack/1424153303a5100ae91c04c90a29cc301d3b96a1.zip";
          resource-pack-sha1 = "1424153303a5100ae91c04c90a29cc301d3b96a1";
          require-resource-pack = true;
        };

        jvmOpts = "-Xmx8G -Xms4G";
      };
    };

  };

  # n8n setup
  services.n8n = {
    enable = false;
  };

  # Desktop & local AI helpers
  services.ollama = {
    enable = false;
    acceleration = "cuda";
    package = pkgs.ollama.override {
      cudaArches = [ "61" ];
    };
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      systemd = true;
      animation = "matrix";
      animate = true;
      blank-box = false;
    };
  };

  services.udisks2.enable = true;
  security.polkit.enable = true;

  # Portals & session services
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;
  security.rtkit.enable = true;
  services.usbmuxd.enable = true;

  # Self-hosted apps
  services.vaultwarden = {
    enable = true;
      config = {
        DOMAIN = "https://k-nix.taila13585.ts.net";
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        SIGNUPS_ALLOWED = true;
      };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.immich = {
    enable = false;
    port = 2283;
    host = "127.0.0.1";
    mediaLocation = "/mnt/data/immich";
  };

  # Reverse proxy hosts
  services.caddy = {
    enable = false;
    virtualHosts = {
      "k-nix.taila13585.ts.net" = {
        extraConfig = "reverse_proxy localhost:8222"; # Vaultwarden
      };
      # Add http:// prefix to disable automatic TLS redirection/handshake
      "http://k-nix.taila13585.ts.net:444" = {
        extraConfig = "reverse_proxy localhost:2283"; # Immich
      };
    };
  };

  # System & hardware daemons
  systemd.services.caddy.serviceConfig.AmbientCapabilities = "CAP_NET_BIND_SERVICE";
  systemd.services.tailscaled.serviceConfig.Environment = [ "TS_PERMIT_CERT_UID=caddy" ];
  services.tor.enable = false;
  services.tor.client.enable = false;
  services.openssh.enable = true;
  services.upower.enable = true;
  networking.networkmanager.enable = true;
  services.power-profiles-daemon.enable = true;

  # Connectivity tooling
  programs.mosh.enable = true;
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.enableIPv6 = true;
  networking.firewall.checkReversePath = "loose";
  networking.firewall = {

    enable = true;

    # UDP ports required for game servers and QUIC-capable endpoints
    allowedUDPPorts = [
      # Minecraft Ports
      25565
      25566
      443
      53
      123
      # Web
    ];

    # TCP ports required by exposed services
    allowedTCPPorts = [
      # Minecraftt
      25565
      25566
      #Web
      8222
      8081
      # SSH
      22
    ];

  };
}
