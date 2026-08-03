{ inputs, ... }:
{
  flake.modules.nixos."services/flatpak" = { inputs, ... }: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    # Habilita o flatpak e declara apps/remotes via nix-flatpak.
    services.flatpak = {
      enable = true;

      # Declarar remotes sobrescreve o default (flathub)
      remotes = [{
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }];
      packages = [
        "com.discordapp.Discord"
        "org.telegram.desktop"
      ];
      uninstallUnmanaged = false;
      update.auto.enable = true;
      uninstallUnused = true;
    };
  };
}
