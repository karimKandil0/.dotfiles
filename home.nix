{ config, pkgs, zen-browser, zed, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.dotfiles/config";

  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.username = "karimkandil";
  home.homeDirectory = "/home/karimkandil";

  programs.git.enable = true;

  home.stateVersion = "25.05";

  programs.kitty.settings = {
    shell = "bash --login";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      PS1="\w $ "
    '';
  };
  xdg.configFile."niri" = {
    source = create_symlink "${dotfiles}/niri/";
    recursive = true;
  };


  xdg.configFile."nvim" = {
    source = create_symlink "${dotfiles}/nvim/";
    recursive = true;
  };

  # xdg.configFile."kitty" = {
  #  source = create_symlink "${dotfiles}/kitty/";
  #  recursive = true;
  #};


  home.packages = with pkgs;
    [
      neovim
      ripgrep
      nil
      vlc
      nixpkgs-fmt
      nodejs
      gcc
      dnsutils
      playerctl
      cava
      cmatrix
      rustc
      pipes
      wofi
      tmux
      rustup
      zen-browser.packages.${pkgs.system}.default
      glib
      libsecret
      dbus
      zed.packages.${pkgs.system}.default
    ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    size = 12;
    package = pkgs.bibata-cursors;
  };

  xdg.desktopEntries.zen-browser = {
    name = "Zen Browser";
    exec = "zen-browser";
    terminal = false;
    icon = "zen-browser";
    categories = [ "Network" "WebBrowser" ];
  };

}
