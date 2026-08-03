{ config, pkgs, lib, ... }:
# Minhas configurações Jellyfin
{
  options.my-nixos.services.jellyfin.enable = lib.mkEnableOption "Habilitar jellyfin";
  config = lib.mkIf config.my-nixos.services.jellyfin.enable {
    services.jellyfin = {
      enable = true;
      user = "kim";
      openFirewall = true;
      cacheDir = "/home/kim/Dados_externos/jellyfin/cache";
      configDir = "/home/kim/Dados_externos/jellyfin/config";
      dataDir = "/home/kim/Dados_externos/jellyfin/data";
      logDir = "/home/kim/Dados_externos/jellyfin/log";
    };
  };
}
