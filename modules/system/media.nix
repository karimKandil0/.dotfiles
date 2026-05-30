{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "d /mnt/storage/music              0755 root root -"
    "d /mnt/storage/downloads          0755 root root -"
    "d /mnt/storage/downloads/complete   0755 root root -"
    "d /mnt/storage/downloads/incomplete 0755 root root -"
    "d /mnt/storage/downloads/slskd      0755 root root -"
  ];

  # Navidrome — music server (port 4533)
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/mnt/storage/music";
      Address = "0.0.0.0";
      Port = 4533;
      ScanSchedule = "@every 1h";
    };
  };

  # Lidarr — music collection manager (port 8686)
  services.lidarr = {
    enable = true;
    user = "root";
    group = "root";
    dataDir = "/var/lib/lidarr";
  };

  # Prowlarr — indexer manager (port 9696, runs as DynamicUser)
  services.prowlarr.enable = true;

  # slskd — Soulseek client with REST API (port 5030 web, 5031 api)
  systemd.services.slskd = {
    description = "slskd Soulseek client";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    preStart = "mkdir -p /var/lib/slskd";
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStart = "${pkgs.slskd}/bin/slskd --app-dir /var/lib/slskd";
      Restart = "on-failure";
    };
  };

  # qBittorrent — torrent client (port 8080)
  systemd.services.qbittorrent = {
    description = "qBittorrent-nox";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    preStart = "mkdir -p /var/lib/qbittorrent";
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=8080 --profile=/var/lib/qbittorrent";
      Restart = "on-failure";
    };
  };
}
