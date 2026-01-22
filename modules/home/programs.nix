{ pkgs, myZen, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    myZen
    dmidecode
    cmatrix
    gemini-cli
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
  ];
}
