{ pkgs, buildGoModule, picoclaw-src, pkg-config, olm, ... }:

let
  buildGo126Module = pkgs.buildGoModule.override { go = pkgs.go_1_26; };
in
buildGo126Module rec {
  pname = "picoclaw";
  version = "latest";

  src = picoclaw-src;

  tags = [ "whatsapp_native" "telegram" "stdjson" ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ olm ];

  vendorHash = "sha256-YA7yLI5Q1InnhigLG3UA9nQHbOiK5gJZ/GIxjKxTYns=";

  proxyVendor = true;

  env = {
    CGO_ENABLED = "1";
  };

  preBuild = ''
    go generate ./...
  '';

  doCheck = false;

  meta = {
    description = "PicoClaw personal AI assistant";
    homepage = "https://github.com/sipeed/picoclaw";
  };
}

