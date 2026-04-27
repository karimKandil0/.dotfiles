{ ... }:
{
  # Shell aliases (bash)
  programs.bash.shellAliases = {
    srs = "sudo nixos-rebuild switch --flake ~/.dotfiles#k-nix";
    dots = "nvim ~/.dotfiles";
    conf = "nvim ~/.dotfiles/config";
    services = "nvim ~/.dotfiles/modules/system/services.nix";
    nx = "nix develop";
    ga = "git add";
    gm = "git commit -m";
    gp = "git push";
    dl = "aria2c -d ~/Downloads -x 16 -s 16 -k 1M --file-allocation=none";
    la = "ls -a";

    darlene = "docker exec -it Darlene picoclaw";
  };
}
