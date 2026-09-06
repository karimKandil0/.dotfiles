{ lib, ... }:
{
  systemd.tmpfiles.rules = [
    "d /home/karimkandil/music 0755 karimkandil users -"
  ];

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
