{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  options.my-nixos.desktop.mango.enable = lib.mkEnableOption "Habilitar Mango (Wayland compositor)";
  config = lib.mkIf config.my-nixos.desktop.mango.enable {
    programs.mango.enable = true;
    programs.dconf.enable = true;

    services.displayManager.ly = {
      enable = true;
      settings = {
        numlock = true;
	animation = "matrix";
      };
    };
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = {};

    services.udisks2.enable = true;

    hardware.i2c.enable = true;
    users.users.kim.extraGroups = [ "i2c" ];

    programs.kdeconnect.enable = true;

    xdg.portal = {
      wlr.enable = true;
      wlr.settings.screencast = {
    	chooser_type = "dmenu";
    	chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu";
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    my-nixos.packages = {
      inherit (pkgs) qalculate-gtk ncdu ddcutil imv mediainfo foot rofi zathura
        cliphist wl-clipboard libnotify udiskie nwg-look glib
        gsettings-desktop-schemas adw-gtk3 gnome-themes-extra bibata-cursors
        papirus-icon-theme;
      inherit (pkgs.kdePackages) qt6ct;
    };
  };
}
