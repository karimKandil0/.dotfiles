{
  description = "Main Flake";

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

    # FIX: Explicitly set flake = false because the repo lacks a flake.nix
    openclaw = {
      url = "github:openclaw/openclaw";
      flake = false;
    };

    playit-nixos-module.url = "github:playit-cloud/playit-nixos-module";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      playit-nixos-module,
      zen-browser,
      mango,
      openclaw,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      myZen = zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # Define the OpenClaw package so Nix handles the NPM environment for you
      openclawPkg = pkgs.buildNpmPackage {
        pname = "openclaw";
        version = "latest";
        src = openclaw;

        # This hash will fail the first time.
        # Replace it with the "got:" hash from the error message.
        npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

        # OpenClaw prefers newer Node versions
        nodejs = pkgs.nodejs_22;
      };
    in
    {
      nixosConfigurations.k-nix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            home-manager.extraSpecialArgs = {
              inherit
                zen-browser
                pkgs
                myZen
                openclawPkg
                ;
            };
            home-manager.users.karimkandil = {
              imports = [ ./home.nix ];
              # This installs the bot into your user path
              home.packages = [ openclawPkg ];
            };
            programs.mango.enable = true;
          }
          mango.nixosModules.mango
          playit-nixos-module.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit zen-browser; };
      };
    };
}
