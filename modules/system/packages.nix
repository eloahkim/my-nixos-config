{ ... }:
{
  # Collector Aspect: sistema
  flake.modules.nixos.base = { config, lib, ... }: {
    options.my-nixos.packages = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.package;
      default = { };
      description = "Pacotes a instalar no sistema. Módulos contribuem condicionalmente aqui.";
    };

    config.environment.systemPackages = lib.attrValues config.my-nixos.packages;
  };

  # Collector Aspect: home-manager
  flake.modules.homeManager.base = { config, lib, ... }: {
    options.my-nixos.homePackages = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.package;
      default = { };
      description = "Pacotes a instalar no home. Módulos contribuem aqui.";
    };

    config.home.packages = lib.attrValues config.my-nixos.homePackages;
  };
}
