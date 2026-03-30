  let
    glowPython = pkgs.python3.withPackages (ps: with ps; [
      tinytuya
      evdev
      numpy
    ]);
  in
  {
    systemd.user.services.key-glow = {
      description = "Keyboard-Reactive-Lighting-Service";
      wantedBy = [ "graphical-session-target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        Type = "simple";
	ExecStart = "${glowPyhton/bin/python3 /home/karimkandil/.dotfiles/config/scripts/key-glow.py}";
	Restart = "always";
	RestartSec = 5;
	Environment = "HOME=/home/karimkandil";
      };
    };
  }

