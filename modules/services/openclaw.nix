{ ... }:
{
  virtualisation.oci-containers.containers = {
    openclaw-gateway = {
      image = "ghcr.io/openclaw/openclaw:latest";
      ports = [
        "18789:18789"
        "18790:18790"
      ];
      environment = {
        HOME = "/home/node";
        TERM = "xterm-256color";
        OPENCLAW_CONFIG_DIR = "/home/node/.openclaw";
        OPENCLAW_WORKSPACE_DIR = "/home/node/.openclaw/workspace";
        OPENCLAW_GATEWAY_TOKEN = "f5a9765d32dd76924140c7843fb4e0281075a8e8f4d08f8594e654087b98f115";
        OPENCLAW_GATEWAY_BIND = "lan";
        OPENCLAW_DISABLE_BONJOUR = "";
        TZ = "Africa/Cairo";
      };
      volumes = [
        "/home/karimkandil/.openclaw:/home/node/.openclaw"
        "/home/karimkandil/.mcp-auth:/home/node/.mcp-auth"
        "/home/karimkandil/project0:/home/node/.openclaw/workspace-darlene_project0/project0"
        "/home/karimkandil/bsmart-showroom:/home/node/.openclaw/workspace-dad/bsmart-showroom"
      ];
      extraOptions = [
        "--cap-drop=NET_RAW"
        "--cap-drop=NET_ADMIN"
        "--security-opt=no-new-privileges:true"
        "--add-host=host.docker.internal:host-gateway"
        "--init"
        "--health-cmd=node -e \"fetch('http://127.0.0.1:18789/healthz').then((r)=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))\""
        "--health-interval=30s"
        "--health-timeout=5s"
        "--health-retries=5"
        "--health-start-period=20s"
      ];
      cmd = [ "node" "dist/index.js" "gateway" "--bind" "lan" "--port" "18789" ];
    };

    openclaw-cli = {
      image = "ghcr.io/openclaw/openclaw:latest";
      environment = {
        HOME = "/home/node";
        TERM = "xterm-256color";
        OPENCLAW_CONFIG_DIR = "/home/node/.openclaw";
        OPENCLAW_WORKSPACE_DIR = "/home/node/.openclaw/workspace";
        OPENCLAW_GATEWAY_TOKEN = "f5a9765d32dd76924140c7843fb4e0281075a8e8f4d08f8594e654087b98f115";
        BROWSER = "echo";
        TZ = "Africa/Cairo";
      };
      volumes = [
        "/home/karimkandil/.openclaw:/home/node/.openclaw"
      ];
      extraOptions = [
        "--cap-drop=NET_RAW"
        "--cap-drop=NET_ADMIN"
        "--security-opt=no-new-privileges:true"
        "--network=container:openclaw-gateway"
        "--init"
      ];
      entrypoint = "node";
      cmd = [ "dist/index.js" ];
      dependsOn = [ "openclaw-gateway" ];
    };
  };
}
