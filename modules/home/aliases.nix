{ config, pkgs, ... }: {
  programs.bash = {
    enable = true;
    shellAliases = {
      srs = "sudo nixos-rebuild switch --flake ~/.dotfiles#k-nix";
      dots = "nvim ~/.dotfiles";
      conf = "nvim ~/.dotfiles/config";
      darlene = "~/Darlene/Darlene.sh";
      services = "nvim ~/.dotfiles/modules/system/services.nix";
      nx = "nix develop";
      ga = "git add";
      gm = "git commit -m";
      gp = "git push";
      dl = "aria2c -d ~/Downloads -x 16 -s 16 -k 1M --file-allocation=none";
    };
  };

}
