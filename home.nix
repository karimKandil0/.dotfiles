{ config, pkgs, lib, zen-browser, ... }:

let
  myZen = zen-browser.packages.${pkgs.system}.default;
in
{
  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";
  home.stateVersion = "25.05";

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

  programs.bash = {
    enable = true; 
    shellAliases = {
      srs = "sudo nixos-rebuild switch --flake ~/.dotfiles#k-nix";
    };
  };


  home.packages = with pkgs; [
    myZen
    dmidecode
    zed-editor
    cmatrix
    gemini-cli
    kitty
    neovim
    nil
    nixpkgs-fmt
    wireshark
    nodejs
    clipit
    gcc
  ];

  xdg.configFile."qtile" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/qtile";
    recursive = true;
  };

  xdg.configFile."i3" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/i3";
    recursive = true;
  };
  
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/nvim";
    recursive = true;
  };
   
  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/hypr";
    recursive = true;
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
