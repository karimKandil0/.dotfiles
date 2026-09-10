{ lib, ... }:
{
  systemd.services.homepage-dashboard.environment.HOMEPAGE_ALLOWED_HOSTS = lib.mkForce "k-nix.taila13585.ts.net:8080,100.104.51.39:8080,localhost:8080";

  services.homepage-dashboard = {
    enable = true;
    listenPort = 8080;
    settings = {
      title = "k-nix";
      theme = "dark";
      color = "zinc";
      headerStyle = "clean";
      layout = {
        Network = { style = "row"; columns = 3; };
        Media = { style = "row"; columns = 3; };
        Monitoring = { style = "row"; columns = 3; };
        Files = { style = "row"; columns = 3; };
        Services = { style = "row"; columns = 3; };
      };
    };
    services = [
      {
        Network = [
          { AdGuard = { icon = "adguard-home.png"; href = "http://k-nix.taila13585.ts.net:3000"; description = "DNS ad blocking"; }; }
          { Unbound = { icon = "dns.png"; description = "DoT resolver"; }; }
        ];
      }
      {
        Media = [
          { Jellyfin = { icon = "jellyfin.png"; href = "http://k-nix.taila13585.ts.net:8096"; description = "Media server"; }; }
          { Navidrome = { icon = "navidrome.png"; href = "http://k-nix.taila13585.ts.net:4533"; description = "Music server"; }; }
          { Radarr = { icon = "radarr.png"; href = "http://k-nix.taila13585.ts.net:7878"; description = "Movies"; }; }
          { Sonarr = { icon = "sonarr.png"; href = "http://k-nix.taila13585.ts.net:8989"; description = "TV shows"; }; }
          { Prowlarr = { icon = "prowlarr.png"; href = "http://k-nix.taila13585.ts.net:9696"; description = "Indexers"; }; }
          { qBittorrent = { icon = "qbittorrent.png"; href = "http://k-nix.taila13585.ts.net:8090"; description = "Downloads"; }; }
        ];
      }
      {
        Monitoring = [
          { "Uptime Kuma" = { icon = "uptime-kuma.png"; href = "http://k-nix.taila13585.ts.net:3001"; description = "Service monitoring"; }; }
          { SearXNG = { icon = "searxng.png"; href = "http://k-nix.taila13585.ts.net:8888"; description = "Search engine"; }; }
        ];
      }
      {
        Files = [
          { Syncthing = { icon = "syncthing.png"; href = "http://k-nix.taila13585.ts.net:8384"; description = "File sync"; }; }
        ];
      }
      {
        Services = [
          { Openclaw = { href = "http://k-nix.taila13585.ts.net:18789"; description = "Darlene agent"; }; }
          { Minecraft = { icon = "minecraft.png"; description = "Survival server"; }; }
        ];
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
