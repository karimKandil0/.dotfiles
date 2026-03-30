{ pkgs, config, ... }:

# 1. Define variables and the wrapped Python environment here
let
  glowPython = pkgs.python3.withPackages (ps: with ps; [
    tinytuya
    evdev
  ]);
in
{
  # 2. Assign the service to the configuration set
  systemd.user.services.key-glow = {
    description = "Keyboard-Reactive-Lighting-Service";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    
    serviceConfig = {
      Type = "simple";
      ExecStart = "${glowPython}/bin/python3 /home/karimkandil/.dotfiles/scripts/key-glow.py";
      Restart = "always";
      RestartSec = 10;
      # Setting the HOME env ensures pywal paths resolve correctly
      Environment = "HOME=/home/karimkandil";
    };
  };
}
