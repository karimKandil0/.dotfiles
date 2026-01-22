{ config, pkgs, ... }: {
  hardware.uinput.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  boot.extraModprobeConfig = ''
    options snd-hda-intel model=alc221-hp-mic
  '';
  hardware.keyboard.qmk.enable = true;
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", KERNEL=="ttyACM*", MODE="0666", GROUP="dialout"

    # Sunshine rule
    KERNEL=="uinput", MODE="0660", GROUP="input", SYMLINK+="uinput"

    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';
}
