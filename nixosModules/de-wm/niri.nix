{ config, pkgs, lib, inputs, ... }:
# Módulo de instalação do Niri.
{
    options.my-nixos.desktop.niri.enable = lib.mkEnableOption "Habilitar Niri e pacotes relacionados";
    config = lib.mkIf config.my-nixos.desktop.niri.enable {
      programs.niri.enable = true;
      services.displayManager.ly.enable = true;
      security.polkit.enable = true; # polkit
      services.gnome.gnome-keyring.enable = true; # secret service
      security.pam.services.swaylock = {};
      services.udisks2.enable = true;
      hardware.i2c.enable = true;
      users.users.kim.extraGroups = [ "i2c" ];
      xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gnome
      ];

      #programs.waybar.enable = true;
      environment.systemPackages = with pkgs; [
        #alacritty
        qalculate-gtk
        ncdu
	ddcutil
	ranger
        kitty
        cliphist
        wl-clipboard
        libnotify
	udiskie
	xwayland-satellite
	nwg-look
	adw-gtk3
	gnome-themes-extra
	kdePackages.qt6ct
	papirus-icon-theme
        #gammastep
        #fuzzel
        #swaylock
        #mako
        #swayidle
      ];
    };
}
