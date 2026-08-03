{ lib, ... }:
{
  flake.modules.generic.constants = { lib, ... }: {
    options.myConstants = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = { };
    };
  };

  flake.modules.generic.lilith-constants = {
    config.myConstants = {
      username = "kim";
      hostname = "lilith";
      timezone = "America/Maceio";
    };
  };
}
