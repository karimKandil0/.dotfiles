{ pkgs, inputs }:

{

  programs.openclaw = {
    package = inputs.openclaw.packages.${pkgs.system}.openclaw;
    enable = true;
  };

}
