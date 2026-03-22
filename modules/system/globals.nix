{ config, pkgs, ... }:
{

  imports = [
    ../../hardware-configuration.nix
  ];

  networking.hostName = "k-nix";
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  virtualisation.docker.enable = true;

  system.stateVersion = "25.11";
  documentation.enable = false;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libusb1
  ];

  programs.hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.secrets.rcon_password = { };
  sops.age.keyFile = "/home/karimkandil/.config/sops/age/keys.txt";

  boot.supportedFilesystems = [
    "ntfs"
    "ntfs3"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/69504f9c-0053-470c-99e6-e2340e672759";
    fsType = "ext4";
  };
}
