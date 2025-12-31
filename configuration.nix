{ config, pkgs, zen-browser, ... }:

let
  user = "karimkandil";
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "k-nix";
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "25.05";
  documentation.enable = false;
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

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

      view-distance = 10;
      simulation-distance = 8;

      online-mode = false;
      enforce-secure-profile = false;
      white-list = true;
      enable-rcon = true;
      "rcon.password" = "karimkandil1324";
      level-seed = "-1110700258100175300";
    };

    jvmOpts = "-Xmx4G -Xms4G";
  };
  
  ### Manually open ports for game ###
  networking.firewall.allowedTCPPorts = [ 25565 ];

  
  #######################
  #    QTILE+XSERVER    #
  #######################

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = false;
    windowManager.i3.enable = false;
  };

  programs.hyprland.enable = true;


  services.displayManager.ly = {
    enable = true;
    settings = {
      systemd = true;
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
    extraGroups = [ "networkmanager" "wheel" "video" "seat" "input" "uinputl" "plugdev" "seatd" ];
  };

  ##################
  #   PACKAGES     #
  ##################
  environment.systemPackages = with pkgs; [
    git
    zed-editor
    bibata-cursors
    vim
    ripgrep
    vial
    curl
    xplr
    waybar
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
  ];
   
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.udev.packages = [ pkgs.vial ];

  system.activationScripts.steamDataDir = ''
    mkdir -p /mnt/data/steam
    chown ${user}:users /mnt/data/steam
  '';

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  ##################
  #   NETWORKING   #
  ##################

  networking.networkmanager.enable = true;
  services.power-profiles-daemon.enable = true;
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  networking.firewall.allowedUDPPorts = [ 41631 25565 ];

  ##################
  #     OTHER      #
  ##################

  services.openssh.enable = true;

  # Bootloader — enable systemd-boot (EFI). Keep these if your system boots with EFI.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  hardware.keyboard.qmk.enable = true;
  
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", KERNEL=="ttyACM*", MODE="0666", GROUP="dialout"
  '';

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}

