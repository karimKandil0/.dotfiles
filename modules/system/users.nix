{ config, pkgs, ... }:

{

  ### User permissions ###
  users.users.karimkandil = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "video"
      "seat"
      "input"
      "uinputl"
      "plugdev"
      "seatd"
      "lp"
      "dialout"
      "libvirtd"
    ];
  };
}
