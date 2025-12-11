{ config, pkgs, lib, zen-browser, ... }:

let
  myZen = zen-browser.packages.${pkgs.system}.default;
in
{
  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";
  home.stateVersion = "25.05";

  programs.git.enable = true;
  programs.bash = {
    enable = true; 
    shellAliases = {
      srs = "sudo nixos-rebuild switch --flake ~/.dotfiles#k-nix";
    };
  };

  programs.zed-editor = {
    enable = true;
  };

  home.packages = with pkgs; [
    myZen
    cmatrix
    gemini-cli
    kitty
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    wireshark
    nodejs
    clipit
    gcc
    chatgpt-cli
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

