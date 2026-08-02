# Esses são os aplicativos que geralmente gosto de instalar, independente de qualquer DE que escolha.
{ config, pkgs, lib, inputs, ... }:

{
  options.my-nixos.apps.general.enable = lib.mkEnableOption "Instala alguns programas que uso essencialmente em qualquer DE.";
  config = lib.mkIf config.my-nixos.apps.general.enable {
    my-nixos.packages = {
      # Archive
      inherit (pkgs) rar unrar unzip wget zip;

      # Security
      inherit (pkgs) keepassxc age sops ssh-to-age;
      #veracrypt

      # Audio
      inherit (pkgs) picard feishin opus-tools lrcget;

      # Image
      inherit (pkgs) imagemagick;
      #gimp-with-plugins

      # Video
      inherit (pkgs) mpv yt-dlp;
      #parabolic
      #vlc
      #haruna

      # Utilitaries
      inherit (pkgs) android-tools;
      #pipx

      # System
      inherit (pkgs) btop efibootmgr fastfetch rclone rsync syncthing;
      #neovim

      # Web
      inherit (pkgs) brave qbittorrent;
      #telegram-desktop

      # Misc
      inherit (pkgs) libreoffice-qt6-fresh;

      #inputs.helix.packages."${pkgs.system}".helix
    };
  };
}
