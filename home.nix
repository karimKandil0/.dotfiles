{
  config,
  pkgs,
  lib,
  zen-browser,
  inputs,
  ...
}:

{
  imports = [
    ./modules/home/aliases.nix
    ./modules/home/git.nix
    ./modules/home/programs.nix
    ./modules/home/xdg.nix
  ];

  # General #
  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";
  home.stateVersion = "25.11";
  home.sessionVariables = {
    AOC_SESSION = "53616c7465645f5f42009143bad7ccc3dc0c66f4b08318323a7b2c018d451ddfdf4dad3db828e90f56a7f6bd1878d5ead4bad95982f3c3cbe5c8614346491cfa";
  };
  programs.bash = {
    enable = true;
    initExtra = ''
      unset __HM_SESS_VARS_SOURCED
      source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    '';
  };

}
