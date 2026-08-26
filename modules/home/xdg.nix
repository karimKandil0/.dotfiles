{ pkgs, ... }:
{
  # Symlink app configs
  xdg.configFile."hypr" = {
    source = ../../config/hypr;
    recursive = true;
  };

  xdg.configFile."qutebrowser" = {
    source = ../../config/qutebrowser;
    recursive = true;
  };

  xdg.configFile."rofi" = {
    source = ../../config/rofi;
    recursive = true;
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };
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
