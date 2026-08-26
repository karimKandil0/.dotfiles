{ config, pkgs, lib, ... }:

let
  dl-music = pkgs.writeShellScriptBin "dl-music" ''
    set -e
    if [ -z "$1" ]; then
      echo "usage: dl-music <youtube-music-url>"
      exit 1
    fi
    exec ${pkgs.yt-dlp}/bin/yt-dlp \
      -x \
      --audio-format mp3 \
      --audio-quality 0 \
      --embed-metadata \
      --embed-thumbnail \
      --downloader aria2c \
      --downloader-args "aria2c:-x 16 -s 16" \
      --parse-metadata "%(album_artist,artist)s:%(meta_album_artist)s" \
      -o "/home/karimkandil/music/%(album_artist,artist)s/%(album,title)s/%(track_number|)s%(track_number& - |)s%(title)s.%(ext)s" \
      "$@"
  '';
in
{
  systemd.tmpfiles.rules = [
    "d /home/karimkandil/music       0755 karimkandil      users  -"
  ];

  environment.systemPackages = [ dl-music ];

  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "3001";
      HOST = "0.0.0.0";
    };
  };

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server.port = 8888;
      server.bind_address = "0.0.0.0";
      server.secret_key = "changeme";
      ui.default_theme = "simple";
      search.safe_search = 0;
    };
  };

  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/home/karimkandil/music";
      Address = "0.0.0.0";
      Port = 4533;
      ScanSchedule = "@every 1h";
    };
  };

  systemd.services.navidrome.serviceConfig = {
    ProtectHome = lib.mkForce false;
    BindReadOnlyPaths = [ "/home/karimkandil/music" ];
  };
}
