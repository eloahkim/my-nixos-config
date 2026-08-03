{ ... }:
{
  flake.modules.nixos."services/podman" = { pkgs, ... }: {
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
