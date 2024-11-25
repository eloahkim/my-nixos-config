{ config, pkgs, lib, ... }:

{
  imports = [
    ../apps/applications.nix
  ];

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # GSConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Excluir alguns programas que vem instalados por padrão.
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music # music player
    epiphany # web browser
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
    gnomeExtensions.paperwm
    gnome.gnome-tweaks
    gparted
    rhythmbox
    transmission-gtk
  ];

}
