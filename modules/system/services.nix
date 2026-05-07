{ lib, config, pkgs, inputs, ... }:
{

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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

    allowedUDPPorts = [
    ];

    allowedTCPPorts = [
      22
      3000
    ];

  };
}
