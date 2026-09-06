{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # editor & nix
    neovim
    home-manager
    nil
    nixpkgs-fmt
    vimPlugins.nvim-treesitter-parsers.markdown
    vimPlugins.nvim-treesitter-parsers.markdown_inline

    # core dev
    git
    bun
    nodejs
    python3
    python3Packages.pip
    python3Packages.numpy
    python3Packages.pyserial
    python3Packages.evdev
    python3Packages.virtualenv
    gcc
    gnumake
    cmake
    ninja
    flex
    bison
    gperf
    ccache
    pkg-config
    ncurses
    ffmpeg
    dmidecode

    # ESP32 toolchain
    esptool
    cargo-espmonitor
    dfu-util
    libusb1
  ];
}
