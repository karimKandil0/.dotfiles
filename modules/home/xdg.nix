{ pkgs, ... }:
{
  # Symlink app configs
  xdg.configFile."hypr" = {
    source = ../../config/hypr;
    recursive = true;
  };

  home.file.".config/hypr/hypridle.conf" = {
    source = ../../config/hypr/hypridle.conf;
    target = ".config/hypr/hypridle.conf";
  };

  xdg.configFile."nvim" = {
    source = ../../config/nvim;
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = ../../config/waybar;
    recursive = true;
  };

  xdg.configFile."mako" = {
    source = ../../config/mako;
    recursive = true;
  };

  xdg.configFile."niri" = {
    source = ../../config/niri;
    recursive = true;
  };

  xdg.configFile."kitty" = {
    source = ../../config/kitty;
    recursive = true;
  };

  # Cursor theme
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
