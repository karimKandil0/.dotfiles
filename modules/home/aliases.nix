{ ... }:
{
  # Shell aliases (bash)
  programs.bash.shellAliases = {
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
    la = "ls -a";

    # OpenClaw stack shortcuts
    oc-native = "openclaw tui --url ws://127.0.0.1:18789 --token \"$(jq -r '.gateway.auth.token' ~/.openclaw/openclaw.json)\"";
    oc-docker = "openclaw tui --url ws://127.0.0.1:18889 --token \"$(jq -r '.gateway.auth.token' ~/.openclaw-docker/openclaw.json)\"";
  };
}
