{ config, pkgs, lib, ... }:

{
  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 4533 8096 ];
   networking.firewall.allowedUDPPorts = [ 4533 8096 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
