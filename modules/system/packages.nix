{ pkgs, ... }:
{

  ### Allow unfree packages ###
  nixpkgs.config.allowUnfree = true;

  ### Download packages system-wide ###
  environment.systemPackages = with pkgs; [
    codex
    efibootmgr
    cargo
    go
    waybar
    socat
    virt-manager
    qemu
    feh
    git
    aria2
    dig
    shellcheck
    statix
    deadnix
    ruff
    nodePackages.eslint_d
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
    ripgrep
    tree-sitter
    lua
    luarocks
    usbutils
    btop
    docker
    openssl
    zlib
    vial
    curl
    xplr
    kitty
    rcon-cli
    swww
    pywal
    rofi
    fastfetch
    alsa-utils
    pulsemixer
    pulseaudio
    unrar
    tailscale
    tree
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
  programs.firejail.enable = true;
}
