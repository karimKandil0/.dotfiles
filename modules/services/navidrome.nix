{ lib, ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/mnt/hdd/media/music";
      Address = "0.0.0.0";
      Port = 4533;
      ScanSchedule = "@every 1h";
    };
  };

  systemd.services.navidrome.serviceConfig = {
    ProtectHome = lib.mkForce false;
    BindReadOnlyPaths = [ "/mnt/hdd/media/music" ];
  };
}
