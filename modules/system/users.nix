{ config, pkgs, ... }:

{
  users.users.karimkandil = {
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "wheel" "video" "seat" "input" "uinputl" "plugdev" "seatd" "lp" ];
  };
}
