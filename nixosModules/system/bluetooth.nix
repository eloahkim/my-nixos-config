{ config, pkgs, lib, ... }:
# Isso serve para habilitar bluetooth, principalmente no KDE Plasma.
{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
       };
     };
  };
}
