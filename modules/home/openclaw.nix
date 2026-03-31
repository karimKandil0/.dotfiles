{ pkgs, config, lib, inputs, ... }:

{

 ### Define openclaw and download it ###
   
  programs.openclaw = {
    enable = true;
  };

}
