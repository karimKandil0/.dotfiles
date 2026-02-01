{ pkgs, myZen, ... }:
{
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

  programs.openclaw = {
    enable = true;
    settings = {
      provider = "ollama";
      ollama = {
        baseUrl = "http://127.0.0.1:11434";
        model = "llama3.1:8b";
      };
    };
  };

}
