{ config, pkgs, lib, ... }:

{
  options.my-nixos.firewall.firewalld.enable = lib.mkEnableOption "Habilitar Firewalld como firewall";
  config = lib.mkIf config.my-nixos.firewall.firewalld.enable {
    #services.firewalld = {
    #  enable = true;
    #};

    # Open ports in the firewall.
    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 4533 8096 ];
        allowedUDPPorts = [  ];
      };
      nftables.enable = true;
    };
    services.avahi = {
      enable = true;
    };
  };
}
