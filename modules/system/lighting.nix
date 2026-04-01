{ pkgs, config, ... }:

let
  glowPython = pkgs.python3.withPackages (ps: with ps; [
    tinytuya
    evdev
  ]);

  # Centralized credentials to prevent mismatches
  devID = "bffb3ff22c28ecd701j0eq";
  ipAddr = "192.168.1.170";
  locKey = "sv0@{2m=Am~Y-=M@"; # Corrected Local Key
in
{
  systemd.user.services.key-glow = {
    description = "Keyboard-Reactive-Lighting-Service";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${glowPython}/bin/python3 /home/karimkandil/.dotfiles/config/scripts/key-glow.py";

      # Corrected Shutdown Logic
      ExecStop = "${glowPython}/bin/python3 -c \"import tinytuya; b=tinytuya.BulbDevice('${devID}', '${ipAddr}', '${locKey}'); b.set_version(3.5); b.turn_off()\"";

      TimeoutStopSec = 10;
      Restart = "always";
      RestartSec = 10;
      Environment = "HOME=/home/karimkandil";
    };
  };
}
