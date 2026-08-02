{ osConfig, pkgs, lib, ... }:
{
  config = lib.mkIf osConfig.my-nixos.apps.general.enable {
    home.packages = with pkgs; [
      picard feishin opus-tools lrcget imagemagick yt-dlp
      android-tools brave qbittorrent libreoffice-qt6-fresh keepassxc
    ];
  };
}