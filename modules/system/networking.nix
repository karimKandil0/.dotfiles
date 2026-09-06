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
    allowedTCPPorts = [
      22     # SSH
      4533   # Navidrome
      3001   # Uptime Kuma
      8888   # Searx
      18789  # Openclaw
      8384   # Syncthing UI
    ];
    allowedUDPPorts = [ ];
  };
}
