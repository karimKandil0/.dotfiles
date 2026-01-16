{ config, pkgs, lib, zen-browser, ... }:

let
  myZen = zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{

  # General #

  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";
  home.stateVersion = "25.11";
  # Git Config #

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "karimKandil0";
        email = "kimo989yt@gmail.com";
      };
    };
  };

  programs.gh = {
    enable = true;
  };

  # Shell #

  programs.bash = {
    enable = true;
    shellAliases = {
      srs = "sudo nixos-rebuild switch --flake ~/.dotfiles#k-nix";
      dots = "sudo nvim ~/.dotfiles";
    };
  };

  # Pkgs #

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    myZen
    dmidecode
    cmatrix
    gemini-cli
    kitty
    neovim
    nil
    tor-browser
    nixpkgs-fmt
    wireshark
    nemo
    nodejs
    w3m
    gcc
    prismlauncher
    jdk17
  ];

  # SymLinks #

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/nvim";
    recursive = true;
  };

  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/hypr";
    recursive = true;
  };

  xdg.configFile."qutebrowser/config.py" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/qutebrowser/config.py";
    recursive = true;
  };

  programs.waybar = {
    enable = true;
  };

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/waybar";
    recursive = true;
  };
 
   # Other #

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
