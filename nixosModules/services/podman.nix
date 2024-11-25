{ config, pkgs, lib, ... }:

{
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  # Pacotes adicionais que uso com podman.
  environment.systemPackages = with pkgs; [
    podman-compose
    distrobox
  ];
}
