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
      ## Utilitário para montar dispositivos.
      services.udisks2.enable = true;
      ## Utilitário para controlar brilho de monitor externo HDMI.
      hardware.i2c.enable = true;
      users.users.kim.extraGroups = [ "i2c" ];
      ## Portal para uso no Niri
      xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gnome
      ];

      #programs.waybar.enable = true;
      environment.systemPackages = with pkgs; [
        #alacritty
        qalculate-gtk # Calculadora
        ncdu # Analisador de uso de disco
        ddcutil # Utilitário para controle de brilho
        ranger # Gerenciador de arquivos no terminal
        kitty # terminal
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
