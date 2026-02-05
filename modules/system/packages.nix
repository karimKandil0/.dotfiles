{ config, pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
      git
      zed-editor
      bibata-cursors
      usb-modeswitch
      nodejs_22
      ffmpeg-full
      chromium
      foot
      age
      libdrm
      meson
      ninja
      libdisplay-info
      libliftoff
      hwdata
      seatd
      pcre2
      glibc
      vim
      ifuse
      altserver-linux
      discord
      ripgrep
      tree-sitter
      lua
      luarocks
      antimicrox
      remote-touchpad
      wofi
      rofi
      usbutils
      btop
      ncdu
      fzf
      bat
      docker
      openssl
      zlib
      vial
      curl
      xplr
      kitty
      rcon-cli
      firefox
      swww
      thonny
      pywal
      rofi
      fastfetch
      alsa-utils
      pulsemixer
      pulseaudio
      unrar
      tailscale
      tree
      wine
      winetricks
      lutris
      bluez-tools
      python3
      (python3.withPackages (ps: [
                ps.nbtlib
      ]))
    ];
       
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
    
    services.udev.packages = [ pkgs.vial pkgs.game-devices-udev-rules ];
    
    programs.steam.enable = true;
    programs.gamemode.enable = true;
    services.usbmuxd.enable = true;
}
