{ pkgs, lib, inputs, ... }: # Use 'inputs' here

let
  # Adjust "x86_64-linux" to "aarch64-linux" if you are on ARM/Apple Silicon
  playit-bin = inputs.playit.packages."x86_64-linux".default;
in
{
  services.playit = {
    enable = true;
    secretPath = "/var/lib/playit/secret.toml";
  };

  systemd.services.playit.serviceConfig = {
    StateDirectory = "playit";
    ReadWritePaths = [ "/var/lib/playit" ];
    ExecStart = lib.mkForce "${playit-bin}/bin/playit --secret-path /var/lib/playit/secret.toml start";
  };
}
