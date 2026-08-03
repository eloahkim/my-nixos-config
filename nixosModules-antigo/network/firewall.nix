{ config, pkgs, lib, ... }:

{
  options.my-nixos.firewall.enable = lib.mkEnableOption "Habilitar firewall";
  config = lib.mkIf config.my-nixos.firewall.enable {
    networking = {
      firewall = {
        enable = true;
        # Syncthing: 4533 (TCP)
        # Jellyfin:  8096 (TCP)
        allowedTCPPorts = [ 4533 8096 ];
        allowedUDPPorts = [  ];
      };
    };
  };
}
