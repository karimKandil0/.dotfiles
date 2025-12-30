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

    package = pkgs.papermc;

    openFirewall = true;

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
    };

    jvmOpts = "-Xmx4G -Xms4G";
  };

  
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
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
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
    firefox
    swww
    thonny
    pywal
    steam-run
    rofi
    fastfetch
    alsa-utils
    pulsemixer
    pulseaudio
    unrar
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

