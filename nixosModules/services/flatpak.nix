{ config, pkgs, lib, ... }:

{
  options.my-nixos.services.flatpak.enable = lib.mkEnableOption "Habilitar flatpak";
  config = lib.mkIf config.my-nixos.services.flatpak.enable {
    # Habilita o flatpak.
    services.flatpak.enable = true;
  };
}
