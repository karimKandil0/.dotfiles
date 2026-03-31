{ pkgs, lib, inputs, ... }:

### Make systemd service for playit tmux session ###

let
  playit-pkg = inputs.playit.packages."x86_64-linux".default;
in
{
  services.playit = {
    enable = true;
    secretPath = "/var/lib/playit/secret.toml";
  };

  systemd.services.playit.serviceConfig = lib.mkForce {
  # Start a detached tmux session and run the command
  ExecStart = "${pkgs.tmux}/bin/tmux new-session -d -s playit-tunnel '/run/current-system/sw/bin/playit-cli --secret_path /var/lib/playit/secret.toml start'";
  
  # Tell systemd to kill the whole tmux session when stopping
  ExecStop = "${pkgs.tmux}/bin/tmux kill-session -t playit-tunnel";
  
  Type = "forking"; # Crucial for tmux
  User = "root";
  Restart = "always";
  };
}
