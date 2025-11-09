{
  description = "k-nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zed.url = "github:zed-industries/zed";
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, zed, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.k-nix = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager

          {
            home-manager.users.karimkandil = {
              imports = [ ./home.nix ];
            };

            # 👇 Pass flake inputs and system into Home Manager modules
            home-manager.extraSpecialArgs = {
              inherit system zen-browser zed;
            };
          }
        ];
      };
    };
}
