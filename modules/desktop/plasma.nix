{ ... }:
{
  flake.modules.nixos."desktop/plasma" = { pkgs, ... }: {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.xserver.enable = true;
    programs.kdeconnect.enable = true;
    programs.partition-manager.enable = true;
    programs.kde-pim = {
      enable = true;
      merkuro = true;
    };
    my-nixos.packages = {
      inherit (pkgs.kdePackages) calendarsupport filelight kcalc kate;
    };
  };
}
