{ config, pkgs, ... }:

let
  myIp = "192.168.1.153"; # CHANGE THIS to your PC's actual IP
  gatewayIp = "192.168.1.1"; # The Orange Router's IP
in
{
  sops.secrets.mysshkey.sopsFile = ./secrets/rcon.yaml;

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  networking = {
    hostName = "nixos-core";
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
            iifname "eno1" udp dport { 67, 53 } accept
            iifname "eno1" tcp dport { 80, 443, 53 } accept
          }
        }
      '';
    };
  };

  services.unbound = {
    enable = true;
    settings.server = {
      interface = [ "127.0.0.1" "0.0.0.0" ];
      access-control = [ "127.0.0.0/8 allow" "192.168.1.0/24 allow" ];
      auto-trust-anchor-file = "${pkgs.unbound}/etc/unbound/root.key";
    };
  };

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "eno1" ];
    extraConfig = ''
      subnet 192.168.1.0 netmask 255.255.255.0 {
        range 192.168.1.100 192.168.1.200;
        option routers ${gatewayIp};
        option domain-name-servers ${myIp};
        default-lease-time 600;
        max-lease-time 7200;
      }
    '';
  };

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users.root.openssh.authorizedKeys.keyFiles = [ 
    config.sops.secrets.mysshkey.path 
  ];
}
