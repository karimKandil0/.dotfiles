# Karim's NixOS Dotfiles

My personal NixOS configuration using flakes, home-manager and sops-nix.

## Features

• Hyprland Wayland setup  
• Neovim Lua configuration  
• Modular NixOS configuration  
• Encrypted secrets using sops-nix  

## Structure

modules/system → system configuration  
modules/home → home-manager modules  
config → application configs  
secrets → encrypted secrets  

## Install

```bash
git clone https://github.com/karimKandil0/.dotfiles
cd .dotfiles
sudo nixos-rebuild switch --flake .#k-nix
