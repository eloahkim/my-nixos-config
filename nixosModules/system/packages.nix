{ config, lib, ... }:
# Acumulador de pacotes: qualquer módulo contribui com pacotes em
# my-nixos.packages e este módulo instala tudo num único ponto.
{
  options.my-nixos.packages = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.package;
    default = { };
    description = "Pacotes a instalar no sistema. Módulos contribuem condicionalmente aqui.";
  };

  config.environment.systemPackages = lib.attrValues config.my-nixos.packages;
}
