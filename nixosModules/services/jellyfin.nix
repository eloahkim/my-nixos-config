{ config, pkgs, ... }:
# Minhas configurações Jellyfin
{
  services.jellyfin = {
    enable = true;
    user = "kim";
    openFirewall = true;
    cacheDir = "/home/kim/Dados_externos/jellyfin/cache";
    configDir = "/home/kim/Dados_externos/jellyfin/config";
    dataDir = "/home/kim/Dados_externos/jellyfin/data";
    logDir = "/home/kim/Dados_externos/jellyfin/log";
  };
}
