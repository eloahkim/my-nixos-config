# Esses são os aplicativos que geralmente gosto de instalar, independente de qualquer DE que escolha.
{ config, pkgs, lib, inputs, ... }:

{
  options.my-nixos.apps.general.enable = lib.mkEnableOption "Instala alguns programas que uso essencialmente em qualquer DE.";
  config = lib.mkIf config.my-nixos.apps.general.enable {
    environment.systemPackages = with pkgs; [
      # Archive
      rar
      unrar
      unzip
      wget
      zip

      # Security
      keepassxc
      #veracrypt

      # Audio
      picard
      feishin
      opusTools

      # Image
      imagemagick
      #gimp-with-plugins

      # Video
      #parabolic
      #vlc
      haruna
      yt-dlp

      # Utilitaries
      android-tools
      #pipx

      # System
      btop
      efibootmgr
      fastfetch
      #neovim
      rclone
      rsync
      syncthing

      # Web
      brave
      qbittorrent
      #telegram-desktop

      # Misc
      libreoffice-qt6-fresh

      #inputs.helix.packages."${pkgs.system}".helix
    ];
  };
}
