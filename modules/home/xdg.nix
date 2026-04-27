{ pkgs, ... }:
{
  # Symlink app configs
  xdg.configFile."hypr" = {
    source = ../../config/hypr;
    recursive = true;
  };

  # Firefox profile config
  home.file.".mozilla/firefox/t3rrjeev.default/chrome/userChrome.css".source =
    ../../config/firefox/chrome/userChrome.css;
  home.file.".mozilla/firefox/t3rrjeev.default/user.js".source =
    ../../config/firefox/user.js;

  xdg.configFile."qutebrowser" = {
    source = ../../config/qutebrowser;
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

  # Cursor theme
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
