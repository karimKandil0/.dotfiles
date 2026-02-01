{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "karimKandil0";
        email = "kimo989yt@gmail.com";
      };
    };
  };

  programs.gh = {
    enable = true;
  };
}
