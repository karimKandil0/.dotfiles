{
  config,
  pkgs,
  lib,
  zen-browser,
  inputs,
  ...
}:

{
  imports = [
    ./modules/home/aliases.nix
    ./modules/home/git.nix
    ./modules/home/programs.nix
    ./modules/home/xdg.nix
    inputs.openclaw.homeManagerModules.openclaw
  ];

  # General #
  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";
  home.stateVersion = "25.11";

  programs.openclaw = {
    enable = true;
    documents = ./Darlene;

  };
}
