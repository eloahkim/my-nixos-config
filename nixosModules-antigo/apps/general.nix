# Esses são os aplicativos que geralmente gosto de instalar, independente de qualquer DE que escolha.
{ config, pkgs, lib, inputs, ... }:

{
  options.my-nixos.apps.general.enable = lib.mkEnableOption "Instala alguns programas que uso essencialmente em qualquer DE.";
  config = lib.mkIf config.my-nixos.apps.general.enable {
    my-nixos.packages = {
      # Archive
      inherit (pkgs) rar unrar unzip wget zip;

      # Security
      inherit (pkgs) age sops ssh-to-age;
      #veracrypt

      # Video
      inherit (pkgs) yt-dlp;
      #parabolic
      #vlc
      #haruna

      # System
      inherit (pkgs) btop efibootmgr fastfetch rclone rsync;
      #neovim
    };
  };
}
