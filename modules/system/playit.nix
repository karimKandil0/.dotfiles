{ pkgs, lib, ... }:
{
  # Run playit tunnel in a dedicated tmux session.
  services.playit = {
    enable = false;
    secretPath = "/var/lib/playit/secret.toml";
  };

  systemd.services.playit.serviceConfig = lib.mkForce {
    ExecStart = "${pkgs.tmux}/bin/tmux new-session -d -s playit-tunnel '/run/current-system/sw/bin/playit-cli --secret_path /var/lib/playit/secret.toml start'";
    ExecStop = "${pkgs.tmux}/bin/tmux kill-session -t playit-tunnel";

    Type = "forking";
    User = "root";
    Restart = "always";
  };
}
