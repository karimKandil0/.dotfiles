{ pkgs, myZen, ... }:
{

  ### User specific packages ###

  home.packages = with pkgs; [
    myZen
    dmidecode
    cmatrix
    hyprshot
    cava
    kitty
    neovim
    mako
    hyprlock
    libnotify
    home-manager
    nil
    nixpkgs-fmt
    nemo
    nodejs
    ffmpeg
    w3m
    gcc
    prismlauncher
    jdk17
    typioca
    cmake
    ninja
    git
    python3
    python3Packages.pip
    python3Packages.tinytuya
    python3Packages.numpy
    python3Packages.pyaudio
    python3Packages.evdev
    python3Packages.virtualenv
    gnumake
    flex
    bison
    gperf
    ccache
    dfu-util
    libusb1
    python3Packages.pyserial
    ncurses
    pkg-config
    esptool
    cargo-espmonitor
  ];

}
