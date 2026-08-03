{ ... }:
{
  flake.modules.nixos."network/firewall" = { ... }: {
    networking = {
      firewall = {
        enable = true;
        # Syncthing: 4533 (TCP)
        # Jellyfin:  8096 (TCP)
        allowedTCPPorts = [ 4533 8096 ];
        allowedUDPPorts = [ ];
      };
    };
  };
}
