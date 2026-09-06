{ ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts."k-nix.taila13585.ts.net" = {
      extraConfig = ''
        tls {
          get_certificate tailscale
        }
        reverse_proxy localhost:3000
      '';
    };

    virtualHosts."navidrome.k-nix.taila13585.ts.net" = {
      extraConfig = ''
        tls {
          get_certificate tailscale
        }
        reverse_proxy localhost:4533
      '';
    };

    virtualHosts."status.k-nix.taila13585.ts.net" = {
      extraConfig = ''
        tls {
          get_certificate tailscale
        }
        reverse_proxy localhost:3001
      '';
    };

    virtualHosts."openclaw.k-nix.taila13585.ts.net" = {
      extraConfig = ''
        tls {
          get_certificate tailscale
        }
        reverse_proxy localhost:18789
      '';
    };

    virtualHosts."search.k-nix.taila13585.ts.net" = {
      extraConfig = ''
        tls {
          get_certificate tailscale
        }
        reverse_proxy localhost:8888
      '';
    };
  };

  # Caddy needs access to Tailscale socket to request certs
  users.users.caddy.extraGroups = [ "tailscale" ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
