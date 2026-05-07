{
  description = "karim's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:youwen5/zen-browser-flake";
    sops-nix.url = "github:Mic92/sops-nix";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs
    , home-manager
    , zen-browser
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      myZen = zen-browser.packages.${system}.default;
    in
    {
      nixosConfigurations.k-nix = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          inputs.sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              (final: prev: {
                openldap = prev.openldap.overrideAttrs (_: { doCheck = false; });
              })
            ];

	    nixpkgs.config.allowInsecurePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "openclaw" ];

            nix.settings = {
              substituters = [ "https://cache.garnix.io" ];
              trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";

            home-manager.extraSpecialArgs = {
              inherit inputs myZen;
              pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; config.permittedInsecurePackages = [ "openclaw-2026.4.22" ]; };
            };

            home-manager.users.karimkandil = {
              imports = [ ./home.nix ];
            };
          }
        ];
      };

      homeConfigurations.k-nix = home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit inputs myZen; };
      };
    };
}
