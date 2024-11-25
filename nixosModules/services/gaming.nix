{ config, pkgs, lib, ... }:
{
#   programs.steam = {
#     enable = true;
#     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
#     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#     gamescopeSession.enable = true;
#   };
#
#   programs.steam.extraPackages = with pkgs; [
#     mangohud
#     ];
#
#   programs.gamemode.enable = true;
#   hardware.steam-hardware.enable = true;
#
#   hardware.graphics = {
#     enable = true;
#     enable32Bit = true;
#   };

  environment.systemPackages = with pkgs; [
    lutris
    wineWowPackages.stable
    winetricks
    heroic
  ];
}
