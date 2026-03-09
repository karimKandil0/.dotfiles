{ config, pkgs, ... }:

{
  # 1. Kernel Optimizations for Speed
  boot.kernel.sysctl = {
    # BBR Congestion Control
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    
    # Increase network buffer sizes for high-speed downloads
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    
    # Speed up connection establishment
    "net.ipv4.tcp_fastopen" = 3;
  };

  networking = {
    hostName = "k-nix";
    # Use DHCP normally so you don't fight the router
    useDHCP = true; 
    
    # Force your PC to look at itself for DNS first
    nameservers = [ "127.0.0.1" ];

    # Simple firewall - only allow SSH from Tailscale
    nftables.enable = true;
    firewall.allowedTCPPorts = [ 2222 ];
  };

  # 2. Ultra-Fast Local DNS Cache
  services.dnsmasq = {
    enable = true;
    settings = {
      # ONLY listen on your own machine (ignore the family)
      listen-address = "127.0.0.1";
      bind-interfaces = true;
      
      # Upstream servers (Cloudflare is usually the fastest)
      server = [ "1.1.1.1" "1.0.0.1" ];
      
      # Huge cache for instant second-time loads
      cache-size = 10000;
      
      # Speed tweaks
      no-negcache = true; # Don't remember "Site not found" errors
      dns-forward-max = 150;
    };
  };
}
