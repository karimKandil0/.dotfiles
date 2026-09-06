{ ... }:
{
  services.syncthing = {
    enable = true;
    user = "karimkandil";
    dataDir = "/home/karimkandil";
    configDir = "/home/karimkandil/.config/syncthing";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
  };
}
