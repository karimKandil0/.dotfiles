{ pkgs, ... }:
{
  imports = [ ../../hardware-configuration.nix ];

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [
    "ntfs"
    "ntfs3"
  ];

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/d040eeb3-a134-449c-a830-da0c8741dff5";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.secrets.rcon_password = { };
  sops.age.keyFile = "/home/karimkandil/.config/sops/age/keys.txt";
}
