{ inputs, ... }:
{
  imports = [
    ./modules/home/aliases.nix
    ./modules/home/git.nix
    ./modules/home/programs.nix
    ./modules/home/xdg.nix
    ./modules/home/openclaw.nix
    inputs.openclaw.homeManagerModules.openclaw
  ];

  # Base Home Manager identity/state
  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    AOC_SESSION = "53616c7465645f5f42009143bad7ccc3dc0c66f4b08318323a7b2c018d451ddfdf4dad3db828e90f56a7f6bd1878d5ead4bad95982f3c3cbe5c8614346491cfa";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # Clear the sourced marker so variables are refreshed.
      unset __HM_SESS_VARS_SOURCED

      # Prefer the modern XDG profile path, then fall back to legacy.
      if [ -f "$HOME/.local/state/nix/profiles/home-manager/etc/profile.d/hm-session-vars.sh" ]; then
        source "$HOME/.local/state/nix/profiles/home-manager/etc/profile.d/hm-session-vars.sh"
      elif [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';
  };
}
