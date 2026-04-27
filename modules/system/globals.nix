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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.enable = false;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ libusb1 ];
  };

  programs.hyprland.enable = true;
  programs.niri.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font Mono" "JetBrainsMono Nerd Font" ];
    };
  };

  # Experimental nix CLI + flake support
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
}
