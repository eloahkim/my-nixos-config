{ config, pkgs, lib, ... }:
{
  options.my-nixos.services.gaming.enable = lib.mkEnableOption "Habilitar suíte de jogos e relacionados";
  config = lib.mkIf config.my-nixos.services.gaming.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };

    programs.steam.extraPackages = with pkgs; [
      mangohud
      ];

    programs.gamemode.enable = true;
    hardware.steam-hardware.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];


    environment.systemPackages = with pkgs; [
      #dolphin-emu # Emulador de GameCube e Wii.
      heroic
      #prismlauncher # Launcher de Minecraft.
      wineWow64Packages.stable
      winetricks
    ];
  };
}
