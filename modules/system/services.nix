{ config, pkgs, ... }:
{
  services.minecraft-server = {
    enable = true;
    eula = true;

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

    declarative = true;
    serverProperties = {
      server-port = 25565;
      motd = "za'azee' multiverse";
      gamemode = "survival";
      difficulty = "normal";

      view-distance = 6;
      simulation-distance = 4;

      online-mode = false;
      enforce-secure-profile = false;
      #      white-list = true;
      enable-rcon = true;
      "rcon.password" = "karimkandil1324";
      level-seed = "-1110700258100175300";
    };

    jvmOpts = "-Xmx6G -Xms4G";

    #    whitelist = {
    #     "karimkandil" = "28671171-8392-3708-9700-7b69be3d02e5";
    #    "0marMC" = "cac77651-5372-34a0-88f1-c11725caf073";
    #   "Ikllz" = "d4186b6f-1b88-37d1-8627-2ba88983fd5a";
    #  "doda" = "e50e0c35-8f11-3934-b9b1-654f33e402da";
    # "omarhabib17" = "549eabd8-16d2-3c97-8098-ef82109ec9c1";
    #   };
  };

  services.home-assistant = {
    enable = true;
    extraPackages =
      python3Packages: with python3Packages; [
        gtts
      ];
    extraComponents = [
      "default_config"
      "tuya"
    ];

    config = {
      default_config = { };
      http = {
        server_port = 8123;
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];
        use_x_forwarded_for = true;
      };
    };
  };

  services.ollama = {
    enable = true;
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
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  services.tor.enable = true;
  services.tor.client.enable = true;
  services.openssh.enable = true;
  services.upower.enable = true;
  networking.networkmanager.enable = true;
  services.power-profiles-daemon.enable = true;
  programs.mosh.enable = true;
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.enableIPv6 = true;
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      19132
      41631
      25565
      443
      8080
    ];
    allowedTCPPorts = [
      25565
      18789
      25575
      22
      43634
      10600
      8123
    ];
  };
}
