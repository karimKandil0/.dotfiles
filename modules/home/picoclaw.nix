{ pkgs, config, ... }:

let
  picoclaw-pkg= pkgs.buildGoModule {
    pname = "picoclaw";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "sipeed";
      repo = "picoclaw";
      rev = "main";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    };

    vendorHash = null;
  };
in
{
  home.packages = [ picoclaw-pkg ];
};

