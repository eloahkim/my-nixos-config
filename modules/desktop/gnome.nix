{ ... }:
{
  flake.modules.nixos."desktop/gnome" = { pkgs, ... }: {
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # GSConnect
    programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    # Excluir alguns programas que vem instalados por padrão.
    environment.gnome.excludePackages = with pkgs; [
      gnome-music # music player
      epiphany # web browser
    ];

    my-nixos.packages = {
      inherit (pkgs.gnomeExtensions) appindicator "pop-shell" paperwm;
      inherit (pkgs) gnome-tweaks gparted rhythmbox transmission_4-gtk;
    };
  };
}
