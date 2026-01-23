{ config, pkgs, lib, zen-browser, ... }:

{
  imports = [
    ./modules/home/aliases.nix
    ./modules/home/git.nix
    ./modules/home/programs.nix
    ./modules/home/xdg.nix
  ];

  # General #
  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";
  home.stateVersion = "25.11";
}
