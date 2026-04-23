{ config, pkgs, lib, ... }:
# Todas as coisas que costumo usar com o Plasma.
{
  options.my-nixos.desktop.plasma.enable = lib.mkEnableOption "Habilitar Plasma e pacotes relacionados";
  config = lib.mkIf config.my-nixos.desktop.plasma.enable {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    programs.kdeconnect.enable = true;
    programs.partition-manager.enable = true;

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;
    programs.kde-pim = {
      enable = true;
      merkuro = true;
    };
    environment.systemPackages = with pkgs; [
      kdePackages.calendarsupport
      kdePackages.filelight
      kdePackages.kcalc
      kdePackages.kate
    ];
  };
}
