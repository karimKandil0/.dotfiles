{ ... }:
{
  services.openssh.enable = true;

  programs.mosh.enable = true;

  services.tailscale.enable = true;

  networking.networkmanager.enable = true;
  networking.enableIPv6 = true;

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
  };
}
