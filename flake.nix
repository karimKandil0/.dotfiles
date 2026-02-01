{
  description = "karim's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:youwen5/zen-browser-flake";

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    openclaw = {
      url = "github:openclaw/nix-openclaw";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      mango,
      openclaw,
      ...
    }:
    let
      system = "x86_64-linux";

      myZen = zen-browser.packages.${system}.default;

      # ─────────────────────────────────────────────────────────────
      # 🔧 ADDITIVE FIX: patch openclaw-gateway runtime docs
      # ─────────────────────────────────────────────────────────────
      openclawGatewayUpstream = openclaw.packages.${system}.openclaw-gateway;

      openclawDocsOverlay = final: prev: {
        openclaw = openclaw.packages.${final.system}.openclaw;

        openclaw-gateway = openclaw.packages.${final.system}.openclaw-gateway.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            echo "Installing OpenClaw workspace templates (gateway)"
            mkdir -p $out/lib/openclaw/docs/reference
            cp -r docs/reference/templates $out/lib/openclaw/docs/reference/
          '';
        });
      };
    in
    {
      nixosConfigurations.k-nix = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix

          {
            # keep ALL existing overlays, just append the fix
            nixpkgs.overlays = [
              openclawDocsOverlay
            ];

            # critical: HM must reuse system pkgs
            home-manager.useGlobalPkgs = true;

            home-manager.extraSpecialArgs = {
              inherit myZen;
            };

            home-manager.users.karimkandil = ./home.nix;
            programs.mango.enable = true;
          }

          mango.nixosModules.mango
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
