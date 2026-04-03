{ config, pkgs, ... }:
{

  hardware.uinput.enable = true;
  boot.kernelPackages = pkgs.linuxPackages;

  powerManagement.cpuFreqGovernor = "performance";
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
  zramSwap.memoryPercent = 20;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "intel_pstate=active"
  ];

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
