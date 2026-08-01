{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  options.my-nixos.services.flatpak.enable = lib.mkEnableOption "Habilitar flatpak";
  config = lib.mkIf config.my-nixos.services.flatpak.enable {
    # Habilita o flatpak e declara apps/remotes via nix-flatpak.
    services.flatpak = {
      enable = true;

      # Declarar remotes sobrescreve o default (flathub), então o incluímos.
      remotes = [{
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }];

      packages = [
        "com.discordapp.Discord"
        "org.telegram.desktop"
      ];

      # false no início: só gerencia o que está declarado acima.
      uninstallUnmanaged = false;

      update.auto.enable = true;
    };
  };
}
