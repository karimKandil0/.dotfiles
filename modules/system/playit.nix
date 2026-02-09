{ pkgs, lib, inputs, ... }:

let
  playit-pkg = inputs.playit.packages."x86_64-linux".default;
in
{
  services.playit = {
    enable = true;
    secretPath = "/var/lib/playit/secret.toml";
  };

  systemd.services.playit.serviceConfig = lib.mkForce {
    Type = "simple";
    Restart = "always";
    StateDirectory = "playit"; 
    # Change --secret-path to --secret_path
    ExecStart = "${lib.getExe playit-pkg} --secret_path /var/lib/playit/secret.toml start";
    User = "root"; 
  };
}
