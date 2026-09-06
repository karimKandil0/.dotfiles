{
  imports = [
    ./modules/system/core.nix
    ./modules/system/hardware.nix
    ./modules/system/networking.nix
    ./modules/system/packages.nix
    ./modules/system/users.nix
    ./modules/services/minecraft.nix
    ./modules/services/navidrome.nix
    ./modules/services/monitoring.nix
    ./modules/services/adguard.nix
  ];
}
