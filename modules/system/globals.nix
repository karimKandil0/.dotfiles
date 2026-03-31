{ config, pkgs, ... }:
{

  ### Import hardware config ###
  imports = [
    ../../hardware-configuration.nix
  ];

  ### initialize system config ###
  networking.hostName = "k-nix";
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.11";
  documentation.enable = false;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  ### Bootloader settings ###
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ### Enable docker and docker-compose ###
  virtualisation.docker.enable = true;


  ### Enable nix-ld ###
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libusb1
  ];

  ### WM's/Compositors ###
  programs.hyprland.enable = true;
  programs.niri.enable = true;

  ### Enable experimental features ###
  nixpkgs.config.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ### Sops-nix config ###
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.secrets.rcon_password = { };
  sops.age.keyFile = "/home/karimkandil/.config/sops/age/keys.txt";

  ### Enable support for windows filesystems ###
  boot.supportedFilesystems = [
    "ntfs"
    "ntfs3"
  ];

}
