{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # version control & dev
    git
    cargo
    rust-analyzer
    nodejs
    yarn
    python3

    # shell & system tools
    vim
    tmux
    btop
    curl
    wget
    ripgrep
    tree
    fastfetch
    unzip
    zip
    unrar
    aria2
    dig
    gettext
    usbutils

    # AI
    claude-code

    # nix tooling
    sops
    age
    statix
    deadnix
    shellcheck

    # python tooling
    ruff

    # server utils
    openssl
    zlib
    docker
    rcon-cli
  ];
}
