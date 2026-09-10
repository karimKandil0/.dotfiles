{ ... }:
{
  systemd.tmpfiles.rules = [
    "d /var/lib/jellyseerr 0755 karimkandil users -"
    "d /var/lib/portainer 0755 root root -"
  ];

  virtualisation.oci-containers.containers = {
    jellyseerr = {
      image = "fallenbagel/jellyseerr:latest";
      ports = [ "5055:5055" ];
      environment = {
        TZ = "Africa/Cairo";
        LOG_LEVEL = "debug";
      };
      volumes = [
        "/var/lib/jellyseerr:/app/config"
      ];
    };

    portainer = {
      image = "portainer/portainer-ce:latest";
      ports = [ "9000:9000" ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/var/lib/portainer:/data"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 5055 9000 ];
}
