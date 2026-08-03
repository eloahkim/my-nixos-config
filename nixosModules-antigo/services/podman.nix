{ config, pkgs, lib, ... }:

{
  options.my-nixos.services.podman.enable = lib.mkEnableOption "Habilitar podman";
  config = lib.mkIf config.my-nixos.services.podman.enable {
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    # Pacotes adicionais que uso com podman.
    my-nixos.packages = {
      inherit (pkgs) podman-compose distrobox;
    };
  };
}
