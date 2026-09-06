{ pkgs, ... }:
let
  domain = "k-nix.taila13585.ts.net";
  certDir = "/var/lib/tailscale-certs";
in
{
  # Provision Tailscale cert before Caddy starts
  systemd.services.tailscale-cert = {
    description = "Provision Tailscale TLS cert for Caddy";
    after = [ "tailscaled.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "caddy.service" ];
    before = [ "caddy.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "tailscale-cert" ''
        mkdir -p ${certDir}
        ${pkgs.tailscale}/bin/tailscale cert \
          --cert-file ${certDir}/${domain}.crt \
          --key-file  ${certDir}/${domain}.key \
          ${domain}
        chown caddy:caddy ${certDir}/${domain}.crt ${certDir}/${domain}.key
        chmod 640 ${certDir}/${domain}.crt ${certDir}/${domain}.key
      '';
    };
  };

  # Re-provision cert weekly (Tailscale certs expire after 90 days)
  systemd.timers.tailscale-cert = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."${domain}" = {
      extraConfig = ''
        tls ${certDir}/${domain}.crt ${certDir}/${domain}.key

        handle_path /music* {
          reverse_proxy localhost:4533
        }
        handle_path /status* {
          reverse_proxy localhost:3001
        }
        handle_path /search* {
          reverse_proxy localhost:8888
        }
        handle_path /openclaw* {
          reverse_proxy localhost:18789
        }
        handle {
          reverse_proxy localhost:3000
        }
      '';
    };
  };

  systemd.tmpfiles.rules = [
    "d ${certDir} 0750 root caddy -"
  ];

  users.users.caddy.extraGroups = [ "tailscale" ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
