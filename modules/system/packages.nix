{ config, pkgs, ... }:
{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    codex
    efibootmgr
    javaPackages.compiler.semeru-bin.jdk-8
    x3270
    go
    virt-manager
    qemu
    feh
    git
    aria2
    dig
    shellcheck
    zip
    gettext
    tmux
    sops
    age
    unzip
    zed-editor
    bibata-cursors
    nodejs
    yarn
    nodePackages.eas-cli
    libdrm
    meson
    ninja
    libdisplay-info
    libliftoff
    hwdata
    seatd
    pcre2
    glibc
    vim
    ifuse
    altserver-linux
    discord
    ripgrep
    tree-sitter
    lua
    luarocks
    antimicrox
    wofi
    rofi
    usbutils
    btop
    ncdu
    fzf
    bat
    docker
    openssl
    zlib
    vial
    curl
    xplr
    kitty
    rcon-cli
    swww
    thonny
    pywal
    rofi
    fastfetch
    alsa-utils
    pulsemixer
    pulseaudio
    unrar
    tailscale
    tree
    wine
    lutris
    python3
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.udev.packages = [
    pkgs.vial
    pkgs.game-devices-udev-rules
  ];

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
