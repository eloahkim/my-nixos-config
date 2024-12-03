# Esses são os aplicativos que geralmente gosto de instalar, independente de qualquer DE que escolha.
{ config, pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Archive
    rar
    unrar
    unzip
    wget
    zip

    # Security
    keepassxc
    veracrypt

    # Audio
    eartag
    feishin
    opusTools

    # Image
    imagemagick
    gimp-with-plugins

    # Video
    #parabolic
    vlc
    yt-dlp

    # Utilitaries
    android-tools
    pipx

    # System
    btop
    efibootmgr
    fastfetch
    neovim
    rclone
    rsync
    syncthing

    # Web
    brave
    qbittorrent
    #telegram-desktop

    # Misc
    libreoffice-qt6-fresh
    dialect

    #inputs.helix.packages."${pkgs.system}".helix
  ];
}
