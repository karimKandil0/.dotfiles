{ config, pkgs, ... }:

let
  myIp = "192.168.1.15"; # Verify this is your PC's IP
  gatewayIp = "192.168.1.1"; # Your Orange Router
in
{
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  networking = {
    useDHCP = false;
    interfaces.eno1.ipv4.addresses = [{
      address = myIp;
      prefixLength = 24;
    }];
    defaultGateway = gatewayIp;
    nameservers = [ "127.0.0.1" ];

  nftables = {
      enable = true;
      ruleset = ''
        table inet filter {
          chain input {
            type filter hook input priority 0; policy drop;
            ct state established,related accept
            iifname lo accept
            iifname { "eno1", "tailscale0" } tcp dport 2222 accept
            # Added port 67 (DHCP) and 53 (DNS)
            iifname "eno1" udp dport { 67, 53 } accept
            iifname "eno1" tcp dport { 80, 443, 53 } accept
          }
        }
      '';
    };
  };

  # dnsmasq replaces both dhcpd4 and unbound
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "eno1";
      # DHCP Range: Give out IPs from .100 to .200
      dhcp-range = [ "192.168.1.100,192.168.1.200,12h" ];
      # Tell devices the Orange Router is the Gateway
      dhcp-option = [ "3,${gatewayIp}" ];
      # Use your NixOS PC as the DNS server
      server = [ "1.1.1.1" "8.8.8.8" ]; # Upstream DNS
      # Cache DNS for speed
      cache-size = 1000;
      address = "/doubleclick.net/127.0.0.1";
    };
  };

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [ 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF4sRQsL8JmkqfTST6RGduCr31xwpB6awSspqAJVlTGH root@localhost"
  ];
}
