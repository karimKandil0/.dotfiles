{ ... }:
{
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
    host = "0.0.0.0";
    port = 3000;
    settings = {
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        bootstrap_dns = [
          "9.9.9.9"
          "1.1.1.1"
        ];
        upstream_dns = [
          "https://dns.quad9.net/dns-query"
          "https://cloudflare-dns.com/dns-query"
        ];
        fallback_dns = [ "9.9.9.9" "1.1.1.1" ];
        enable_dnssec = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3000 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
