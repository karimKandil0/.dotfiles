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
    gemini-cli
    cava
    kitty
    neovim
    nil
    tor-browser
    nixpkgs-fmt
    wireshark
    nemo
    nodejs
    ffmpeg
    yt-dlp
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
