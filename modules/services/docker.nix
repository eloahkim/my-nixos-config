{ ... }:
{
  flake.modules.nixos."services/docker" = { ... }: {
    virtualisation.docker = {
      enable = true;

      # Containers com restart=always sobem junto com o sistema.
      # enableOnBoot = false; # inicia sob demanda via docker.socket

      autoPrune = {
        enable = true;
        dates = "weekly";
        # Sem --all: remove apenas imagens dangling, containers parados,
        # redes sem uso e cache de build. Imagens tagueadas ficam.
      };

      daemon.settings = {
        # Usa o subvolume @containers (nodatacow), que já existe para o Podman,
        # em vez de encher o subvolume @ (root, compress=zstd).
        "data-root" = "/var/lib/containers/docker";
      };
    };
  };
}
