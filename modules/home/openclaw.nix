{ pkgs, inputs, ... }:

{

  imports = [
    inputs.openclaw.homeManagerModules.openclaw
  ];

  programs.openclaw = {
    enable = true;
    documents = ./documents;
    anthropic.enable = false;
    google = {
      enable = true;
      keyFile = "/home/karimkandil/.secrets/gemini-key";
      model = "gemini-3-flash-preview";
    };

  };
}
