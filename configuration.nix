{ config, pkgs, zen-browser, ... }:

let
  user = "karimkandil";
  playit = pkgs.stdenv.mkDerivation rec {
    pname = "playit";
    version = "0.17.0-rc2";

    src = pkgs.fetchurl {
      url = "https://github.com/playit-cloud/playit-agent/releases/download/v0.17.0-rc2/playit-linux-amd64";
      sha256 = "12f52963687156c8d6633442904e68c4ed6906910e157fb935f56259892b2a10";
    };

    dontUnpack = true;

    installPhase = ''
      install -D $src $out/bin/playit
    '';
  };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "k-nix";
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "25.11";
  documentation.enable = false;
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];
  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.supportedFilesystems = ["ntfs" "ntfs3"];

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/69504f9c-0053-470c-99e6-e2340e672759";
    fsType = "ext4";
  };

  
  #######################
  #  MINECRAFT SERVER   #
  #######################

  services.minecraft-server = {
    enable = true;
    eula = true;

    package = pkgs.papermc.overrideAttrs (finalAttrs: previousAttrs: rec {
    version = "1.21.11";
    build = "69"; 
    
    src = pkgs.fetchurl {
        url = "https://api.papermc.io/v2/projects/paper/versions/${version}/builds/${build}/downloads/paper-${version}-${build}.jar";
        sha256 = "cf374f2af9d71dfcc75343f37b722a7abcb091c574131b95e3b13c6fc2cb8fae";
    };
});

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
      white-list = true;
      enable-rcon = true;
      "rcon.password" = "karimkandil1324";
      level-seed = "-1110700258100175300";
    };

    jvmOpts = "-Xmx6G -Xms6G";

    whitelist = {
      "karimkandil" = "28671171-8392-3708-9700-7b69be3d02e5";
      "0marMC" = "cac77651-5372-34a0-88f1-c11725caf073";
      "Ikllz" = "d4186b6f-1b88-37d1-8627-2ba88983fd5a";
      "doda" = "e50e0c35-8f11-3934-b9b1-654f33e402da";
      "omarhabib17" = "549eabd8-16d2-3c97-8098-ef82109ec9c1";
    };
  };


  systemd.services.playit = {
  description = "Playit.gg Service";
  after = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];
  serviceConfig = {
    ExecStart = "${playit}/bin/playit";
    Restart = "always";
    User = "karimkandil"; # Use your actual NixOS username
    WorkingDirectory = "/home/karimkandil";
  };
};

  hardware.uinput.enable = true;


  #######################
  #    HOMEASSISTANT    #
  #######################

  services.home-assistant = {
    enable = true;
    extraPackages = python3Packages: with python3Packages;
      [
        gtts
      ];
    extraComponents = [
      "default_config"
      "tuya"
    ];

    config = {
      default_config = {};
      http = {
        server_port = 8123;
	trusted_proxies = [ "127.0.0.1" "::1" ];
	use_x_forwarded_for = true;
      };
    };
  };


  #######################
  #       DISPLAY       #
  #######################

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };

  programs.hyprland.enable = true;


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
  #######################
  #       PORTALS       #
  #######################
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  services.gnome.gnome-keyring.enable = true;

  services.dbus.enable = true;

        ##################

        #   AUDIO        #

        ##################

        security.rtkit.enable = true;

        services.pipewire = {

          enable = true;

          alsa.enable = true;

          alsa.support32Bit = true;

          pulse.enable = true;

        };

  ##################
  #   GRAPHICS     #
  ##################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  boot.extraModprobeConfig = ''
    options snd-hda-intel model=alc221-hp-mic
  '';

  ##################
  #     USER       #
  ##################
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "wheel" "video" "seat" "input" "uinputl" "plugdev" "seatd" "lp" ];
  };

  ##################
  #   PACKAGES     #
  ##################
    environment.systemPackages = with pkgs; [
      git
      zed-editor
      bibata-cursors
      vim
      ifuse
      altserver-linux
      discord
      ripgrep
      tree-sitter
      lua
      luarocks
      antimicrox
      remote-touchpad
      wofi
      rofi
      usbutils
      btop
      ncdu
      fzf
      bat
      docker
      openssl
      zlib
      vial
      curl
      xplr
      kitty
      rcon-cli
      firefox
      swww
      thonny
      pywal
      rofi
      fastfetch
      alsa-utils
      pulsemixer
      pulseaudio
      unrar
      tailscale
      tree
      playit
      # python312Packages.ds4drv
      (qutebrowser.override { enableWideVine = true; })
      bluez-tools
    ];
     
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  
    services.udev.packages = [ pkgs.vial pkgs.game-devices-udev-rules ];
  
    system.activationScripts.steamDataDir = ''
      mkdir -p /mnt/data/steam
      chown ${user}:users /mnt/data/steam
    '';
  
    programs.steam.enable = true;
    programs.gamemode.enable = true;
    services.usbmuxd.enable = true;
  
    ##################
    #   NETWORKING   #
    ##################
  
    networking.networkmanager.enable = true;
    services.power-profiles-daemon.enable = true;
    programs.mosh.enable = true;
    services.tailscale.enable = true;
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    networking.enableIPv6 = true;
  
    networking.firewall = {
      enable = true;
      allowedUDPPorts = [ 19132 41631 25565 443 8080 ]; 
      allowedTCPPorts = [ 25565 25575 22 43634 10600 8123 ];
    };    
  
    ##################
    #     OTHER      #
    ##################
  
  ### Configure remote desktop ###
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  boot.kernelModules = [ "uinput" ];





  services.tor.enable = true;
  services.tor.client.enable = true;

  services.openssh.enable = true;

  swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.keyboard.qmk.enable = true;

  services.upower.enable = true;
  
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", KERNEL=="ttyACM*", MODE="0666", GROUP="dialout"

    # Sunshine rule
    KERNEL=="uinput", MODE="0660", GROUP="input", SYMLINK+="uinput"

    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

}

