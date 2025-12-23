{
  description = "Minimal NixOS + Home Manager flake with Hyprland and zen-browser";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.k-nix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            home-manager.extraSpecialArgs = { inherit zen-browser; };
            home-manager.users.karimkandil = ./home.nix;
          }
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit zen-browser; };
      };
    };
}
