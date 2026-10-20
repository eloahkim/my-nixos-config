{ ... }:
{
  flake.modules.nixos."desktop/gnome" = { pkgs, ... }: {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.gnome = {
      core-apps.enable = true;
      core-developer-tools.enable = false;
    };

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
      inherit (pkgs) gnome-tweaks refine gparted rhythmbox transmission_4-gtk;
    };
  };
}
