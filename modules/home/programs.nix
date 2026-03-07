{
  pkgs,
  myZen,
  ...
}:
{

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    myZen
    dmidecode
    cmatrix
    cava
    kitty
    neovim
    nil
    nixpkgs-fmt
    nemo
    nodejs
    ffmpeg
    w3m
    gcc
    prismlauncher
    jdk17
    # ESP TOOLS
    cmake
    ninja
    git
    python3
    python3Packages.pip
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
