{ config, pkgs, lib, ... }:

{
  options.my-nixos.network.avahi.enable = lib.mkEnableOption "Habilitar Avahi (mDNS/Zeroconf)";
  config = lib.mkIf config.my-nixos.network.avahi.enable {
    services.avahi.enable = true;
  };
}