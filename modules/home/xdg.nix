{ config, pkgs, ... }: {
  xdg.configFile."nvim" = {
    source = ../../config/nvim;
    recursive = true;
  };

  xdg.configFile."hypr" = {
    source = ../../config/hypr;
    recursive = true;
  };

  xdg.configFile."awesome" = {
    source = ../../config/awesome;
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
