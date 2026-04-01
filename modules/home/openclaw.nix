{ lib, config, pkgs, inputs, ... }:
{

  ### Init Sops-nix ###
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops.age.keyFile = "/home/karimkandil/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  sops.secrets."openclaw/gateway_token" = {};
  sops.secrets."openclaw/bot_token" = {};
  sops.secrets."openclaw/n8n_api_key" = {};

  programs.openclaw = {
    enable = true;
    config = {

      gateway = {
        mode = "local";
        auth = {
          token = config.sops.secrets."openclaw/gateway_token".path;
        };
        port = 18789;
        bind = "lan";
        controlUi = {
          allowedOrigins = [
            "http://localhost:18789"
            "http://127.0.0.1:18789"
            "http://192.168.1.143:18789"
            "http://100.104.51.39:18789"
            "http://k-nix.taila13585.ts.net:18789"
            "https://k-nix.taila13585.ts.net"
          ];
        };
      };

      agents = {
        defaults = {
          model = "openai-codex/gpt-5.3-codex";
          workspace = "/home/karimkandil/.openclaw/workspace";
        };
      };

      channels.telegram = {
        tokenFile = config.sops.secrets."openclaw/bot_token".path;
        allowFrom = [ 6394203980 ];
      };

      mcp = {
        servers = {
          n8n = {
            command = "npx";
            args = [
              "-y"
              "n8n-mcp"
            ];
            env = {
              MCP_MODE = "stdio";
              LOG_LEVEL = "error";
              DISABLE_CONSOLE_OUTPUT = "true";
              N8N_API_URL = "http://127.0.0.1:5678";
              N8N_API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5ZjE5ZmNiYi1mM2ZiLTQ1NDktYjg1NC05MmZhYTMwM2UxYTUiLCJpc3MiOiJuOG4iLCJhdWQiOiJwdWJsaWMtYXBpIiwiaWF0IjoxNzc1MDc2NjI4LCJleHAiOjE3Nzc1ODI4MDB9.y4I2CqY6p9kkt-LDnczHvmaJUCQgToxmUFyjlNPf5VA";
            };
          };
        };
      };

    };

  };
}
