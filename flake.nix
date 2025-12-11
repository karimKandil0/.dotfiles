{
  description = "Minimal NixOS + Home Manager flake with Hyprland and zen-browser";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Keep your zen-browser flake
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
            home-manager.users.karimkandil = import ./home.nix;
          }
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit zen-browser; };
      };
    };
}

