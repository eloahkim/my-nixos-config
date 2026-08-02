{ config, lib, ... }:
# Guarda-rails: impede combinações inválidas de configuração.
{
  options.my-nixos.system.assertions.enable = lib.mkEnableOption "Guarda-rails de configuração (assertions)";

  config = lib.mkIf config.my-nixos.system.assertions.enable {
    assertions = [{
      assertion =
        lib.length (
          lib.filter (x: x) [
            config.my-nixos.desktop.mango.enable
            config.my-nixos.desktop.plasma.enable
            config.my-nixos.desktop.gnome.enable
            config.my-nixos.desktop.niri.enable
          ]
        ) <= 1;
      message = ''
        Mais de um desktop environment foi habilitado em my-nixos.desktop.
        Ligue apenas um: mango, plasma, gnome ou niri.
      '';
    }];
  };
}
