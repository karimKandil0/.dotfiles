{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];


  # Enable xdg
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services.dbus.enable = true;


  environment.etc."environment.d/10-wayland.conf".text = ''
    WAYLAND_DISPLAY=wayland-1
    XDG_CURRENT_DESKTOP=wlroots
  '';


  # Enable flakes and modern Nix features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow proprietary packages (like NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;

  # Enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Bootloader configuration
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev"; # for EFI installs
    useOSProber = true; # detects Windows/Linux dual boot
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the latest available Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hostname
  networking.hostName = "k-nix";

  # Enable networking
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Egypt/Cairo";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable X11 for graphical sessions

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    xkb.layout = "us";
  };


  # Login manager and compositor (greetd + niri)
  services.greetd.enable = false;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where-is-my-sddm-theme"; # optional, or pick your own
  };

  services.xserver.desktopManager.plasma6.enable = false; # disable DE if you just want niri
  services.xserver.windowManager.session = [
    {
      name = "niri";
      start = "${pkgs.niri}/bin/niri";
    }
  ];

  # Niri (system level)
  programs.niri.enable = true;


  # Printing service
  services.printing.enable = true;

  # Sound setup (PipeWire instead of PulseAudio)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  # Define user account
  users.users.karimkandil = {
    isNormalUser = true;
    description = "karimkandil";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable some basic programs/functions
  programs.bash.completion.enable = true;
  programs.firefox.enable = true;

  # Packages installed system-wide
  environment.systemPackages = with pkgs; [
    vim
    where-is-my-sddm-theme
    yq
    wget
    git
    nitch
    dbus
    xdg-desktop-portal
    xdg-utils
    firefox
    alacritty
    niri
    keyd
    kitty
    pulsemixer
    fastfetch
    swww
    python3
    pywal
    xplr
    nemo
    xwayland
  ];

  # KeyD setup
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overload(control, esc)";
        leftalt = "layer(nav)";
        rightalt = "layer(nav)";
      };
      # Define a "nav" layer for movement
      settings.nav = {
        w = "up";
        a = "left";
        s = "down";
        d = "right";
      };
    };
  };

  # Fonts setup
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Enable SSH
  services.openssh.enable = true;

  # NVIDIA graphics driver setup
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false; # use proprietary driver
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Define storage drive
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/69504f9c-0053-470c-99e6-e2340e672759";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };


  # This determines which NixOS release’s defaults to use.
  system.stateVersion = "25.05"; # Do not change once set.
}
