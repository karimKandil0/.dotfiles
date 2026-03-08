{
  description = "karim's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:youwen5/zen-browser-flake";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    playit.url = "github:pedorich-n/playit-nixos-module";

    sops-nix.url = "github:Mic92/sops-nix";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      nix-minecraft,
      playit,
      ...
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
          playit.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          {

            home-manager.useGlobalPkgs = true;

            home-manager.extraSpecialArgs = {
              inherit inputs myZen;
            };

            home-manager.users.karimkandil = {
              imports = [
                ./home.nix
              ];
            };

          }
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
