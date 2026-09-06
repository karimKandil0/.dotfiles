{ pkgs, ... }:
let
  domain = "k-nix.taila13585.ts.net";
  certDir = "/var/lib/tailscale-certs";
in
{
  systemd.services.tailscale-cert = {
    description = "Provision Tailscale TLS cert for Caddy";
    after = [ "tailscaled.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    before = [ "caddy.service" ];
    wantedBy = [ "multi-user.target" ];
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
        reverse_proxy localhost:3000
      '';
    };
  };

  systemd.tmpfiles.rules = [
    "d ${certDir} 0750 root caddy -"
  ];

  users.users.caddy.extraGroups = [ "tailscale" ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
