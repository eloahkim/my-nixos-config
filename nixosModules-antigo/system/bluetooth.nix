{ config, pkgs, lib, ... }:
# Isso serve para habilitar bluetooth, principalmente no KDE Plasma.
{
  options.my-nixos.system.bluetooth.enable = lib.mkEnableOption "Habilitar bluetooth";
  config = lib.mkIf config.my-nixos.system.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
