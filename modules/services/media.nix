{ lib, ... }:
{
  systemd.services."docker-radarr".after = [ "mnt-hdd.mount" ];
  systemd.services."docker-radarr".requires = [ "mnt-hdd.mount" ];
  systemd.services."docker-sonarr".after = [ "mnt-hdd.mount" ];
  systemd.services."docker-sonarr".requires = [ "mnt-hdd.mount" ];
  systemd.services."docker-lidarr".after = [ "mnt-hdd.mount" ];
  systemd.services."docker-lidarr".requires = [ "mnt-hdd.mount" ];
  systemd.services."docker-sabnzbd".after = [ "mnt-hdd.mount" ];
  systemd.services."docker-sabnzbd".requires = [ "mnt-hdd.mount" ];
  systemd.services."docker-qbittorrent".after = [ "mnt-hdd.mount" ];
  systemd.services."docker-qbittorrent".requires = [ "mnt-hdd.mount" ];

  # Media directories
  systemd.tmpfiles.rules = [
    "d /mnt/hdd/media 0755 karimkandil users -"
    "d /mnt/hdd/media/movies 0755 karimkandil users -"
    "d /mnt/hdd/media/tv 0755 karimkandil users -"
    "d /mnt/hdd/media/downloads 0755 karimkandil users -"
    "d /mnt/hdd/media/music 0755 karimkandil users -"
    "d /var/lib/arr/radarr 0755 karimkandil users -"
    "d /var/lib/arr/sonarr 0755 karimkandil users -"
    "d /var/lib/arr/prowlarr 0755 karimkandil users -"
    "d /var/lib/arr/qbittorrent 0755 karimkandil users -"
    "d /var/lib/arr/sabnzbd 0755 karimkandil users -"
    "d /var/lib/arr/lidarr 0755 karimkandil users -"
    "d /var/cache/jellyfin 0755 karimkandil users -"
    "d /var/cache/jellyfin/transcodes 0755 karimkandil users -"
  ];

  # Jellyfin as NixOS service for hardware transcoding access
  services.jellyfin = {
    enable = true;
    user = "karimkandil";
    group = "users";
    openFirewall = false;
  };

  # Arr stack in Docker
  virtualisation.oci-containers.containers = {
    qbittorrent = {
      image = "lscr.io/linuxserver/qbittorrent:latest";
      ports = [ "8090:8090" ];
      environment = {
        PUID = "1000";
        PGID = "100";
        TZ = "Africa/Cairo";
        WEBUI_PORT = "8090";
      };
      volumes = [
        "/var/lib/arr/qbittorrent:/config"
        "/mnt/hdd/media/downloads:/downloads"
      ];
    };

    radarr = {
      image = "lscr.io/linuxserver/radarr:latest";
      ports = [ "7878:7878" ];
      environment = {
        PUID = "1000";
        PGID = "100";
        TZ = "Africa/Cairo";
      };
      volumes = [
        "/var/lib/arr/radarr:/config"
        "/mnt/hdd/media/movies:/movies"
        "/mnt/hdd/media/downloads:/downloads"
      ];
    };

    sonarr = {
      image = "lscr.io/linuxserver/sonarr:latest";
      ports = [ "8989:8989" ];
      environment = {
        PUID = "1000";
        PGID = "100";
        TZ = "Africa/Cairo";
      };
      volumes = [
        "/var/lib/arr/sonarr:/config"
        "/mnt/hdd/media/tv:/tv"
        "/mnt/hdd/media/downloads:/downloads"
      ];
    };

    sabnzbd = {
      image = "lscr.io/linuxserver/sabnzbd:latest";
      ports = [ "8085:8080" ];
      environment = {
        PUID = "1000";
        PGID = "100";
        TZ = "Africa/Cairo";
      };
      volumes = [
        "/var/lib/arr/sabnzbd:/config"
        "/mnt/hdd/media/downloads:/downloads"
      ];
    };

    lidarr = {
      image = "lscr.io/linuxserver/lidarr:latest";
      ports = [ "8686:8686" ];
      environment = {
        PUID = "1000";
        PGID = "100";
        TZ = "Africa/Cairo";
      };
      volumes = [
        "/var/lib/arr/lidarr:/config"
        "/mnt/hdd/media/music:/music"
        "/mnt/hdd/media/downloads:/downloads"
      ];
    };

    prowlarr = {
      image = "lscr.io/linuxserver/prowlarr:latest";
      ports = [ "9696:9696" ];
      environment = {
        PUID = "1000";
        PGID = "100";
        TZ = "Africa/Cairo";
      };
      volumes = [
        "/var/lib/arr/prowlarr:/config"
      ];
    };
  };

  # Jellyfin hardware transcoding (nvidia)
  hardware.nvidia.open = lib.mkDefault false;

  networking.firewall.allowedTCPPorts = [ 8096 8090 8085 7878 8989 8686 9696 ];
}
