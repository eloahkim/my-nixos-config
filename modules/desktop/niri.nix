{ ... }:
{
  flake.modules.nixos."desktop/niri" = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      #useNautilus = true; # Usar Nautilus como file chooser (se estiver instalado)
    };
    services.displayManager.ly.enable = true;
    security.polkit.enable = true; # polkit
    services.gnome.gnome-keyring.enable = true; # secret service
    security.pam.services.swaylock = { };
    ## Utilitário para montar dispositivos.
    services.udisks2.enable = true;
    ## Utilitário para controlar brilho de monitor externo HDMI.
    hardware.i2c.enable = true;
    users.users.kim.extraGroups = [ "i2c" ];
    programs.kdeconnect.enable = true;
    ## Portal para uso no Niri
    xdg.portal = {
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
      ];
      config.niri = {
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
    #programs.waybar.enable = true;
    my-nixos.packages = {
      #alacritty
      inherit (pkgs) qalculate-gtk ncdu ddcutil ranger imv mediainfo kitty
        zathura cliphist wl-clipboard libnotify udiskie xwayland-satellite
        nwg-look adw-gtk3 gnome-themes-extra papirus-icon-theme;
      inherit (pkgs.kdePackages) qt6ct;
      #gammastep
      #fuzzel
      #swaylock
      #mako
      #swayidle
    };
  };
}
