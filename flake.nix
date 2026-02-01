{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    openclaw = {
      url = "github:openclaw/openclaw";
    };

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
    in
    {
      nixosConfigurations.k-nix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            home-manager.extraSpecialArgs = { inherit zen-browser pkgs myZen; };
            home-manager.users.karimkandil = ./home.nix;
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
