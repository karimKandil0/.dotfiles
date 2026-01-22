{ config, pkgs, ... }: {
  programs.bash = {
    enable = true;
    shellAliases = {
      srs = "sudo nixos-rebuild switch --flake ~/.dotfiles#k-nix";
      dots = "sudo nvim ~/.dotfiles";
    };
  };
}
