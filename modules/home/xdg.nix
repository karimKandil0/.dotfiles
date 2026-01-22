{ config, pkgs, ... }: {
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/nvim";
    recursive = true;
  };

  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/hypr";
    recursive = true;
  };

  xdg.configFile."qutebrowser/config.py" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/qutebrowser/config.py";
    recursive = true;
  };

  programs.waybar = {
    enable = true;
  };

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/karimkandil/.dotfiles/config/waybar";
    recursive = true;
  };
 
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
